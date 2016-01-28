package dateValue;

use openFile;

use Time::Local;

use warnings;
use strict;
use 5.012;
use Switch;

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

	my @mes = ("Jan", "Fev", "Mar", "Apr", "May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
	my $year = 0;
	my $month = 0;
	my $day = 0;

	my $hour = 0;
	my $minute = 0;
	my $second = 0;
	my $counter = 0;

	my $yearSys = 0;
	my $monthSys = 0;
	my $daySys = 0;

	my $hourSys = 0;
	my $minuteSys = 0;
	my $secondSys = 0;
	my $counterSys = 0;
	my $fuso = 0;
	
	my $string = openFile($nomedoArquivo); #chamada de funcao para abrir o arquivo e passá-lo para uma string - REVER
	
####################
#### Extraindo data do tweet
####################
	my @line = split (/\s+/, $string);
	$year = $line[6];
	$month = $line[2];
	$day= $line[3];

	for ($counter=0; ($counter < 12); $counter++) {
		if( $mes[$counter] =~ $month) {
			$month = $counter +1;
		}
	}
	my @line2 =  split (/:/,$line[4]);

	$hour = $line2[0];
	$minute = $line2[1];
	$second = $line2[2];


####################
#### Converter data do tweet para GMT +0000
#### Consideramos que os meses tem 30dias
####################
	$fuso = $line[5];
	print "$fuso\n";

	$hour = $hour + ($fuso)*(-1);
	if ($hour > 24 ){
		$hour = $hour -24;
		$day = $day + 1;
		if ($day > 30){
			$day = $day - 30;
			$month = $month + 1;
			if ($month > 12){
				$month = $month - 12;
				$year = $year + 1;
			}
		}	
	}
	elsif ($hour < 0 ){
		$hour = $hour + 24;
		$day = $day - 1;
		if ($day < 1){
			$day = $day + 30;
			$month = $month - 1;
			if ($month < 1){
				$month = $month + 12;
				$year = $year - 1;
			}
		}
	}

	print "$hour\n";


####################
#### Extraindo data do sistema
####################

    my $systemTime = localtime();
    my $globalTime = gmtime();
    print "$globalTime\n";
    print "$systemTime\n";



	my @lineSys = split (/\s+/, $systemTime);

	$yearSys = $lineSys[4];
	$monthSys = $lineSys[1];
	$daySys = $lineSys[2];

	for ($counter=0; ($counter < 12); $counter++) {
		if( $mes[$counter] =~ $monthSys) {
			$monthSys = $counter +1;
		}
	}

	my @lineSys2 =  split (/:/,$lineSys[3]);
	$hourSys = $lineSys2[0];
	$minuteSys = $lineSys2[1];
	$secondSys = $lineSys2[2];

	my $yearDif = $yearSys - $year;
	my $monthDif = 0;
	my $dayDif = 0;
	my $hourDif = 0;
	my $minuteDif = 0;


		if ($yearDif == 0){
			$monthDif = $monthSys - $month;
			if ($monthDif == 0){
				$dayDif = $daySys - $day;
				if ($dayDif == 0) {
					$hourDif = $hourSys - $hour;
					if ($hourDif == 0){
						$minuteDif = $minuteSys - $minute;
						if ($minuteDif == 0) {print "Quase agora.\n"}
					}
					elsif ($hourDif > 0){print "Mais de $hourDif horas atrás.\n"}
				}
				elsif ($dayDif > 0) {print "Mais de $dayDif dias atrás.\n"}
			}
			elsif($monthDif == 1){
				$dayDif = (30 - $day) + $daySys;
				if ($dayDif > 30) {print "Mais de um mes atrás.\n";}
			}
			else{print "Mais $monthDif meses atrás.\n"}
		}
		elsif ($yearDif == 1){
			$monthDif = (12 - $month) + $monthSys;
			if ($monthDif >= 12) {print "Mais de um ano atrás.\n"}
			else {print "Mais de $monthDif meses atrás.\n"}
		}
		else {print "Mais de um ano.\n"}


		return 0;
}

1;