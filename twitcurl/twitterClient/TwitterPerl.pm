#Universidade Federal do Rio de Janeiro
#Autores:  Bernardo Marques e Gabriel Pimentel
#Linguagens de Programação

package TwitterPerl;

use warnings;
use strict;
use 5.012;

our %EXPORT_TAGS = ( 'all' => [qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw(
	openFile
	listHashtagMention
	searchWords
	contagemCaracteres
	dateValue
	retweetStatus
);

require Exporter;
our @ISA = qw(Exporter);
our $VERSION = '0.01';

####################################################################################################
### 0 - openFile
####################################################################################################
### função para abrir o arquivo de entrada e passar para uma $str que será manipulada.
####################################################################################################
sub openFile  { 
		(my $fileName) = @_; #parametro para abertura da funcao

open my $fh, '<', $fileName or die "Could not open '$fileName' $!\n"; #comando para abrir o arquivo
 
 my $texto = ""; 

while (my $line = <$fh>) {
   chomp $line;
   my @strings = $line;
   foreach my $s (@strings) {
     $texto = $texto . $s . "\n"; #concatena a variavel $texto com $s
   }
}

close $fh;
return $texto; #retorna a string
}

####################################################################################################
### 1 - listHashtagMention
####################################################################################################
### função que conta e lista quais foram as @(mentions) e as #(hashtags) do tweet.
####################################################################################################

sub listHashtagMention { #listar hashtags que foram usadas na pagina do user pesquisada.
	(my $nomedoArquivo)= @_;
	my $countHashtags=0;
	my $countMentions=0;
	my @hashtags;
	my @mentions;
	my $string;
	my $str;
	
	$string = openFile($nomedoArquivo); #chamada de funcao para abrir o arquivo e passá-lo para uma string - REVER
	my @line = split (/\s+/, $string); #  split a string into an array with the split occurring at the white spaces
	#corta a string na ocorrencia de espacos em branco e joga em um array
	# \s matches any whitespace character (space, tab, newline)
	
	foreach $str (@line) {		
		if ($str =~ /^#\w+/){  #procura palavras que o primeiro caracter é # e vai até o proximo espaço em branco
			$countHashtags++;
			@hashtags = (@hashtags,$str);
		}
		if ($str =~ /^\@\w+/){ #procura palavras que o primeiro caracter é @ e vai até o proximo espaço em branco
			$countMentions++;
			@mentions = (@mentions, $str);
		}	 
	}
	
	print "O numero de Hashtags encontradas e: ", $countHashtags, "\n";
	print  "As hashtags usadas sao: ";
	print  join(" , ", @hashtags); #printa a @hashtags formatada com virgula entre os elementos
	print "\n";
	
	
	print "O numero de mentions encontradas e: ", $countMentions, "\n";
	print  "As mentions usadas sao: ";
	print  join(" , ", @mentions); #printa a @mentions formatada com virgula entre os elementos
	print "\n";	
	
	return 0;
}

####################################################################################################
### 2 - searchWords
####################################################################################################
### função que busca palavra chamada
####################################################################################################

sub searchWords{
	(my $nomedoArquivo)= @_;
	
	my $countPalavras=0;
	my $str;
	my @line;
	my $string;
	my $palavraProcurada;
	
	$string = openFile($nomedoArquivo);
	@line = split (/\s+/, $string);
	
	print "Qual palavra voce procura? ";
	$palavraProcurada = <STDIN>;
	chomp($palavraProcurada);
	
	foreach $str (@line) { 
		if ($str =~ $palavraProcurada){ #busca da palavra
			$countPalavras++;
		}
	}
	if ($countPalavras == 0){
			print "Nao foi encontrada a palavra procurada ", $palavraProcurada, ".\n";
		}
		if ($countPalavras>0){
			print "Foi encontrada a palavra procurada '", $palavraProcurada, "', ", $countPalavras, "vez(es). \n";
		}
}

####################################################################################################
#### 3 - contagemCaracteres
####################################################################################################
### conta quantos caracteres o tweet possui.
####################################################################################################

sub contagemCaracteres {
	(my $arquivo) =@_;
	my $tamanhoString = 0;
	my $string;
	
	$string = openFile($arquivo);
	$tamanhoString = length($string); #funcao length conta os caracteres do arquivo inserido
	
	print "O tweet tem ", $tamanhoString, " caracteres. \n";
	
}

####################################################################################################
### 4 - dateValue
####################################################################################################
### funcão para estimar quanto tempo aprás um tweet foi enviado.
####################################################################################################
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
#---------------------------------------------------------------------------------------------------
# Obtendo a data do tweet que será comparada com a data do sistema.
#---------------------------------------------------------------------------------------------------
	my $string = "";
	my $subString = openFile($nomedoArquivo); 
	my @subLine = split (/\n+/, $subString);  

	foreach $subString (@subLine) {	
			if ($subString =~ /created_at:.+/){
			$string = $subString;
		}
	}	

	my @line = split (/\s+/, $string);
	$year = $line[6];
	$month = $line[2];
	$day= $line[3];

#rotina para atribuir valor para os meses de 1 a 12.
	for ($counter=0; ($counter < 12); $counter++) {
		if( $mes[$counter] =~ $month) {
			$month = $counter +1;
		}
	}
	my @line2 =  split (/:/,$line[4]);

	$hour = $line2[0];
	$minute = $line2[1];
	$second = $line2[2];


#---------------------------------------------------------------------------------------------------
# Normalizando fuso horário do tweet recebido para comparação.
# Para simplificar a normalização só foram tratados fuso horários inteiros e também.
#---------------------------------------------------------------------------------------------------
	$fuso = $line[5];

	$hour = $hour + int($fuso/100) *(-1);
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

#---------------------------------------------------------------------------------------------------
# Obtendo a data do sistema que servira de referencia.
#---------------------------------------------------------------------------------------------------
    my $systemTime = localtime();
    my $globalTime = gmtime();

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

#---------------------------------------------------------------------------------------------------
# Rotina que compara a data do tweet com a referência do sistema e gera a estimativa.
# Para simplificar a comparação todos os meses foram considerados com 30 dias.
# Não foi tratado o caso em que o tempo do sistema é mais antigo que o tempo do tweet pois não é 
# possível obter uma data futura a partir da API do twitter.
#---------------------------------------------------------------------------------------------------
	my $yearDif = $yearSys - $year;
	my $monthDif = 0;
	my $dayDif = 0;
	my $hourDif = 0;
	my $minuteDif = 0;
	my $secondDif = 0;

		if ($yearDif == 0){
			$monthDif = $monthSys - $month;
			if ($monthDif == 0){
				$dayDif = $daySys - $day;
				if ($dayDif == 0) {
					$hourDif = $hourSys - $hour;
					if ($hourDif == 0){
						$minuteDif = $minuteSys - $minute;
						if ($minuteDif == 0){ 
							$secondDif = $secondSys - $second;
							print "$secondDif segundos atrás.\n";
						}
						elsif ($minuteDif == 1) {
							$secondDif = (60 - $second) + $secondSys;
							if ($secondDif > 60) {print "Mais de 1 minuto atrás.\n"}
						}
						else {print "Aproximadamente $secondDif segundos atrás. "}
					}
					elsif ($hourDif == 1) {
						$minuteDif = (60 - $minute) + $minuteSys;
						if ($minuteDif > 60) {print "Mais de 1 hora atrás.\n"}
						else {print "Aproximadamante $minuteDif minutos atrás\n"}
					}
					else {print "Mais de $hourDif horas atrás.\n"}
				}
				elsif ($dayDif == 1) {
					$hourDif = (24 - $hour) + $hourSys;
					if ($hourDif > 24) {print "Mais de 1 dia atrás.\n"}
					else {print "Mais de $hourDif horas atrás.\n"}
				}
				else {print "Mais de $dayDif dias atrás.\n"}	
			}
			elsif($monthDif == 1){
				$dayDif = (30 - $day) + $daySys;
				if ($dayDif > 30) {print "Mais de um mes atrás.\n";}
				else {print "Mais de $dayDif dias atrás.\n";}
			}
			else{print "Mais de $monthDif meses atrás.\n"}
		}
		elsif ($yearDif == 1){
			$monthDif = (12 - $month) + $monthSys;
			if ($monthDif >= 12) {print "Mais de um ano atrás.\n"}
			else {print "Mais de $monthDif meses atrás.\n"}
		}
		else {print "Mais de $yearDif anos atrás.\n"}

		return 0;
}

####################################################################################################
### 5 - retweetStatus
####################################################################################################
### funcão que diz se o tweet é original ou se é uma réplica de outro tweet.
####################################################################################################

sub retweetStatus {
	(my $nomedoArquivo) =@_;

	my $string;
	my $str;

	$string = openFile($nomedoArquivo);
	my @line = split (/,/, $string); #separa por virgula porque o JSON tem como padrao dividir por ',', onde tem ',' ele substitui por \n (new line)  
 
	
	foreach $str (@line) {		
		if ($str =~ /"retweeted":false/){  #procura essa regex no arquivo de texto (.json)
			print "Esse tweet nao foi retweetado \n";
		}
		if ($str =~ /"retweeted":true/){  #procura essa regex no arquivo de texto (.json)
			print "Esse tweet foi retweetado \n";
		}
	}
}


#---------------------------------------------------------------------------------------------------
# 
#---------------------------------------------------------------------------------------------------


1;