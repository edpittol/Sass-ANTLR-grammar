grammar sass;

sass 
    :   
    	charset
        variabledeclaration*
	rule*
    ;

// charset opcional
charset	
	:	(CHARSET_ID STRING SC)?
	;

// declaração de variáveis
variabledeclaration
	:	VARIABLE CL .+ SC ; // $blue: #3bbfce;

// regras de css: seletores { propriedades }
// TODO: implementar para aceitar regras aninhadas
rule 
	:	rulehead BL (propertydeclaration | rule)* BR
	;

// cabeçalho da regra, pode ter vários seletores, inclusive separado por vírgula
// TODO: implementar para aceitar com vírgula
rulehead
	:	selector
	;

// seletor
selector
	:	WORD (SHARP | DOT) WORD //table.h1 ou li#classe
	| 	(SHARP | DOT)? WORD // .classe ou #id ou tag
	| 	SHARP WORD DOT WORD // .classe ou #id ou tag
	;

// declaração de uma propriedade
// TODO : implementar para aceitar propriedades aninhadas
propertydeclaration	
	:	WORD CL (WORD | VARIABLE)+ SC // margin: 10px; margin 10px 10px...;
	;


// tokens
DOT    	       	: '.';
COMMA		: ',';
SHARP  	       	: '#';
CL    	       	: ':';
SC     	       	: ';';
BL     	       	: '{';
BR     	       	: '}';
DOLLAR		: '$';
CHARSET_ID     	: '@charset ';

WORD		: ('a'..'z'|'A'..'Z'|'0'..'9'|'-')+ ;
STRING  	: '\'' ( ~('\n'|'\r'|'\f'|'\'') )* '\'';
VARIABLE	: DOLLAR WORD;

NL		: '\r'? '\n' {skip();} ;
WS  		: (' '|'\t')+ {skip();} ;
COMMENT		: '/*' .* '*/' {skip();} ;
