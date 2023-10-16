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

int flag=1;
%}

%token INT FLOAT CHAR LONG LONG_LONG SHORT SIGNED UNSIGNED

%token FOR BREAK CONTINUE IF ELSE RETURN

%token IDENTIFIER

%token HEX_CONSTANT DEC_CONSTANT

%token STRING

%token DECREMENT_ONE DECREMENT INCREMENT_ONE INCREMENT; 
%token PTR_SELECT; 
%token LOGICAL_AND LOGICAL_OR 
%token LS_THAN_EQ GR_THAN_EQ EQ NOT_EQ LS_THAN GR_THAN; 
%token DELIMITER; 
%token OPEN_BRACES CLOSE_BRACES; 
%token COMMA; 
%token ASSIGN; 
%token OPEN_PAR CLOSE_PAR OPEN_SQ_BRKT CLOSE_SQ_BRKT; 
%token MINUS PLUS STAR; 
%token FW_SLASH; 
%token MODULO; 
%token LS_SHIFT RS_SHIFT; 
%token BITWISE_AND BITWISE_OR BITWISE_XOR BITWISE_NOT TERNARY_COND TERNARY_COLON ACCESS_DOT; 

%%

code : file EOF
file : functions
| body

functions : type IDENTIFIER '(' arg ')' block
arg : type IDENTIFIER ',' arg 
| type IDENTIFIER

RLOP : LS_THAN_EQ 
|GR_THAN_EQ 
|EQ NOT_EQ 
|LS_THAN 
|GR_THAN

LGOP : LOGICAL_AND
|LOGICAL_OR

statement : ifblock
| forblock
| whileblock
| functioncall
| expression
| return_stm
| cont_stm
| break_stmt

ifblock : IF '(' expression ')' block ELSE block
| IF '(' expression ')' block

whileblock : WHILE '(' expression ')' block

forblock : FOR '(' expression ';' expression ';' expression ')' block

functioncall : IDENTIFIER '(' temp ')'
temp : expression temp
|

return_stm : RETURN expression sc
| RETURN sc

break_stmt : BREAK sc
cont_stm : CONTINUE sc

expression : '(' expression ')'

block : '{' body '}' | single_stat

body : single_stat body
|
single_stat : declaration
| statement
|

declaration : type IDENTIFIER A sc

A : ',' IDENTIFIER A 
|

type : sign dt pt
sign : SIGNED
| UNSIGNED
|
dt : INT | FLOAT | CHAR | LONG | LONG_LONG | SHORT
pt : '*' pt
|

sc : ';' sc
| ';'
 








%%