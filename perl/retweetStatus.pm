#Autores : Gabriel Pimentel e Bernardo Marques
package retweetStatus;

use openFile;

use warnings;
use strict;
use 5.012;

our %EXPORT_TAGS = ( 'all' => [qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	retweetStatus
);

require Exporter;
our @ISA = qw(Exporter);
our $VERSION = '0.01';

sub retweetStatus {
	(my $nomedoArquivo) =@_;

	my $string;
	my $str;
	#my @line;

	$string = openFile($nomedoArquivo);
	my @line = split (/,/, $string); #separa por virgula porque o JSON tem como padrao dividir por , 
 
	#my $word = '"retweeted:"';

	#my $nextStr = /$word\s*?(\S+)/;

	
	foreach $str (@line) {		
		if ($str =~ /"retweeted":false/){  #procura a palavra false no arquivo de texto
			print "Esse tweet nao foi retweetado \n";
		}
		if ($str =~ /"retweeted":true/){  #procura a palavra true no arquivo de texto
			print "Esse tweet foi retweetado \n";
		}
	}
	#foreach $str (@line) {		
	#	if ($nextStr =~ /true/){  #procura a palavra false no arquivo de texto
	#		
	#		print "Esse tweet foi retweetado \n";
	#	}
		
	#}
}

1;