#Autores:  Bernardo Marques e Gabriel Pimentel

package searchWords;

use warnings;
use strict;
use 5.012;

our %EXPORT_TAGS = ( 'all' => [qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	searchWords
);

require Exporter;
our @ISA = qw(Exporter);

our $VERSION = '0.01';

sub searchWords{
	(my $nomedoArquivo)= @_;
	
	my $countPalavras=0;
	my $str;
	my @line;
	my $string;
	my $palavraProcurada;
	
	$string = openFile::openFile($nomedoArquivo);
	@line = split ('/\s+/', $string);
	
	print "Qual palavra voce procura? ";
	$palavraProcurada = <STDIN>;
	
	foreach $str (@line) { 
		if ($str =~ $palavraProcurada){ #busca da palavra
			$countPalavras++;
		}
	}
	if ($countPalavras == 0){
			print "Nao foi encontrada a palavra procurada ", $palavraProcurada;
		}
		if ($countPalavras>0){
			print "Foi encontrada a palavra procurada ",$palavraProcurada, $countPalavras, "vez(es)";
		}
}

1; 