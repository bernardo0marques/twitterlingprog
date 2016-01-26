#Autores:  Bernardo Marques e Gabriel Pimentel

package contagemCaracteres;

use warnings;
use strict;
use 5.012;

our %EXPORT_TAGS = ( 'all' => [qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	contagemCaracteres
);

our $VERSION = '0.01';

sub contagemCaracteres {
	(my $arquivo) =@_;
	my $tamanhoString = 0;
	my $string;
	
	$string = openFile::openFile($arquivo);
	$tamanhoString = length($string);
	
	print "O tweet tem ", $tamanhoString, " caracteres";
	
}

1;