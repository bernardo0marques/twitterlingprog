#include <iostream>
#include "twitcurl.h"
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
	string* const username;
	string* const password;


	cout <<"Insira seu username:"<<endl;
	getline (cin,username);
	twitCurl.setTwitterUsername(username);

	cout<<"Insira seu password"<<endl;
	getline(cin, password);
	twitCurl.setTwitterPassword(password);


}