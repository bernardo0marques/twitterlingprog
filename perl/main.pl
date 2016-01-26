#!/usr/bin/perl
use strict;
use warnings;
 
use openFile ':all';
use listHashtagMention ':all';
#use func2 ':all';
#use func3 ':all';
#use func4 ':all';
#use func5 ':all';
 

my $texto = openFile::openFile('teste.txt');

print $texto;

print "Listagem: \n";

listHashtagMention::listHashtagMention('teste.txt');

