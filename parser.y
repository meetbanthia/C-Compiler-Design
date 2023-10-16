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

%token INT;}
%token FLOAT;}
%token CHAR;}
%token LONG;}
%token LONG_LONG; }
%token SHORT; }
%token SIGNED; }
%token UNSIGNED; }
%token FOR; }
%token WHILE;}
%token BREAK; }
%token CONTINUE; }
%token IF; }
%token ELSE; }
%token RETURN; }

%%

%%