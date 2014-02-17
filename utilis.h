#ifndef _UTILIS_H_
#define _UTILIS_H_
typedef int TokenType;

extern FILE* source; /* source code text file */
FILE* listing; /* listing output text file */
extern FILE* code; /* code text file for TM simulator */

int lineno; /* source line number for listing */

/**************************************************/
/***********   Syntax tree for parsing ************/
/**************************************************/

typedef enum {StmtK,ExpK} NodeKind;
typedef enum {IfK,RepeatK,AssignK,ReadK,WriteK} StmtKind;
typedef enum {OpK,ConstK,IdK} ExpKind;

/* ExpType is used for type checking */
typedef enum {Void,Integer,Boolean} ExpType;

#define MAXCHILDREN 3

typedef struct treeNode
   { struct treeNode * child[MAXCHILDREN];
     struct treeNode * sibling;
     int lineno;
     NodeKind nodekind;
     union { StmtKind stmt; ExpKind exp;} kind;
     union { TokenType op;
             int val;
	     char * vals;
             char * name; } attr;
     ExpType type; /* for type checking of exps */
   } treeNode;



treeNode * newStmtNode(StmtKind kind);

treeNode * newExpNode(ExpKind kind);

char * copyString(char * s);


#endif
