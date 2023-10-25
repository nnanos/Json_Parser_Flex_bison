%{ 

    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "json_parser.tab.h"
      
   
 extern YYSTYPE yylval;   // h yylval mas vohthaei na orisoume tous typous twn metavlhtwn ston syntaktiko analyth
 
 
int line_number = 1; 


%}



%option yylineno

 

DIGIT1to9 [1-9]
DIGIT [0-9]
DIGITS {DIGIT}+
INT {DIGIT}|{DIGIT1to9}{DIGITS}|-{DIGIT}|-{DIGIT1to9}{DIGITS}
FLOATING_PART \.{DIGITS}
REAL {INT}{FLOATING_PART}
EXP {E}{DIGITS}
E [eE][+-]?
SCIENTIFIC_NOTATION {INT}{EXP}|{REAL}{EXP}
NUMBER {INT}|{REAL}|{SCIENTIFIC_NOTATION}
HEX_DIGIT [0-9a-f]
UNESCAPEDCHAR [ -!#-\[\]-~]
ESCAPEDCHAR \\["\\bfnrt/]
UNICODECHAR \\u{HEX_DIGIT}{HEX_DIGIT}{HEX_DIGIT}{HEX_DIGIT}
CHAR [a-zA-Z]|{UNESCAPEDCHAR}|{ESCAPEDCHAR}|{UNICODECHAR}
CHARS {CHAR}+
DBL_QUOTE ["]


%%









\n { line_number+=1; }

{DBL_QUOTE}{CHARS}{DBL_QUOTE} { 
         yylval.sval=strdup(yytext);
         return (STRING);
};

{DBL_QUOTE}{DBL_QUOTE}
{             
         yylval.sval=strdup(yytext);
         return (STRING);
};

{NUMBER} {
          yylval.number_val=strdup(yytext);
          
          return (NUMBER);};

true {
    return "true";
};

false {
    return "false";
};

null {
    return "null";
};

\{ {
    return (O_BEGIN);
};

\} {
    return (O_END);
};

\[ {
    return (A_BEGIN);
};

\] {
    return (A_END);
};

, {
    return (COMMA);
};
: {
    return (COLON);
};












%% 
                             

