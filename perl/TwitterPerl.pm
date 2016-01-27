#Autores:  Bernardo Marques e Gabriel Pimentel

package TwitterPerl;

use warnings;
use strict;
use 5.012;

our %EXPORT_TAGS = ( 'all' => [qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw(
	openFile
	contagemCaracteres
	dateValue
);

require Exporter;
our @ISA = qw(Exporter);
our $VERSION = '0.01';


sub openFile  { 
		(my $fileName) = @_;
#####################################
## Passa o conteudo do tweet.txt para uma $string. 
#####################################
open my $fh, '<', $fileName or die "Could not open '$fileName' $!\n";
my $texto = ""; 

while (my $line = <$fh>) {
   chomp $line;
   my @strings = $line;
   foreach my $s (@strings) {
     $texto = $texto . $s . "\n";
   }
}
return $texto;
}

##### fechar o arquivo



#####################################
## Funcão para contar o número de caracteres do tweet. 
#####################################
sub contagemCaracteres {
	(my $arquivo) =@_;
	my $tamanhoString = 0;
	my $string;
	
	$string = openFile($arquivo);
	$tamanhoString = length($string);
	
	print "O tweet tem ", $tamanhoString, " caracteres. \n";
	
}

#####################################
## Funcão que conta e exibe #hashtags e @mentions. 
#####################################

sub listHashtagMention { #listar hashtags que foram usadas na pagina do user pesquisada.
	(my $nomedoArquivo)= @_;
	my $countHashtags=0;
	my $countMentions=0;
	my @hashtags;
#	my @line;
	my @mentions;
	my $string;
	my $str;
	$string = openFile::openFile($nomedoArquivo); #chamada de funcao para abrir o arquivo e passá-lo para uma string - REVER
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