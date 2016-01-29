#Universidade Federal do Rio de Janeiro
#Autores:  Bernardo Marques e Gabriel Pimentel
#Linguagens de Programação

use strict;
use warnings;
use 5.012;

use TwitterPerl;

my $option = 0;
my $arquivo;

sub printMenu {
    print "\n";
    print "1 - Listar hashtags e mentions \n";
    print "2 - Procura de Palavras \n";
    print "3 - Contagem de caracteres de um tweet \n";
    print "4 - Avaliacao da data do tweet \n";
    print "5 - Ver se um determinado tweet foi retweetado \n";
    print "6 - Sair \n\n";
    print "Escolha uma opcao: \n ";
}

sub readSTDIN {
    $option = <STDIN>;
    chomp($option); #remove \n que foi inserido quando option foi inserido!
}

sub readOption {
    print "Entre o arquivo de entrada(exemplo.txt):";
    $arquivo = <STDIN>;
    chomp($arquivo);
}

START:
if ($option != 6){
    printMenu();
    readSTDIN();
    if    ($option == 1) {readOption(); listHashtagMention($arquivo);}
    elsif ($option == 2) {readOption(); searchWords($arquivo);}
    elsif ($option == 3) {readOption(); contagemCaracteres($arquivo);}
    elsif ($option == 4) {readOption(); dateValue($arquivo);}
    elsif ($option == 5) {readOption(); retweetStatus($arquivo);}
    else  {goto START;}
}
