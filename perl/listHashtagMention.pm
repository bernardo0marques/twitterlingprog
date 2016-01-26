#Autores: Gabriel Pimentel e Bernardo Marques
package openFile;

use warnings;
use strict;
use 5.012;

our %EXPORT_TAGS = ( 'all' => [qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	listHashtags
);

our $VERSION = '0.01';
sub listHashtags{ #listar hashtags que foram usadas na pagina do user pesquisada.
	(my $nomedoArquivo= "teste.txt");
	my $countHashtags=0;
	my $countMentions=0;
	my @hashtags, @line, @mentions;
	my $string;
	my $str;
	$string = openFile::openFile($nomedoArquivo); #chamada de funcao para abrir o arquivo e passá-lo para uma string - REVER
	my @line = split (/\s+/, $string); # todos espacos vazios sao removidos com essa expressao regular
	# \s matches any whitespace character (space, tab, newline)
	
	foreach $str (@line) {		
		if (/^#\w+/){  #procura hashtags e vai até o proximo espaço em branco
			$countHashtags++;
			@hashtags = (@hashtags,$str);
		if (/^@\w+/){
			$countMentions++;
			@mentions = (@mentions, $str);
			}	 
		}
	}
	
	print "O numero de Hashtags encontradas e:", $countHashtags;
	print  "As hashtags usadas são:", @hashtags;
	
	print "O numero de mentions sao:", $countMentions;
	print "As mentions do usuario sao:", @mentions;
	
	return 0;
}

1;
