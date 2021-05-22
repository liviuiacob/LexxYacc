%{
#include "y.tab.h"
extern int yylval;
%}

%%

"laFel"		{return EQ;}
"!laFel"		{return NE;}
"subMedie"		{return LT;}
"pastaMedie"		{return GT;}
"plus"			{return PLUS;}
"minus"		{return MINUS;}
"ori"			{return MULT;}
"supra"		{return DIViDE;}
"deschideUsa"		{return LPARAN;}
"anchideUsa"		{return RPARAN;}
"ie"			{return ASSIGN;}
";"			{return SEMICOLON;}
"dakE"			{return IF;}
"atunkiFa"		{return THEN;}
"altfel"		{return ELSE;}
"terminaDakE"		{return FI;}
"apucate"		{return WHILE;}
"siFa"			{return DO;}
"panaNuMaEnervez"	{return OD;}
"sciemi"		{return PRINT;}
[0-9]+			{yylval=atoi(yytext); return NUMBER;}
[A-Z]			{yyval=yytext[0]-'a'; return NAME;}
\n			{newline();}
"//".*\n		{newline();}
.			{yyerror("illegal token");}


