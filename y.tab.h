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
     FOR = 266,
     WHILE = 267,
     BREAK = 268,
     CONTINUE = 269,
     IF = 270,
     ELSE = 271,
     RETURN = 272,
     IDENTIFIER = 273,
     HEX_CONSTANT = 274,
     DEC_CONSTANT = 275,
     STRING = 276,
     DECREMENT_ONE = 277,
     DECREMENT = 278,
     INCREMENT_ONE = 279,
     INCREMENT = 280,
     PTR_SELECT = 281,
     LOGICAL_AND = 282,
     LOGICAL_OR = 283,
     LS_THAN_EQ = 284,
     GR_THAN_EQ = 285,
     EQ = 286,
     NOT_EQ = 287,
     LS_THAN = 288,
     GR_THAN = 289,
     DELIMITER = 290,
     OPEN_BRACES = 291,
     CLOSE_BRACES = 292,
     COMMA = 293,
     ASSIGN = 294,
     OPEN_PAR = 295,
     CLOSE_PAR = 296,
     OPEN_SQ_BRKT = 297,
     CLOSE_SQ_BRKT = 298,
     MINUS = 299,
     PLUS = 300,
     STAR = 301,
     FW_SLASH = 302,
     MODULO = 303,
     LS_SHIFT = 304,
     RS_SHIFT = 305,
     BITWISE_AND = 306,
     BITWISE_OR = 307,
     BITWISE_XOR = 308,
     BITWISE_NOT = 309,
     TERNARY_COND = 310,
     TERNARY_COLON = 311,
     ACCESS_DOT = 312,
     EOF = 313
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
#define FOR 266
#define WHILE 267
#define BREAK 268
#define CONTINUE 269
#define IF 270
#define ELSE 271
#define RETURN 272
#define IDENTIFIER 273
#define HEX_CONSTANT 274
#define DEC_CONSTANT 275
#define STRING 276
#define DECREMENT_ONE 277
#define DECREMENT 278
#define INCREMENT_ONE 279
#define INCREMENT 280
#define PTR_SELECT 281
#define LOGICAL_AND 282
#define LOGICAL_OR 283
#define LS_THAN_EQ 284
#define GR_THAN_EQ 285
#define EQ 286
#define NOT_EQ 287
#define LS_THAN 288
#define GR_THAN 289
#define DELIMITER 290
#define OPEN_BRACES 291
#define CLOSE_BRACES 292
#define COMMA 293
#define ASSIGN 294
#define OPEN_PAR 295
#define CLOSE_PAR 296
#define OPEN_SQ_BRKT 297
#define CLOSE_SQ_BRKT 298
#define MINUS 299
#define PLUS 300
#define STAR 301
#define FW_SLASH 302
#define MODULO 303
#define LS_SHIFT 304
#define RS_SHIFT 305
#define BITWISE_AND 306
#define BITWISE_OR 307
#define BITWISE_XOR 308
#define BITWISE_NOT 309
#define TERNARY_COND 310
#define TERNARY_COLON 311
#define ACCESS_DOT 312
#define EOF 313




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

