START "START"
END "END"
NUM [0-9]+\.?[0-9]*
VAR [a-z]
STR \"[^\"]*\"

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

{STR} {
    char *s = strndup(yytext + 1, strlen(yytext) - 2);
    yylval.str = s;
    return STR;
}


{INP}     {return INP;}
{OUT}     {return OUT;}

[ \r\n\t]*  {;}
[-+()=/*^]          {return *yytext;}
.   {printf("INVALID: %s\n", yytext);}
%%
