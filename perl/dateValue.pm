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
#### Extraindo data do sistema
####################

    my $systemTime = localtime();
    #print $systemTime;

	my @lineSys = split (/\s+/, $systemTime);
	#print "@lineSys \n";
	$yearSys = $lineSys[4];
	$monthSys = $lineSys[1];
	$daySys = $lineSys[2];

	#print $monthSys;

	for ($counter=0; ($counter < 12); $counter++) {
		if( $mes[$counter] =~ $monthSys) {
			$monthSys = $counter +1;
		}
	}

	my @lineSys2 =  split (/:/,$line[3]);
	$hourSys = $lineSys2[0];
	$minuteSys = $lineSys2[1];
	$secondSys = $lineSys2[2];

my $yearDif = $yearSys - $year;
my $monthDif = 0;
my $dayDif = 0;
my $hourDif = 0;
my $minuteDif = 0;

switch ($yearDif) {

	case ($yearDif == 1){
		$monthDif = (12 - $month) + $monthSys;
		switch($monthDif){
			case ($monthDif >= 12) {print "Mais de um ano atrás.\n"}
			case (($monthDif > 1) && ($monthDif < 12) ){print "$monthDif meses atrás.\n"}
			case ($monthDif == 1){
				$dayDif = (30 - $day) + $daySys;
				switch ($dayDif){
					case ($dayDif >= 30){print "Mais de 1 mês atrás."}
					case (($dayDif > 1) && ($dayDif < 30)){print "Aproximadamente $dayDif dias atrás.\n"}
					case ($dayDif == 1){
						$hourDif = (24 - $hour) + $hourSys;
						switch ($hourDif) {
							case ($hourDif >= 24){print Mais de 1 dia atrás.}
							case (($hourDif >1) && ($hourDif < 24) {print "Aproximadamente $hourDif horas atrás.\n"}
							case ($hourDif == 1) {
								$minuteDif = (60 - $minute) + $minuteSys;
								switch ($minuteDif){
									case ($minuteDif >= 60){print "Mais de 1 hora atrás.\n"}
									case (($minuteDif >1) && ($minuteDif < 60)) {print "$minuteDif minutos atrás.\n"}
								}
							}
						}
					}
				}
			}
		}
	}
	case ($yearDif == 0){


	}

	else {
		print "Mais de um ano."
	}
}


}



		return 0;
}
1;