/*
 *  The scanner definition for COOL.
 */

/*
 *  Stuff enclosed in %{ %} in the first section is copied verbatim to the
 *  output, so headers and global definitions are placed here to be visible
 * to the code in the file.  Don't remove anything that was here initially
 */
%{
#include <cool-parse.h>
#include <stringtab.h>
#include <utilities.h>

/* The compiler assumes these identifiers. */
#define yylval cool_yylval
#define yylex  cool_yylex

/* Max size of string constants */
#define MAX_STR_CONST 1025
#define YY_NO_UNPUT   /* keep g++ happy */

extern FILE *fin; /* we read from this file */

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
		YY_FATAL_ERROR( "read() in flex scanner failed");

char string_buf[MAX_STR_CONST]; /* to assemble string constants */
char *string_buf_ptr;

extern int curr_lineno;
extern int verbose_flag;

extern YYSTYPE cool_yylval;
int comment_no = 0;
int null_found = 0;

/*
 *  Add Your own definitions here
 */

%}

/*
 * Define names for regular expressions here.
 */


%x comment
%x string

DARROW          =>
LE		<=
CLASS		[cC][lL][aA][sS][sS]
ELSE		[eE][lL][sS][eE]
FI		[fF][iI]
IF		[iI][fF]
IN		[iI][nN]
INHERITS 	[iI][nN][hH][eE][rR][iI][tT][sS]
LET      	[lL][eE][tT]
LOOP     	[lL][oO][oO][pP]
POOL     	[pP][oO][oO][lL]
THEN     	[tT][hH][eE][nN]
WHILE    	[wW][hH][iI][lL][eE]
CASE     	[cC][aA][sS][eE]
ESAC     	[eE][sS][aA][cC]
OF       	[oO][fF]
NEW      	[nN][eE][wW]
ISVOID   	[iI][sS][vV][oO][iI][dD]
NOT      	[nN][oO][tT]
TRUE		t[rR][uU][eE]		
FALSE		f[aA][lL][sS][eE]
TYPEID		[A-Z][a-zA-Z0-9_]*		
OBJECTID	[a-z][a-zA-Z0-9_]*
ASSIGN		<-
INTCONST	[0-9]+
SYMBOL    	[-.(){}:@,;+*/~<=]

%%

 /*
  *  Nested comments
  */


 /*
  *  The multiple-character operators.
  */

{DARROW}		{return (DARROW);}
{NEW}			{return (NEW);}
{CLASS}			{return (CLASS);}
{NOT}			{return (NOT);}
{WHILE}			{return (WHILE);}
{LOOP}			{return (LOOP);}
{POOL}			{return (POOL);}			
{IF}			{return (IF);}
{FI}			{return (FI);}
{LET}			{return (LET);}
{THEN}			{return (THEN);}
{CASE}			{return (CASE);}
{ELSE}			{return (ELSE);}
{IN}			{return (IN);}
{INHERITS}		{return (INHERITS);}
{ESAC}			{return (ESAC);}
{ISVOID}		{return (ISVOID);}
{LE}			{return (LE);}
{TRUE}			{cool_yylval.boolean = 1; return (BOOL_CONST);}			
{FALSE}			{cool_yylval.boolean = 0; return (BOOL_CONST);}
{INTCONST}		{cool_yylval.symbol = inttable.add_string(yytext);return (INT_CONST);}
{TYPEID}		{cool_yylval.symbol = stringtable.add_string(yytext);return (TYPEID);}
{OBJECTID}		{cool_yylval.symbol = stringtable.add_string(yytext);return (OBJECTID);}

"(*"			{BEGIN(comment); comment_no = 1;} 
"*)"			{cool_yylval.error_msg = "Unmatched *)"; return (ERROR);}
\"			{BEGIN(string); string_buf_ptr = string_buf; null_found = 0;} 
"--".*			{}
[ \f\r\t\v]		{}
{SYMBOL} 		{return (int) yytext[0];}

<comment>"\n"		{curr_lineno++;}
<comment>"(*"		{comment_no++;}
<comment>"*)"		{
				comment_no--;
				if (comment_no == 0)
					BEGIN(INITIAL);
				}
<comment><<EOF>>	{BEGIN(INITIAL); cool_yylval.error_msg = "EOF in comment"; return ERROR;}
<string><<EOF>>		{BEGIN(INITIAL);  cool_yylval.error_msg = "EOF in string constant"; return ERROR;}
<string>\"		{
				BEGIN(INITIAL);
				if (string_buf_ptr>(string_buf+MAX_STR_CONST)){
					*string_buf_ptr = '\0';
					cool_yylval.error_msg = "String constant too long";
        				return (ERROR);
				}
				else if (!null_found) {

				        cool_yylval.symbol = stringtable.add_string(string_buf);
				        return (STR_CONST);
			 	}
			}
					
<string>\n		{
				BEGIN(INITIAL);
				curr_lineno++;
				if (!null_found){
					cool_yylval.error_msg = "Unterminated string constant";
					 return(ERROR);
				}
			}

<string>[\0]		{null_found = 1; cool_yylval.error_msg = "String contains null character"; return(ERROR);}


<string>.		{ *string_buf_ptr++ = *yytext; }	




<string>\\b		{*string_buf_ptr++ = '\b';}
<string>\\t 		{*string_buf_ptr++ = '\t';}
<string>\\n		{*string_buf_ptr++ = '\n';}
<string>\\f		{*string_buf_ptr++ = '\f';}
<string>"\\\""		{*string_buf_ptr++ = '"';}
<string>"\\\n"		{ curr_lineno++; *string_buf_ptr++ = '\n'; }
<string>"\\\\"		{ *string_buf_ptr++ = '\\'; }


\n			{curr_lineno++;}
.			{cool_yylval.error_msg = yytext; return(ERROR);}

 /*
  * Keywords are case-insensitive except for the values true and false,
  * which must begin with a lower-case letter.
  */


 /*
  *  String constants (C syntax)
  *  Escape sequence \c is accepted for all characters c. Except for 
  *  \n \t \b \f, the result is c.
  *
  */


%%
