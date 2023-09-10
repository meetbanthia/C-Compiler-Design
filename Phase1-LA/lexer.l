%{
#include <stdlib.h>
#include <stdio.h>
#include "symboltable.h"
#include "tokens.h"

// Define global variables
entry_t** symbol_table;
entry_t** constant_table;
int cmnt_strt = 0;
int comment_level = 0; // Keep track of comment nesting level
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
"int"                             { printf("\t%-30s : %3d\n", yytext, INT); }
"float"                           { printf("\t%-30s : %3d\n",yytext,FLOAT);}
"char"                            { printf("\t%-30s : %3d\n",yytext,CHAR);}
"long"                            { printf("\t%-30s : %3d\n", yytext, LONG); }
"long long"                       { printf("\t%-30s : %3d\n", yytext, LONG_LONG); }
"short"                           { printf("\t%-30s : %3d\n", yytext, SHORT); }
"signed"                          { printf("\t%-30s : %3d\n", yytext, SIGNED); }
"unsigned"                        { printf("\t%-30s : %3d\n", yytext, UNSIGNED); }
"for"                             { printf("\t%-30s : %3d\n", yytext, FOR); }
"while"                           { printf("\t%-30s : %3d\n",yytext,WHILE);}
"break"                           { printf("\t%-30s : %3d\n", yytext, BREAK); }
"continue"                        { printf("\t%-30s : %3d\n", yytext, CONTINUE); }
"if"                              { printf("\t%-30s : %3d\n", yytext, IF); }
"else"                            { printf("\t%-30s : %3d\n", yytext, ELSE); }
"return"                          { printf("\t%-30s : %3d\n", yytext, RETURN); }

    /* Rule for recognizing identifiers */
{identifier}                      {
                                    printf("\t%-30s : %3d\n", yytext, IDENTIFIER);
                                    insert(symbol_table, yytext, IDENTIFIER);
                                  }

    /* Rule for recognizing whitespace */
{ws}                              ;

    /* Rules for recognizing constants */
[+\-]?[0][xX]{hex}+[lLuU]?        {
                                    printf("\t%-30s : %3d\n", yytext, HEX_CONSTANT);
                                    insert(constant_table, yytext, HEX_CONSTANT);
                                  }
[+\-]?{digit}+[lLuU]?              {
                                    printf("\t%-30s : %3d\n", yytext, DEC_CONSTANT);
                                    insert(constant_table, yytext, DEC_CONSTANT);
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
                    else
                        insert(constant_table, yytext, STRING);
                 }

\"[^\"\n]*$                     { printf("Line %3d: Unterminated string %s\n", yylineno, yytext); }
{digit}+({letter}|_)+            { printf("Line %3d: Illegal identifier name %s\n", yylineno, yytext); }
\n                              { yylineno++; }

    /* Rules for recognizing operators and punctuation */
"--"			                { printf("\t%-30s : %3d\n", yytext, DECREMENT_ONE); }
"-="			                { printf("\t%-30s : %3d\n", yytext, DECREMENT); }
"++"			                { printf("\t%-30s : %3d\n", yytext, INCREMENT_ONE); }
"+="			                { printf("\t%-30s : %3d\n", yytext, INCREMENT); }
"->"			                { printf("\t%-30s : %3d\n", yytext, PTR_SELECT); }
"&&"			                { printf("\t%-30s : %3d\n", yytext, LOGICAL_AND); }
"||"			                { printf("\t%-30s : %3d\n", yytext, LOGICAL_OR); }
"<="			                { printf("\t%-30s : %3d\n", yytext, LS_THAN_EQ); }
">="			                { printf("\t%-30s : %3d\n", yytext, GR_THAN_EQ); }
"=="			                { printf("\t%-30s : %3d\n", yytext, EQ); }
"!="		                    { printf("\t%-30s : %3d\n", yytext, NOT_EQ); }
";"			                    { printf("\t%-30s : %3d\n", yytext, DELIMITER); }
"{"                             { printf("\t%-30s : %3d\n", yytext, OPEN_BRACES); }
"}"                             { printf("\t%-30s : %3d\n", yytext, CLOSE_BRACES); }
","			                    { printf("\t%-30s : %3d\n", yytext, COMMA); }
"="			                    { printf("\t%-30s : %3d\n", yytext, ASSIGN); }
"("			                    { printf("\t%-30s : %3d\n", yytext, OPEN_PAR); }
")"			                    { printf("\t%-30s : %3d\n", yytext, CLOSE_PAR); }
"["                             { printf("\t%-30s : %3d\n", yytext, OPEN_SQ_BRKT); }
"]"                             { printf("\t%-30s : %3d\n", yytext, CLOSE_SQ_BRKT); }
"-"			                    { printf("\t%-30s : %3d\n", yytext, MINUS); }
"+"			                    { printf("\t%-30s : %3d\n", yytext, PLUS); }
"*"			                    { printf("\t%-30s : %3d\n", yytext, STAR); }
"/"		                        { printf("\t%-30s : %3d\n", yytext, FW_SLASH); }
"%"			                    { printf("\t%-30s : %3d\n", yytext, MODULO); }
"<"			                    { printf("\t%-30s : %3d\n", yytext, LS_THAN); }
">"			                    { printf("\t%-30s : %3d\n", yytext, GR_THAN); }
"<<"                            { printf("\t%-30s : %3d\n", yytext, LS_SHIFT); }
">>"                            { printf("\t%-30s : %3d\n", yytext, RS_SHIFT); }
"&"                             { printf("\t%-30s : %3d\n", yytext, BITWISE_AND); }
"|"                             { printf("\t%-30s : %3d\n", yytext, BITWISE_OR); }
"^"                             { printf("\t%-30s : %3d\n", yytext, BITWISE_XOR); }
"~"                             { printf("\t%-30s : %3d\n", yytext, BITWISE_NOT); }
"?"                             { printf("\t%-30s : %3d\n", yytext, TERNARY_COND); }
":"                             { printf("\t%-30s : %3d\n", yytext, TERNARY_COLON); }
"."                             { printf("\t%-30s : %3d\n", yytext, ACCESS_DOT); }
.                               { printf("Line %3d: Illegal character %s\n", yylineno, yytext); }

%%

    // Wrap-up function
int yywrap()
{
    return 1;
}

int main()
{
    yyin = fopen("t5.c", "r");
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
