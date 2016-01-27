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
#use TwitterPerl; - Quando tudo estiver funcionando usaremos esse package

my $option;
my $arquivo;

print "Menu";
print "1 - Listar hashtags e mentions";
print "2 - Procura de Palavras";
print "3 - Contagem de Caracteres de um tweet";
print "4 - Avaliação da data do tweet";
print "5 - Quantidade de retweets de um determinado tweet";
print "Escolha uma opcao: ";

$option = <STDIN>;

switch ($option) {
	case 1 {
		print "Entre com o nome do arquivo que voce quer abrir com o formato: ";
		$arquivo = <STDIN>;
		listHashtagMention($arquivo);
	}
	case 2 {
		print "Entre com o nome do arquivo que voce quer abrir com o formato: ";
		$arquivo = <STDIN>;
		searchWords($arquivo);
	}
	case 3 {
		print "Entre com o nome do arquivo que voce quer abrir com o formato: ";
		$arquivo = <STDIN>;
		contagemCaracteres($arquivo);
	}
	case 4 {
		print "Entre com o nome do arquivo que voce quer abrir com o formato: ";
		$arquivo = <STDIN>;
		dateValue($arquivo);
	}
	case 5 {
		print "Entre com o nome do arquivo que voce quer abrir com o formato: ";
		$arquivo = <STDIN>;
		quantidadeRetweets($arquivo);
	}
}