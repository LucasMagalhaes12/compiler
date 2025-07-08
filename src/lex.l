%{
#include <string.h>
%}


number [0-9]+\.?[0-9]*
variable [a-z]+[0-9]*
endfile "endfile"
when "when"
otherwise "otherwise"
repeate_while "repeate_while"
repeate_for "repeate_for"
out "out"
outln "outln"
in "in"
inln "inln"
var "var"	
text [a-zA-Z]
string  \"(.)*\"

COMENTLINE "@".*
COMENT "/""*"(.|\n)*"*""/"


%%
{endfile} {return endfile;}
{when} {return when;} //IF
{otherwise} {return otherwise;} //ELSE
{repeate_while} {return repeate_while;} //WHILE
{repeate_for} {return repeate_for;} //FOR
{out} {return out;} //PRINT
{in} {return in;} //SCAN
{outln} {return outln;}
{inln} {return inln;}
{var} {return var;}

{variable} {
	strcpy(yylval.str,yytext);
	return variable;
}

{text} {
	strcpy(yylval.str,yytext);
	return text;
}

{number} {
	yylval.flo = atof(yytext);
	return number;
}

{string} {
    strncpy(yylval.str, yytext + 1, yyleng - 2);
    yylval.str[yyleng - 2] = '\0';
    return string;
}


[-+()=/*^{};\[\]] {return *yytext;}		

">" {yylval.fn = 1; return CMP; }
"<" {yylval.fn = 2; return CMP; }
"<>" {yylval.fn = 3; return CMP; }
"==" {yylval.fn = 4; return CMP; }
">=" {yylval.fn = 5; return CMP; }
"<=" {yylval.fn = 6; return CMP; }

{COMENTLINE} {;}
{COMENT} {;}
[\ \n\t]*	{;}
. {printf("(%s) ignored\n",yytext);}
%%
