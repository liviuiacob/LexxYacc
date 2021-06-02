%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "types.h"
#define YYDEBUG 0
/* prototypes */
nodeType *opr(int oper, int nops, ...);
nodeType *id(int i);
nodeType *con(int value);
void freeNode(nodeType *p);
void yyerror(char *s);

int sym[26]; /* symbol table */

%}
%union {
  int iValue;      /* integer value */
  char sIndex;     /* symbol table index */
  nodeType *nPtr;  /* node pointer */
};

%token EQ
%token NE
%token LT
%token GT
%token PLUS
%token MINUS
%token MULT
%token DIVIDE
%token LPARAN
%token RPARAN
%token ASSIGN
%token SEMICOLON
%token IF
%token THEN
%token ELSE
%token FI
%token WHILE
%token FOR
%token DO
%token OD
%token PRINT
%token PERIOD
%token DEF
%token RET


%token <iValue> NUMBER 
%token <sIndex> NAME FCT


%nonassoc IFX
%nonassoc ELSE


%type <nPtr> stmt exp stmt_list

%start      program


%%



exp: 
	NUMBER 		{ $$ = con($1); }
	| NAME 		{ $$ = id($1); }
	| LPARAN exp RPARAN 	{ $$ = $2; } 
	| FCT LPARAN RPARAN	{ $$ = id($1); }
	| exp PLUS exp 	{ $$ = opr('+', 2, $1, $3); }
	| exp MINUS exp 	{ $$ = opr('-', 2, $1, $3); }
	| exp DIVIDE exp 	{ $$ = opr('/', 2, $1, $3); }
	| exp MULT exp 	{ $$ = opr('*', 2, $1, $3); }
	| exp GT exp 		{ $$ = opr(GT, 2, $1, $3); }
	| exp LT exp 		{ $$ = opr(LT, 2, $1, $3); }
	| exp EQ exp 		{ $$ = opr(EQ, 2, $1, $3); }
	| exp NE exp 		{ $$ = opr(NE, 2, $1, $3); }
	;

	
	
stmt : SEMICOLON					{ $$ = opr(';', 2, NULL, NULL); }
	| exp SEMICOLON				{ $$ = $1; }
	| PRINT exp SEMICOLON				{ $$ = opr(PRINT, 1, $2); }
	| NAME ASSIGN exp SEMICOLON			{ $$ = opr('=', 2, id($1), $3); }
	| DEF FCT LPARAN RPARAN stmt			{ $$ = opr('=', 2, id($2), $5); }
	| IF LPARAN exp RPARAN THEN stmt FI %prec IFX	{ $$ = opr(IF, 2, $3, $6); }
	| IF LPARAN exp RPARAN THEN stmt ELSE stmt FI	{ $$ = opr(IF, 3, $3, $6, $8); }
	| WHILE LPARAN exp RPARAN DO stmt OD		{ $$ = opr(WHILE, 2, $3, $6); }
  	| FOR LPARAN exp exp RPARAN DO stmt OD      	{ $$ = opr(FOR, 3, $3, $4, $7); }
	| '{' stmt_list '}' 				{ $$ = $2; }
	;
	
stmt_list : stmt
          | stmt_list stmt   		{ $$ = opr(';', 2, $1, $2); }
          ;
          

function  : function stmt    	{ ex($2); freeNode($2); }
          | /* NULL */
          ;
          

program   :  function PERIOD    	{ exit(0); }
          ;
	
%%

nodeType *con(int value) 
{ 
  nodeType *p; 
  
  /* allocate node */ 
  if ((p = malloc(sizeof(conNodeType))) == NULL) 
    yyerror("out of memory"); 
  /* copy information */ 
  p->type = typeCon; 
  p->con.value = value; 
  //printf("%d", value);
  return p; 
} 

nodeType *id(int i) 
{ 
  nodeType *p; 
  /* allocate node */ 
  if ((p = malloc(sizeof(idNodeType))) == NULL) 
    yyerror("out of memory"); 
  /* copy information */ 
  p->type = typeId; 
  p->id.i = i; 
  return p; 
} 

