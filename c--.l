/****************************************************/
/* Henrique Augusto Brasileiro Santos 201010006720  */
/* Linguagem c-- analisador Lexico                  */
/* baseado no livreo de  Kenneth C. Louden          */
/****************************************************/

%{

//#include "globais.h"
#include <stdio.h>
#include <stdlib.h>
#include "utilis.h"
#include "novo.tab.h"

%}

digito      [0-9]
numero      {digito}+
letra       [a-zA-Z]
id	    {letra}+
tab         [\\t]
espaco      [ \t]+
%%
"/*"		{comentario(); return COMENTARIO;}
"\""            {return strment(); }
"if"            {return IF;}
"then"          {return THEN;}
"else"          {return ELSE;}
"end"           {return END;}
"repeat"        {return REPEAT;}
"until"         {return UNTIL;}
"read"          {return READ;}
"write"         {return WRITE;}
":="            {return ASSIGN;}
"="             {return EQ;}
"<"             {return LT;}
"+"             {return PLUS;}
"-"             {return MINUS;}
"*"             {return TIMES;}
"/"             {return OVER;}
"("             {return LPAREN;}
")"             {return RPAREN;}
";"             {return SEMI;}
"string"        {return STRING;}
[ ]		{}
"\\t"           {return TAB;}
"\\n"           {return NL;}
{numero}        {return NUM;}
{id}            {return ID;}
"{"             {return comentario2();}
.               {return ERROR;}

%%
int yywrap(void)
{
  return 1;
}


comentario()
{
    char c,c1;
    int n=1;
    c=input();
     printf(" Tokken %s \n","inicio comentario");
    while (n!=0)
    {
      c1=input();
      if ((c=='/') && (c1=='*'))
      {

          printf(" Tokken %s \n","inicio comentario");
          c1=input();
          n++;

      }else  if ((c=='*') &&(c1=='/'))
      {
          printf(" Tokken %s  \n","fim comentario");
	  n--;
          c1=input();
      }
      c=c1;
    }
return COMENTARIO;
}
comentario2()
{
    char c;
    int n=1;
    do
    { c = input();
      if (c == EOF) break;
      if (c == '\n') yylineno++;
      if (c == '{') n++;
      if (c == '}') n--;
    } while (n!=0);
    

return COMENTARIO;
}
strment()
{
	char c,c2;
        char *c1;
        c=input();
        c1=malloc(1*sizeof(char));
       // c1[0]=c;
        int n=1;
	while (c != 34	)
	{
		if (c==92)
		{
			c2=c;
			c=input();
			if (c==34)
			{
				char *temp2 = realloc(c1, n*sizeof(int));
		                c1=temp2;
        			c1[n-1]=c2;
				n++;
			}
		}
		//putchar(c);*/
		
		char *temp = realloc(c1, n*sizeof(int));
                c1=temp;
                c1[n-1]=c;
		c=input();
                 n++;
	}

        	printf("STR(%s)",c1);

        return STR;
}
