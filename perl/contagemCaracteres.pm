#Autores:  Bernardo Marques e Gabriel Pimentel

package contagemCaracteres;

use openFile;
use warnings;
use strict;
use 5.012;

our %EXPORT_TAGS = ( 'all' => [qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

require Exporter;
our @ISA = qw(Exporter);

our @EXPORT = qw(
	contagemCaracteres
);

our $VERSION = '0.01';

sub contagemCaracteres {
	(my $arquivo) =@_;
	my $tamanhoString = 0;
	my $string;
	
	$string = openFile($arquivo);
	$tamanhoString = length($string); #funcao length conta os caracteres do arquivo inserido
	
	print "O tweet tem ", $tamanhoString, " caracteres. \n";
	
}

1;