use strict;
use warnings;

use 5.012;

#use openFile;
#use searchWords;
#use contagemCaracteres;
#use listHashtagMention;

require Exporter;
our @ISA = qw(Exporter);

 
#use openFile;
#use listHashtagMention;
use searchWords;
#use ContagemCaracteres;
#use dateValue;
#use TwitterPerl;
#use func4 ':all';
#use func5 ':all';
 

#my $texto = openFile('teste.txt');
#print $texto;
#print $texto;

#print "Listagem: \n";

#dateValue('date1.txt');

#listHashtagMention('teste.txt');

#print "Procura de Hashtags: \n";

searchWords('teste.txt');

