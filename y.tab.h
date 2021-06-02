/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    EQ = 258,
    NE = 259,
    LT = 260,
    GT = 261,
    PLUS = 262,
    MINUS = 263,
    MULT = 264,
    DIVIDE = 265,
    LPARAN = 266,
    RPARAN = 267,
    ASSIGN = 268,
    SEMICOLON = 269,
    IF = 270,
    THEN = 271,
    ELSE = 272,
    FI = 273,
    WHILE = 274,
    FOR = 275,
    DO = 276,
    OD = 277,
    PRINT = 278,
    PERIOD = 279,
    DEF = 280,
    RET = 281,
    NUMBER = 282,
    NAME = 283,
    FCT = 284,
    IFX = 285
  };
#endif
/* Tokens.  */
#define EQ 258
#define NE 259
#define LT 260
#define GT 261
#define PLUS 262
#define MINUS 263
#define MULT 264
#define DIVIDE 265
#define LPARAN 266
#define RPARAN 267
#define ASSIGN 268
#define SEMICOLON 269
#define IF 270
#define THEN 271
#define ELSE 272
#define FI 273
#define WHILE 274
#define FOR 275
#define DO 276
#define OD 277
#define PRINT 278
#define PERIOD 279
#define DEF 280
#define RET 281
#define NUMBER 282
#define NAME 283
#define FCT 284
#define IFX 285

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 17 "primu.y"

  int iValue;      /* integer value */
  char sIndex;     /* symbol table index */
  nodeType *nPtr;  /* node pointer */

#line 123 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
