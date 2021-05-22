lex fisier.l
yacc -d primu.y 
gcc y.tab.c lex.yy.c -ly -ll
./a.out < taci.in

