package dateValue;

use openFile;

use Time::Local;

use warnings;
use strict;
use 5.012;

our %EXPORT_TAGS = ( 'all' => [qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	dateValue
);

require Exporter;
our @ISA = qw(Exporter);
our $VERSION = '0.01';



sub dateValue { 
	(my $nomedoArquivo)= @_;

	my @mes = ["Jan", "Fev", "Mar", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
	my $year;
	my $month;
	my $day;
	my $hour;
	my $minute;
	my $second;
	my $counter;


	my $string = openFile($nomedoArquivo); #chamada de funcao para abrir o arquivo e passá-lo para uma string - REVER



	my @line;
	foreach $string (@line) {	
		my ($date) = $string =~ /(\Date:.*)\s*$/;
		print $date;

	}
		return 0;
}
1;