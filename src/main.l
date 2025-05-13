START "START"
END "END"
NUM [0-9]+\.?[0-9]*
VAR [a-z]

INP	"input"
OUT "output"


%%
{START}   {return START;}
{END}     {return END;}

{NUM} {
    yylval.flo = atof(yytext);
    return NUM;
}

{VAR} {
    yylval.inte = *yytext - 'a';
    return VAR;
}

{INP}     {return INP;}
{OUT}     {return OUT;}

[ \r\n\t]*  {;}
[-+()=/*^]          {return *yytext;}
.   {printf("INVALID: %s\n", yytext);}
%%