nodeType *opr(int oper, int nops, ...) 
{ 
  va_list ap; 
  nodeType *p; 
  size_t size; 
  int i; 

  /* allocate node */ 
  size = sizeof(oprNodeType) + (nops - 1) * sizeof(nodeType*); 
  if ((p = malloc(size)) == NULL) 
    yyerror("out of memory"); 
  /* copy information */
  p->type = typeOpr; 
  p->opr.oper = oper; 
  p->opr.nops = nops; 
  va_start(ap, nops); 
  for (i = 0; i < nops; i++) 
    p->opr.op[i] = va_arg(ap, nodeType*); 
  va_end(ap); 
  
  return p; 
}

void freeNode(nodeType *p) 
{ 
  int i; 

  if (!p) 
    return; 
  if (p->type == typeOpr) { 
    for (i = 0; i < p->opr.nops; i++) 
      freeNode(p->opr.op[i]); 
  } 
  free (p); 
} 

int ex(nodeType *p) 
{ 
  if (!p) 
    return 0; 
    int i = 0;
  switch(p->type) 
    { 
    case typeCon: return p->con.value; 
    case typeId: return sym[p->id.i]; 
    case typeOpr: switch(p->opr.oper) 
                    { 
		    case WHILE: while(ex(p->opr.op[0])) 
		                   ex(p->opr.op[1]); 
		                return 0; 
		    case IF: if (ex(p->opr.op[0])) 
		                ex(p->opr.op[1]); 
		             else if (p->opr.nops > 2) 
			             ex(p->opr.op[2]); 
		             return 0; 
		    case PRINT: printf("%d\n", ex(p->opr.op[0])); 
		                return 0; 
		    case ';': ex(p->opr.op[0]); 
		              return ex(p->opr.op[1]); 
		    //opr('=', 2, id($2), $5);
		    case '=': return sym[p->opr.op[0]->id.i] = ex(p->opr.op[1]);  
		    case '+': return ex(p->opr.op[0]) + ex(p->opr.op[1]); 
		    case '-': return ex(p->opr.op[0]) - ex(p->opr.op[1]); 
		    case '*': return ex(p->opr.op[0]) * ex(p->opr.op[1]); 
		    case '/': return ex(p->opr.op[0]) / ex(p->opr.op[1]); 
		    case GT: return ex(p->opr.op[0]) > ex(p->opr.op[1]); 
		    case LT: return ex(p->opr.op[0]) < ex(p->opr.op[1]); 
		    case NE: return ex(p->opr.op[0]) != ex(p->opr.op[1]); 
		    case EQ: return ex(p->opr.op[0]) == ex(p->opr.op[1]); 
		    } 
                      case FOR: 
                                for(i = ex(p->opr.op[0]); i < ex(p->opr.op[1]); i++) 
                                  ex(p->opr.op[2]);
                                
                                return 0;
                      case WHILE: while(ex(p->opr.op[0])) 
                                    ex(p->opr.op[1]); 
                                  return 0; 
                      case IF: if (ex(p->opr.op[0])) 
                                  ex(p->opr.op[1]); 
                              else if (p->opr.nops > 2) 
                                ex(p->opr.op[2]); 
                              return 0; 
                      case PRINT: printf("%d\n", ex(p->opr.op[0])); 
                                  return 0; 
                      case ';': ex(p->opr.op[0]); 
                                return ex(p->opr.op[1]); 
                      //opr('=', 2, id($2), $5);
                      case '=': return sym[p->opr.op[0]->id.i] = ex(p->opr.op[1]);  
                      case '+': return ex(p->opr.op[0]) + ex(p->opr.op[1]); 
                      case '-': return ex(p->opr.op[0]) - ex(p->opr.op[1]); 
                      case '*': return ex(p->opr.op[0]) * ex(p->opr.op[1]); 
                      case '/': return ex(p->opr.op[0]) / ex(p->opr.op[1]); 
                      case GT: return ex(p->opr.op[0]) > ex(p->opr.op[1]); 
                      case LT: return ex(p->opr.op[0]) < ex(p->opr.op[1]); 
                      case NE: return ex(p->opr.op[0]) != ex(p->opr.op[1]); 
                      case EQ: return ex(p->opr.op[0]) == ex(p->opr.op[1]); 
		   

    } 
}

void yyerror(char *s) 
{ 
  fprintf(stdout, "%s\n", s); 
} 

int main(void) 
{
#if YYDEBUG
  yydebug = 1;
#endif
  yyparse();
  return 0; 
}

