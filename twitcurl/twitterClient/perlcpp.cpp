#include "usr/lib/perl/5.18.2/CORE/EXTERN.h"
#include "usr/lib/perl/5.18.2/CORE/perl.h"

PerlInterpreter *my_perl;

int PerlCalc (int a, int b) {
	dSP;
	ENTER;
	SAVETMPS;
	PUSHMARK (SP);
	XPUSHs (sv_2mortal(newSViv(a)));
	XPUSHs (sv_2mortal(newSViv(b)));
	PUTBACK;
	call_pv ("expo", G_SCALAR);
	SPAGAIN;

	int resultado = POPi;
	PUTBACK;
	FREETMPS;
	LEAVE;

	return resultado;
}

int main (int argc, char **argv, char **env) {
	/* inicializacao */
	char *my_argv[] = {"", "calc.pl"};
	PERL_SYS_INIT3 (&argc, &argv, &env);

	/* criacao d eum interpretador */
	my_perl = perl_alloc ();
	perl_construct(my_perl);
	PL_exit_flags |= PERL_EXIT_DESTRUCT_END;

	/* invocacao do perl com argumentos */
	perl_parse(my_perl, NULL, 2, my_argv, (char **)NULL);
	perl_run(my_perl);

	/*chamada da funcao */
	printf ("Resultado %d\n", PerlCalc (2,4));

	/* limpeza */
	perl_destruct(my_perl);
	perl_free(my_perl);

	/* termino */
	PERL_SYS_TERM();

	return 0;
}