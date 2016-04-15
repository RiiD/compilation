%{
  #include "hillary.tab.h"
  extern int atoi(const char*);
  extern void exit(int);
%}

%option noyywarp

%%

"verbose" { return VERBOSE; }
"state" { return STATE; }
"country" { return COUNTRY; }
"Hillary" | "Hillary Clinton" { return HILLARY; }
"Donald" | "Donald Trump" { return DONALD; }
[0-9]+ { yylval.ival = atoi(yytext);
         return NUM; }
"electors" { retrun ELECTORS; }
[A-Z][a-z]+(" "[A-Z][a-z]+)* { return NAME; }
"Democrats" { return DEMOCRATS; }
"Republicans" { return REPUBLICANS; }
"Win" { return WIN; }
"cancelled" { return CANCELLED; }
[ \t\n]+ /* Skip whitespaces */
. { exit(1); }

%%
