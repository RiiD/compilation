%{
  #include "hillary.tab.h"
  extern int atoi(const char*);
%}

%option noyywrap

%s name

%%
"verbose"                           { return VERBOSE; }
"state"                             { BEGIN(name);
                                      return STATE; }
"county"                            { BEGIN(name);
                                      return COUNTY; }
"Hillary"|"Hillary Clinton"         { return HILLARY; }
"Donald"|"Donald Trump"             { return DONALD; }
[0-9]+                              { BEGIN(INITIAL);
                                      yylval.ival = atoi(yytext);
                                      return NUM; }
"electors"                          { return ELECTORS; }
"Democrats"                         { return DEMOCRATS; }
"Republicans"                       { return REPUBLICANS; }
"Win"                               { return WIN; }
"cancelled"                         { return CANCELLED; }
<name>[A-Z][a-z]+(" "[A-Z][a-z]+)?  { BEGIN(INITIAL);
                                     return NAME; }
<*>[:;()!RD]                        { return yytext[0]; }
[ \t\n]+                            /* Skip whitespaces */
<*>.                                { yyerror("Unexpected token!"); }
%%
