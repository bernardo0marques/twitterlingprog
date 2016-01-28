#Autores : Gabriel Pimentel e Bernardo Marques

use strict;
use warnings;
use 5.012;

require Exporter;
our @ISA = qw(Exporter);

use Switch;

use openFile;
use listHashtagMention;
use searchWords;
use contagemCaracteres;
use dateValue;
use retweetStatus;
#use TwitterPerl; - Quando tudo estiver funcionando tudo usaremos esse package

my $option;
my $arquivo;
my $count=0;

print "Menu: \n\n";
print "1 - Listar hashtags e mentions \n";
print "2 - Procura de Palavras \n";
print "3 - Contagem de caracteres de um tweet \n";
print "4 - Avaliacao da data do tweet \n";
print "5 - Ver se um determinado tweet foi retweetado \n";
print "6 - Sair \n";
print "Escolha uma opcao: \n ";

$option = <STDIN>;
chomp($option); #remove \n que foi inserido quando option foi inserido!


    switch ($option) {
    	case 1 {
    		print "Entre com o nome do arquivo que voce quer abrir com o formato: ";
    		$arquivo = <STDIN>;
    		chomp($arquivo); 
    		listHashtagMention($arquivo);
    	}
    	case 2 {
    		print "Entre com o nome do arquivo que voce quer abrir com o formato: ";
    		$arquivo = <STDIN>;
    		chomp($arquivo);
    		searchWords($arquivo);
    	}
    	case 3 {
    		print "Entre com o nome do arquivo que voce quer abrir com o formato: ";
    		$arquivo = <STDIN>;
    		chomp($arquivo);
    		contagemCaracteres($arquivo);
    	}
    	case 4 {
    		print "Entre com o nome do arquivo que voce quer abrir com o formato: ";
    		$arquivo = <STDIN>;
    		chomp($arquivo);
    		dateValue($arquivo);
    	}
    	case 5 {
    		print "Entre com o nome do arquivo que voce quer abrir com o formato: ";
    		$arquivo = <STDIN>;
    		chomp($arquivo); 
    		retweetStatus($arquivo);
    	}
    	case 6 {
    		exit;
    		}

    	else {
    		print "Nao foi digitado um numero de 1 a 6";
    		}
    }

1;