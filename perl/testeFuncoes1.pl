#!/usr/bin/perl
use strict;
use warnings;
 
use openFile ':all';
#use listHashtagMention ':all';
use searchWords ':all';
#use contagemCaracteres ':all';
#use func4 ':all';
#use func5 ':all';
 

my $texto = openFile::openFile('teste.txt');

print $texto;

#print "Listagem: \n";

#listHashtagMention::listHashtagMention('teste.txt');

#print "Procura de Hashtags: \n";

searchWords::searchWords('teste.txt');

#contagemCaracteres::contagemCaracteres('teste.txt');