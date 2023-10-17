%{
#include "y.tab.h"
%}

/* Define regular expressions for tokens */
letter [a-zA-Z]
digit [0-9]
ws  [ \t\r\f\v]+
identifier (_|{letter})(({letter}|{digit}|_){0,31})
hex [0-9a-f]

/* Define exclusive states */
%x CMNT
%x PREPROC

%%

  /* Rules for recognizing keywords */
"void"                            {printf("%s",yytext);return VOID;}
"int"                             {printf("%s",yytext);return INT;}
"float"                           {printf("%s",yytext);return FLOAT;}
"char"                            {printf("%s",yytext);return CHAR;}
"long"                            {printf("%s",yytext);return LONG;}
"long long"                       {printf("%s",yytext);return LONG_LONG; }
"short"                           {printf("%s",yytext);return SHORT; }
"signed"                          {printf("%s",yytext);return SIGNED; }
"unsigned"                        {printf("%s",yytext);return UNSIGNED; }
"for"                             {printf("%s",yytext);return FOR; }
"while"                           {printf("%s",yytext);return WHILE;}
"break"                           {printf("%s",yytext);return BREAK; }
"continue"                        {printf("%s",yytext);return CONTINUE; }
"if"                              {printf("%s",yytext);return IF; }
"else"                            {printf("%s",yytext);return ELSE; }
"return"                          {printf("%s",yytext);return RETURN; }

    /* Rule for recognizing identifiers */
{identifier}                      {
                                    printf("%s",yytext);
                                    insert(symbol_table, yytext, IDENTIFIER);
                                    return IDENTIFIER;
                                  }

    /* Rule for recognizing whitespace */
{ws}                              ;

    /* Rules for recognizing constants */
[+\-]?[0][xX]{hex}+[lLuU]?        {
                                    printf("%s",yytext);
                                    insert(constant_table, yytext, HEX_CONSTANT);
                                    return HEX_CONSTANT;
                                  }
[+\-]?{digit}+[lLuU]?              {
                                    printf("%s",yytext);
                                    insert(constant_table, yytext, DEC_CONSTANT);
                                    return DEC_CONSTANT;
                                  }

    /* Rules for recognizing comments */
"*/"                              { printf("Line %3d: Comment never started!\n", yylineno); }
"/*"                              { comment_level++; cmnt_strt = yylineno; BEGIN CMNT; }
"@"                              { comment_level++; cmnt_strt = yylineno; BEGIN CMNT; }
<CMNT>"@"                         {comment_level=0;BEGIN INITIAL;}
<CMNT>.|{ws}                      ;
<CMNT>\n                          { yylineno++; }
<CMNT>"*/"                        {
                                    comment_level--;
                                    if (comment_level == 0) BEGIN INITIAL;
                                  }
<CMNT>"/*"                        { comment_level++; }
<CMNT><<EOF>>                     { printf("Line %3d: Unterminated comment\n", cmnt_strt); yyterminate(); }
    
    /* Rules for recognizing preprocessor directives */
^"#include"                       { BEGIN PREPROC; }
<PREPROC>"<"[^<>\n]+">"           ;
<PREPROC>{ws}                     ;
<PREPROC>\"[^"\n]+\"              ;
<PREPROC>\n                       { yylineno++; BEGIN INITIAL; }
<PREPROC>.                        { printf("Line %3d: Illegal header file format\n", yylineno); }
"//".*                            ;

    /* Rules for recognizing strings */
\"[^\"\n]*\"     {
                    if (yytext[yyleng - 2] == '\\') /* check if it was an escaped quote */
                    {
                        yyless(yyleng - 1);       /* push the quote back if it was escaped */
                        yymore();
                    }
                    else{
                        printf("%s",yytext);
                        insert(constant_table, yytext, STRING);
                        return STRING;
                    }
                 }

\"[^\"\n]*$                     { printf("Line %3d: Unterminated string %s\n", yylineno, yytext); }
{digit}+({letter}|_)+            { printf("Line %3d: Illegal identifier name %s\n", yylineno, yytext); }
\n                              { yylineno++; }

    /* Rules for recognizing operators and punctuation */
"--"			                {printf("%s",yytext);return DECREMENT_ONE; }
"-="			                {printf("%s",yytext);return DECREMENT; }
"++"			                {printf("%s",yytext);return INCREMENT_ONE; }
"+="			                {printf("%s",yytext);return INCREMENT; }
"->"			                {printf("%s",yytext);return PTR_SELECT; }
"&&"			                {printf("%s",yytext);return LOGICAL_AND; }
"||"			                {printf("%s",yytext);return LOGICAL_OR; }
"<="			                {printf("%s",yytext);return LS_THAN_EQ; }
">="			                {printf("%s",yytext);return GR_THAN_EQ; }
"=="			                {printf("%s",yytext);return EQ; }
"!="		                    {printf("%s",yytext);return NOT_EQ; }
";"			                    {printf("%s",yytext);return DELIMITER; }
"{"                             {printf("%s",yytext);return OPEN_BRACES; }
"}"                             {printf("%s",yytext);return CLOSE_BRACES; }
","			                    {printf("%s",yytext);return COMMA; }
"="			                    {printf("%s",yytext);return ASSIGN; }
"("			                    {printf("%s",yytext);return OPEN_PAR; }
")"			                    {printf("%s",yytext);return CLOSE_PAR; }
"["                             {printf("%s",yytext);return OPEN_SQ_BRKT; }
"]"                             {printf("%s",yytext);return CLOSE_SQ_BRKT; }
"-"			                    {printf("%s",yytext);return MINUS; }
"+"			                    {printf("%s",yytext);return PLUS; }
"*"			                    {printf("%s",yytext);return STAR; }
"/"		                        {printf("%s",yytext);return FW_SLASH; }
"%"			                    {printf("%s",yytext);return MODULO; }
"<"			                    {printf("%s",yytext);return LS_THAN; }
">"			                    {printf("%s",yytext);return GR_THAN; }
"<<"                            {printf("%s",yytext);return LS_SHIFT; }
">>"                            {printf("%s",yytext);return RS_SHIFT; }
"&"                             {printf("%s",yytext);return BITWISE_AND; }
"|"                             {printf("%s",yytext);return BITWISE_OR; }
"^"                             {printf("%s",yytext);return BITWISE_XOR; }
"~"                             {printf("%s",yytext);return BITWISE_NOT; }
"?"                             {printf("%s",yytext);return TERNARY_COND; }
":"                             {printf("%s",yytext);return TERNARY_COLON; }
"."                             {printf("%s",yytext);return ACCESS_DOT; }
.                               {printf("%s",yytext);return yytext[0];}

%%

    // Wrap-up function
int yywrap()
{
    return 1;
}
