%code {
  #include <stdio.h>
  #include <malloc.h>
  extern int yylex(void);
  extern void yyerror(char*);
  extern void exit(int);
}

%code requires {
  // Maybe need enum
  enum participant { D, H };
}

%union {
  int ival;
  char isVerbose;
  struct sumElectors { int hillary, donald; } sumElectors;
  struct countyResults { int hillary, donald; } countyResults;
  struct stateResults { enum participant winner; int electors; } stateResults;
  enum participant win;
}

%token VERBOSE STATE NAME ELECTORS
%token <ival> NUM
%token DEMOCRATS REPUBLICANS WIN COUNTY HILLARY DONALD CANCELLED

%type <isVerbose> verbose
%type <sumElectors> statelist
%type <countyResults> county countylist
%type <stateResults> state
%type <win> winner

%%
input:  verbose statelist {
  if($2.hillary > $2.donald && $2.hillary > 270) {
    printf("Hillary Clinton wins!\n");
  } else if($2.donald > $2.hillary && $2.donald > 270) {
    printf("Donald Trump wins!\n");
  } else {
    printf("No winner!\n");
  }

  if($1 == 1) {
    printf("Donald Trump has %d electors\n", $2.donald);
    printf("Hillary Clinton has %d electors\n", $2.hillary);
  }
}

verbose: VERBOSE { $$ = 1; }
         | /* empty */ { $$ = 0; }

statelist: /* empty */ { $$.hillary = 0;
                         $$.donald = 0; }

statelist: statelist state { $$.hillary = $1.hillary;
                             $$.donald = $1.donald;
                             if($2.winner == D)
                                $$.donald = $$.donald + $2.electors;
                             else
                                $$.hillary = $$.hillary + $2.electors; }

state: STATE ':' NAME ';' ELECTORS ':' NUM ';' countylist { $$.winner = $9.hillary > $9.donald ? H : D;
                                                            $$.electors = $7;  }

state: STATE ':' NAME ';' ELECTORS ':' NUM ';' winner { $$.winner = $9;
                                                        $$.electors = $7; };

winner:  DEMOCRATS WIN '!' { $$ = H; }
         |  REPUBLICANS WIN '!' { $$ = D; }

countylist: /* empty */ { $$.hillary = 0;
                          $$.donald = 0; }

countylist: countylist county { $$.hillary = $1.hillary + $2.hillary;
                                $$.donald = $1.donald + $2.donald; }


county: COUNTY ':' NAME ';' HILLARY ':' NUM  DONALD ':' NUM { $$.hillary = $7;
                                                              $$.donald = $10;  }

county: COUNTY ':' NAME ';' NUM '(' 'D' ')' NUM '(' 'R' ')' { $$.hillary = $5;
                                                              $$.donald = $9; }
county: COUNTY ':' NAME ';' CANCELLED { $$.hillary = 0;
                                        $$.donald = 0; }

%%

main (int argc, char **argv) {
  extern FILE *yyin;
  if (argc != 2) {
     fprintf (stderr, "Usage: %s <input-file-name>\n", argv[0]);
	 return 1;
  }
  yyin = fopen (argv [1], "r");
  if (yyin == NULL) {
       fprintf (stderr, "failed to open %s\n", argv[1]);
	   return 2;
  }

  yyparse ();

  fclose (yyin);
  return 0;
}

void yyerror (char *s) {
  fprintf (stderr, "%s\n", s);
  exit(1);
}
