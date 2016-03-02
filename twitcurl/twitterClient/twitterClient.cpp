//Universidade Federal do Rio de Janeiro
//Autores:  Bernardo Marques e Gabriel Pimentel
//Linguagens de Programação

#include "twitterClient.h"

void printUsage()
{
    printf( "\nUsage:\ntwitterClient -u username -p password\n" );
}

int main( int argc, char* argv[] )
{
    /* Get username and password from command line args */
    std::string userName( "" );
    std::string passWord( "" );
    if( argc > 4 )
    {
        for( int i = 1; i < argc; i += 2 )
        {
            if( 0 == strncmp( argv[i], "-u", strlen("-u") ) )
            {
                userName = argv[i+1];
            }
            else if( 0 == strncmp( argv[i], "-p", strlen("-p") ) )
            {
                passWord = argv[i+1];
            }
        }
        if( ( 0 == userName.length() ) || ( 0 == passWord.length() ) )
        {
            printUsage();
            return 0;
        }
    }
    else
    {
        printUsage();
        return 0;
    }

    twitCurl twitterObj;
    std::string tmpStr, tmpStr2;
    std::string replyMsg;
    char tmpBuf[1024];

    /* Set twitter username and password */
    twitterObj.setTwitterUsername( userName );
    twitterObj.setTwitterPassword( passWord );

    /* Set proxy server usename, password, IP and port (if present) */
    memset( tmpBuf, 0, 1024 );
    printf( "\nDo you have a proxy server configured (0 for no; 1 for yes): " );
    gets( tmpBuf );
    tmpStr = tmpBuf;
    if( std::string::npos != tmpStr.find( "1" ) )
    {
        memset( tmpBuf, 0, 1024 );
        printf( "\nEnter proxy server IP: " );
        gets( tmpBuf );
        tmpStr = tmpBuf;
        twitterObj.setProxyServerIp( tmpStr );

        memset( tmpBuf, 0, 1024 );
        printf( "\nEnter proxy server port: " );
        gets( tmpBuf );
        tmpStr = tmpBuf;
        twitterObj.setProxyServerPort( tmpStr );

        memset( tmpBuf, 0, 1024 );
        printf( "\nEnter proxy server username: " );
        gets( tmpBuf );
        tmpStr = tmpBuf;
        twitterObj.setProxyUserName( tmpStr );

        memset( tmpBuf, 0, 1024 );
        printf( "\nEnter proxy server password: " );
        gets( tmpBuf );
        tmpStr = tmpBuf;
        twitterObj.setProxyPassword( tmpStr );
    }

    /* OAuth flow begins */
    /* Step 0: Set OAuth related params. These are got by registering your app at twitter.com */
    twitterObj.getOAuth().setConsumerKey( std::string( "mQmCzVVbs6j3d1HXQH0YduaT5" ) );
    twitterObj.getOAuth().setConsumerSecret( std::string( "tYhfU2eItgP6W4QoLMCRLSoqvZYcEiuuMCQMQrTM0dB09nxpFP" ) );

    /* Step 1: Check if we alredy have OAuth access token from a previous run */
    std::string myOAuthAccessTokenKey("");
    std::string myOAuthAccessTokenSecret("");
    std::ifstream oAuthTokenKeyIn;
    std::ifstream oAuthTokenSecretIn;

    oAuthTokenKeyIn.open( "twitterClient_token_key.txt" );
    oAuthTokenSecretIn.open( "twitterClient_token_secret.txt" );

    memset( tmpBuf, 0, 1024 );
    oAuthTokenKeyIn >> tmpBuf;
    myOAuthAccessTokenKey = tmpBuf;

    memset( tmpBuf, 0, 1024 );
    oAuthTokenSecretIn >> tmpBuf;
    myOAuthAccessTokenSecret = tmpBuf;

    oAuthTokenKeyIn.close();
    oAuthTokenSecretIn.close();

    if( myOAuthAccessTokenKey.size() && myOAuthAccessTokenSecret.size() )
    {
        /* If we already have these keys, then no need to go through auth again */
        printf( "\nUsing:\nKey: %s\nSecret: %s\n\n", myOAuthAccessTokenKey.c_str(), myOAuthAccessTokenSecret.c_str() );

        twitterObj.getOAuth().setOAuthTokenKey( myOAuthAccessTokenKey );
        twitterObj.getOAuth().setOAuthTokenSecret( myOAuthAccessTokenSecret );
    }
    else
    {
        /* Step 2: Get request token key and secret */
        std::string authUrl;
        twitterObj.oAuthRequestToken( authUrl );

        /* Step 3: Get PIN  */
        memset( tmpBuf, 0, 1024 );
        printf( "\nDo you want to visit twitter.com for PIN (0 for no; 1 for yes): " );
        gets( tmpBuf );
        tmpStr = tmpBuf;
        if( std::string::npos != tmpStr.find( "1" ) )
        {
            /* Ask user to visit twitter.com auth page and get PIN */
            memset( tmpBuf, 0, 1024 );
            printf( "\nPlease visit this link in web browser and authorize this application:\n%s", authUrl.c_str() );
            printf( "\nEnter the PIN provided by twitter: " );
            gets( tmpBuf );
            tmpStr = tmpBuf;
            twitterObj.getOAuth().setOAuthPin( tmpStr );
        }
        else
        {
            /* Else, pass auth url to twitCurl and get it via twitCurl PIN handling */
            twitterObj.oAuthHandlePIN( authUrl );
        }

        /* Step 4: Exchange request token with access token */
        twitterObj.oAuthAccessToken();

        /* Step 5: Now, save this access token key and secret for future use without PIN */
        twitterObj.getOAuth().getOAuthTokenKey( myOAuthAccessTokenKey );
        twitterObj.getOAuth().getOAuthTokenSecret( myOAuthAccessTokenSecret );

        /* Step 6: Save these keys in a file or wherever */
        std::ofstream oAuthTokenKeyOut;
        std::ofstream oAuthTokenSecretOut;

        oAuthTokenKeyOut.open( "twitterClient_token_key.txt" );
        oAuthTokenSecretOut.open( "twitterClient_token_secret.txt" );

        oAuthTokenKeyOut.clear();
        oAuthTokenSecretOut.clear();

        oAuthTokenKeyOut << myOAuthAccessTokenKey.c_str();
        oAuthTokenSecretOut << myOAuthAccessTokenSecret.c_str();

        oAuthTokenKeyOut.close();
        oAuthTokenSecretOut.close();
    }
    /* OAuth flow ends */

    /* Get user timeline */
    replyMsg = "";
    printf( "\nGetting user timeline\n" );
    if( twitterObj.timelineUserGet( true, true, 0 ) )
    {
        twitterObj.getLastWebResponse( replyMsg );
        printf( "\ntwitterClient:: twitCurl::timelineUserGet web response:\n%s\n", replyMsg.c_str() );
    }
    else
    {
        twitterObj.getLastCurlError( replyMsg );
        printf( "\ntwitterClient:: twitCurl::timelineUserGet error:\n%s\n", replyMsg.c_str() );
    }

    /* Post a new status message */
    memset( tmpBuf, 0, 1024 );
    printf( "\nEnter a new status message: " );
    gets( tmpBuf );
    tmpStr = tmpBuf;
    replyMsg = "";
    if( twitterObj.statusUpdate( tmpStr ) )
    {
        twitterObj.getLastWebResponse( replyMsg );
        printf( "\ntwitterClient:: twitCurl::statusUpdate web response:\n%s\n", replyMsg.c_str() );
    }
    else
    {
        twitterObj.getLastCurlError( replyMsg );
        printf( "\ntwitterClient:: twitCurl::statusUpdate error:\n%s\n", replyMsg.c_str() );
    }

    return 0;
}

