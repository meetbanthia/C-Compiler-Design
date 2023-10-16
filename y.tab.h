/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     INT = 258,
     FLOAT = 259,
     CHAR = 260,
     LONG = 261,
     LONG_LONG = 262,
     SHORT = 263,
     SIGNED = 264,
     UNSIGNED = 265,
     VOID = 266,
     FOR = 267,
     WHILE = 268,
     BREAK = 269,
     CONTINUE = 270,
     IF = 271,
     ELSE = 272,
     RETURN = 273,
     IDENTIFIER = 274,
     HEX_CONSTANT = 275,
     DEC_CONSTANT = 276,
     STRING = 277,
     DECREMENT_ONE = 278,
     DECREMENT = 279,
     INCREMENT_ONE = 280,
     INCREMENT = 281,
     PTR_SELECT = 282,
     LOGICAL_AND = 283,
     LOGICAL_OR = 284,
     LS_THAN_EQ = 285,
     GR_THAN_EQ = 286,
     EQ = 287,
     NOT_EQ = 288,
     LS_THAN = 289,
     GR_THAN = 290,
     DELIMITER = 291,
     OPEN_BRACES = 292,
     CLOSE_BRACES = 293,
     COMMA = 294,
     ASSIGN = 295,
     OPEN_PAR = 296,
     CLOSE_PAR = 297,
     OPEN_SQ_BRKT = 298,
     CLOSE_SQ_BRKT = 299,
     MINUS = 300,
     PLUS = 301,
     STAR = 302,
     FW_SLASH = 303,
     MODULO = 304,
     LS_SHIFT = 305,
     RS_SHIFT = 306,
     BITWISE_AND = 307,
     BITWISE_OR = 308,
     BITWISE_XOR = 309,
     BITWISE_NOT = 310,
     TERNARY_COND = 311,
     TERNARY_COLON = 312,
     ACCESS_DOT = 313,
     UNARY = 314
   };
#endif
/* Tokens.  */
#define INT 258
#define FLOAT 259
#define CHAR 260
#define LONG 261
#define LONG_LONG 262
#define SHORT 263
#define SIGNED 264
#define UNSIGNED 265
#define VOID 266
#define FOR 267
#define WHILE 268
#define BREAK 269
#define CONTINUE 270
#define IF 271
#define ELSE 272
#define RETURN 273
#define IDENTIFIER 274
#define HEX_CONSTANT 275
#define DEC_CONSTANT 276
#define STRING 277
#define DECREMENT_ONE 278
#define DECREMENT 279
#define INCREMENT_ONE 280
#define INCREMENT 281
#define PTR_SELECT 282
#define LOGICAL_AND 283
#define LOGICAL_OR 284
#define LS_THAN_EQ 285
#define GR_THAN_EQ 286
#define EQ 287
#define NOT_EQ 288
#define LS_THAN 289
#define GR_THAN 290
#define DELIMITER 291
#define OPEN_BRACES 292
#define CLOSE_BRACES 293
#define COMMA 294
#define ASSIGN 295
#define OPEN_PAR 296
#define CLOSE_PAR 297
#define OPEN_SQ_BRKT 298
#define CLOSE_SQ_BRKT 299
#define MINUS 300
#define PLUS 301
#define STAR 302
#define FW_SLASH 303
#define MODULO 304
#define LS_SHIFT 305
#define RS_SHIFT 306
#define BITWISE_AND 307
#define BITWISE_OR 308
#define BITWISE_XOR 309
#define BITWISE_NOT 310
#define TERNARY_COND 311
#define TERNARY_COLON 312
#define ACCESS_DOT 313
#define UNARY 314




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

