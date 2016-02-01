#include <iostream>
#include "twitcurl.h"
#include "oauthlib.h"
#include "include/curl/curl.h"
#include "include/curl/curlrules.h"
#include "include/curl/easy.h"
#include "include/curl/multi.h"
#include "include/curl/typecheck-gcc.h"
#include "include/curl/curlbuild.h"
#include "include/curl/curlver.h"
#include "include/curl/mprintf.h"
#include "include/curl/stdcheaders.h"

int main(){
	
	twitCurl tweet;
	string const m_twitterUsername;
	
	string const m_twitterPassword;


	cout <<"Insira seu username:"<<endl;
	getline (cin,m_twitterUsername);
	tweet.setTwitterUsername(m_twitterUsername);

	cout<<"Insira seu password"<<endl;
	getline(cin, m_twitterPassword);
	tweet.setTwitterPassword(m_twitterPassword);


}