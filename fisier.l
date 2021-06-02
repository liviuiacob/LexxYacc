%{
#include <stdlib.h>
#include "types.h"
#include "y.tab.h"
%}

%%

"laFel"		{return EQ;}
"!laFel"		{return NE;}
"subMedie"		{return LT;}
"pastaMedie"		{return GT;}
"plus"			{return PLUS;}
"minus"		{return MINUS;}
"ori"			{return MULT;}
"supra"		{return DIVIDE;}
"deschide"		{return LPARAN;}
"anchide"		{return RPARAN;}
"ie"			{return ASSIGN;}
";"			{return SEMICOLON;}
"dakE"			{return IF;}
"atunkiFa"		{return THEN;}
"altfel"		{return ELSE;}
"terminaDakE"		{return FI;}
"apucate"		{return WHILE;}
"siFa"			{return DO;}
"panaNuMaEnervez"	{return OD;}
"scriemi"		{return PRINT;}
"pentru"        	{return FOR;}

"define"		{return DEF;}
"Z"			{yylval.sIndex = *yytext - 'Z'; return FCT;}


"return"		{return RET;}

[0-9]+			{yylval.iValue = atoi(yytext); return NUMBER;}
[A-Y]			{yylval.sIndex = *yytext - 'A'; return NAME;}
\n			{ ; }

[{}]			{ return *yytext; }
"gatajoaca"		{ return PERIOD; }
[ \t]+        		; 
.			{ yyerror("illegal token"); }


