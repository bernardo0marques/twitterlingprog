#Autores:  Bernardo Marques e Gabriel Pimentel

package openFile;

use warnings;
use strict;
use 5.012;

our %EXPORT_TAGS = ( 'all' => [qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	searchWords
);

our $VERSION = '0.01';

sub searchWords{
	 print "Qual hashtag voce procura?";
	 my $palavraProcurada= <STDIN>;
	
	 foreach (@line) { 
		if ($palavraProcurada){ #busca da palavra
			$countPalavras++;
		 }
		
		if ($countPalavras == 0){
			print "Nao foi encontrada a palavra procurada", $palavraProcurada;
		}
		if ($countPalavras>0){
			print "Foi encontrada a palavra procurada", $palavraProcurada "," $countPalavras "vezes";
		}
	}
}

1;