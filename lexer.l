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

    // Rules for recognizing keywords 
"int"                             {return INT;}
"float"                           {return FLOAT;}
"char"                            {return CHAR;}
"long"                            {return LONG;}
"long long"                       {return LONG_LONG; }
"short"                           {return SHORT; }
"signed"                          {return SIGNED; }
"unsigned"                        {return UNSIGNED; }
"for"                             {return FOR; }
"while"                           {return WHILE;}
"break"                           {return BREAK; }
"continue"                        {return CONTINUE; }
"if"                              {return IF; }
"else"                            {return ELSE; }
"return"                          {return RETURN; }

    /* Rule for recognizing identifiers */
{identifier}                      {
                                    insert(symbol_table, yytext, IDENTIFIER);
                                    return IDENTIFIER;
                                  }

    /* Rule for recognizing whitespace */
{ws}                              ;

    /* Rules for recognizing constants */
[+\-]?[0][xX]{hex}+[lLuU]?        {
                                    insert(constant_table, yytext, HEX_CONSTANT);
                                    return HEX_CONSTANT;
                                  }
[+\-]?{digit}+[lLuU]?              {
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
<PREPROC>"<"[^<>\n]+">"            { printf("\t%-30s : %3d\n", yytext, HEADER_FILE); }
<PREPROC>{ws}                     ;
<PREPROC>\"[^"\n]+\"              { printf("\t%-30s : %3d\n", yytext, HEADER_FILE); }
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
                        insert(constant_table, yytext, STRING);
                        return STRING;
                    }
                 }

\"[^\"\n]*$                     { printf("Line %3d: Unterminated string %s\n", yylineno, yytext); }
{digit}+({letter}|_)+            { printf("Line %3d: Illegal identifier name %s\n", yylineno, yytext); }
\n                              { yylineno++; }

    /* Rules for recognizing operators and punctuation */
"--"			                {return DECREMENT_ONE; }
"-="			                {return DECREMENT; }
"++"			                {return INCREMENT_ONE; }
"+="			                {return INCREMENT; }
"->"			                {return PTR_SELECT; }
"&&"			                {return LOGICAL_AND; }
"||"			                {return LOGICAL_OR; }
"<="			                {return LS_THAN_EQ; }
">="			                {return GR_THAN_EQ; }
"=="			                {return EQ; }
"!="		                    {return NOT_EQ; }
";"			                    {return DELIMITER; }
"{"                             {return OPEN_BRACES; }
"}"                             {return CLOSE_BRACES; }
","			                    {return COMMA; }
"="			                    {return ASSIGN; }
"("			                    {return OPEN_PAR; }
")"			                    {return CLOSE_PAR; }
"["                             {return OPEN_SQ_BRKT; }
"]"                             {return CLOSE_SQ_BRKT; }
"-"			                    {return MINUS; }
"+"			                    {return PLUS; }
"*"			                    {return STAR; }
"/"		                        {return FW_SLASH; }
"%"			                    {return MODULO; }
"<"			                    {return LS_THAN; }
">"			                    {return GR_THAN; }
"<<"                            {return LS_SHIFT; }
">>"                            {return RS_SHIFT; }
"&"                             {return BITWISE_AND; }
"|"                             {return BITWISE_OR; }
"^"                             {return BITWISE_XOR; }
"~"                             {return BITWISE_NOT; }
"?"                             {return TERNARY_COND; }
":"                             {return TERNARY_COLON; }
"."                             {return ACCESS_DOT; }
.                               {return yytext[0];}

%%

    // Wrap-up function
int yywrap()
{
    return 1;
}

int main()
{
    yyin = fopen("t2.c", "r");
    symbol_table = create_table();
    constant_table = create_table();
    yylex();
    
    // Display symbol and constant tables
    printf("\n\tSymbol table\n");
    display(symbol_table);
    printf("\n\tConstants Table\n");
    display(constant_table);
    
    printf("NOTE: Please refer tokens.h for token meanings\n");
}
