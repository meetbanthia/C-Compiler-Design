%{
#include <stdio.h>
#include "symboltable.h"
/* #include "tokens.h" */

// Define global variables
entry_t** symbol_table;
entry_t** constant_table;
int cmnt_strt = 0;
int comment_level = 0; // Keep track of comment nesting level

int flag = 1;

void yyerror(char* msg);
int yylex();
%}

%token INT FLOAT CHAR LONG LONG_LONG SHORT SIGNED UNSIGNED VOID
%token FOR WHILE BREAK CONTINUE IF ELSE RETURN
%token IDENTIFIER
%token HEX_CONSTANT DEC_CONSTANT
%token STRING
%token DECREMENT_ONE DECREMENT INCREMENT_ONE INCREMENT
%token PTR_SELECT
%token LOGICAL_AND LOGICAL_OR
%token LS_THAN_EQ GR_THAN_EQ EQ NOT_EQ LS_THAN GR_THAN
%token DELIMITER
%token OPEN_BRACES CLOSE_BRACES
%token COMMA
%token ASSIGN
%token OPEN_PAR CLOSE_PAR OPEN_SQ_BRKT CLOSE_SQ_BRKT
%token MINUS PLUS STAR
%token FW_SLASH
%token MODULO
%token LS_SHIFT RS_SHIFT
%token BITWISE_AND BITWISE_OR BITWISE_XOR BITWISE_NOT TERNARY_COND TERNARY_COLON ACCESS_DOT

%left LOGICAL_OR
%left LOGICAL_AND
%left EQ NOT_EQ
%left LS_THAN LS_THAN_EQ GR_THAN GR_THAN_EQ
%left PLUS MINUS
%left STAR FW_SLASH MODULO
%right UNARY
%right PTR_SELECT
%left LS_SHIFT RS_SHIFT
%left BITWISE_AND
%left BITWISE_XOR
%left BITWISE_OR
%right TERNARY_COND

%%
code: STRUCTURE code
    |
    ;

STRUCTURE: GLODECL     {printf("Choosing Global Declaration\n");}
         | FUNC     {printf("Choosing Function\n");}
         | FUN_DECL {printf("Choosing Function Declaration\n");}
         ;

GLODECL : type IDENTIFIER INI_CONST GLO_LIST sc

INI_CONST : ASSIGN CONST
          |
          ;

GLO_LIST: COMMA type IDENTIFIER INI_CONST GLO_LIST
        |
        ;

FUN_DECL: type IDENTIFIER OPEN_PAR ARG CLOSE_PAR sc
        | VOID IDENTIFIER OPEN_PAR ARG CLOSE_PAR sc
        ;


FUNC: type IDENTIFIER OPEN_PAR ARG CLOSE_PAR OPEN_BRACES BODY CLOSE_BRACES
    | VOID IDENTIFIER OPEN_PAR ARG CLOSE_PAR OPEN_BRACES BODY CLOSE_BRACES
    ;

ARG : type IDENTIFIER arg 
    | VOID 
    |
    ;

arg : COMMA type IDENTIFIER arg
    |
    ;

BODY: stmt BODY
    |
    ;

LOOPBODY : X LOOPBODY
         |
         ;

X : stmt
  | BREAK sc
  | CONTINUE sc

stmt: DECL
    | ifblock
    | forblock
    | whileblock
    | functioncall
    | EXP
    | return_stm
    | sc
    ;

ifblock : IF OPEN_PAR EXP CLOSE_PAR OPEN_BRACES BODY CLOSE_BRACES ELSE OPEN_BRACES BODY CLOSE_BRACES
        | IF OPEN_PAR EXP CLOSE_PAR OPEN_BRACES BODY CLOSE_BRACES
        ;

whileblock : WHILE OPEN_PAR EXP CLOSE_PAR OPEN_BRACES LOOPBODY CLOSE_BRACES
           ;

forblock : FOR OPEN_PAR EXP DELIMITER EXP DELIMITER EXP CLOSE_PAR OPEN_BRACES LOOPBODY CLOSE_BRACES


functioncall: IDENTIFIER OPEN_PAR temp CLOSE_PAR
            ;

temp: EXP
    | temp COMMA EXP
    ;

return_stm: RETURN EXP sc
          | RETURN sc
          | RETURN functioncall sc
          ;

DECL: TYPE IDENTIFIER INITIALIZE VAR_LIST sc
    ;

VAR_LIST: COMMA TYPE IDENTIFIER INITIALIZE VAR_LIST
        |
        ;

TYPE: type
    |
    ;

INITIALIZE: ASSIGN EXP
          |
          ;

CONST : DEC_CONSTANT | HEX_CONSTANT

EXP: OPEN_PAR EXP CLOSE_PAR
    | EXP RLOP EXP
    | EXP LGOP EXP
    | CONST
    | IDENTIFIER
    | STRING
    | EXP PLUS EXP
    | EXP MINUS EXP
    | EXP STAR EXP
    | EXP FW_SLASH EXP
    | EXP MODULO EXP
    | EXP LS_SHIFT EXP
    | EXP RS_SHIFT EXP
    | EXP BITWISE_AND EXP
    | EXP BITWISE_XOR EXP
    | EXP BITWISE_OR EXP
    ;

type: sign dt pt
    ;

sign: SIGNED
    | UNSIGNED
    |
    ;

dt: INT
  | FLOAT
  | CHAR
  | LONG
  | LONG_LONG
  | SHORT
  ;

pt: STAR pt
   |
   ;

RLOP: LS_THAN_EQ
    | GR_THAN_EQ
    | EQ
    | NOT_EQ
    | LS_THAN
    | GR_THAN
    ;

LGOP: LOGICAL_AND
    | LOGICAL_OR
    ;

sc: DELIMITER sc
  | DELIMITER
  ;

%%

#include "lex.yy.c"
#include <ctype.h>

/* Additional code and functions may be needed here */
int main(int argc, char *argv[])
{
	symbol_table = create_table();
	constant_table = create_table();

	yyin = fopen(argv[1], "r");

	if(!yyparse())
	{
		printf("\nParsing complete\n");
	}
	else
	{
			printf("\nParsing failed\n");
	}


	printf("\n\tSymbol table");
	display(symbol_table);


	fclose(yyin);
	return 0;
}

void yyerror(char *msg)
{
	printf("Line no: %d Error message: %s Token: %s\n", yylineno, msg, yytext);
}
