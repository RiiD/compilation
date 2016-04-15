%{
  #include "hillary.tab.h"
  extern int atoi(const char*);
%}

%option noyywrap

%%

"verbose" { return VERBOSE; }
"state" { return STATE; }
"county" { return COUNTY; }
"Hillary" | "Hillary Clinton" { return HILLARY; }
"Donald" | "Donald Trump" { return DONALD; }
[0-9]+ { yylval.ival = atoi(yytext);
         return NUM; }
"electors" { printf("flex_ele \n"); return ELECTORS; }
"democrats" { printf("f_demo \n"); return DEMOCRATS; }
"Republicans" { printf("flex_repu \n"); return REPUBLICANS; }
"win" { return WIN; }
"cancelled" { return CANCELLED; }
[A-Z][a-z]+(" "[A-Z][a-z]+)? { printf("flex_NAME \n"); return NAME; }
":" { return ':'; }
";" { return ';'; }
")" { return ')'; }
"(" { return '('; }
"!" { return '!'; }
"D" { return 'D'; }
"R" { return 'R'; }
[ \t\n]+ /* Skip whitespaces */
. { yyerror("Error"); }

%%
