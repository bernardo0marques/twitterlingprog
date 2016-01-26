#Autores Gabriel Pimentel e Bernardo Marques
package openFile;

use warnings;
use strict;
use 5.012;

our %EXPORT_TAGS = ( 'all' => [qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	printarPaginaUser
);

our $VERSION = '0.01';

sub printarPaginaUser{
	(my $nomedoarquivo) =  @_;
	$string = openFile ($nomeDoArquivo) # abre arquivo e passa para string.
	print "A pagina do user e:"\n, $string \n; #printa a string na tela
	return 0;
}