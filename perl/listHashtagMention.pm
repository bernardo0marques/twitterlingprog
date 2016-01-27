#Autores: Gabriel Pimentel e Bernardo Marques

package listHashtagMention;

use openFile;

use warnings;
use strict;
use 5.012;

our %EXPORT_TAGS = ( 'all' => [qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	listHashtagMention
);

require Exporter;
our @ISA = qw(Exporter);
our $VERSION = '0.01';

sub listHashtagMention { #listar hashtags que foram usadas na pagina do user pesquisada.
	(my $nomedoArquivo)= @_;
	my $countHashtags=0;
	my $countMentions=0;
	my @hashtags;
#	my @line;
	my @mentions;
	my $string;
	my $str;
	$string = openFile($nomedoArquivo); #chamada de funcao para abrir o arquivo e passá-lo para uma string - REVER
	my @line = split (/\s+/, $string); # todos espacos vazios sao removidos com essa expressao regular
	# \s matches any whitespace character (space, tab, newline)
	
	foreach $str (@line) {		
		if ($str =~ /^#\w+/){  #procura hashtags e vai até o proximo espaço em branco
			$countHashtags++;
			@hashtags = (@hashtags,$str);
		}
		if ($str =~ /^\@\w+/){
			$countMentions++;
			@mentions = (@mentions, $str);
		}	 
	}
	
	print "O numero de Hashtags encontradas e: ", $countHashtags, "\n";
	print  "As hashtags usadas sao: ";
	print  join(" , ", @hashtags);
	print "\n";
	
	
	print "O numero de mentions encontradas e: ", $countMentions, "\n";
	print  "As mentions usadas sao: ";
	print  join(" , ", @mentions);
	print "\n";	
	
	return 0;
}

1;
