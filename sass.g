grammar sass;
@members {
int contHead = 0;
int contBody = 0;
}
sass 
    	:	charset
        	variabledeclaration*
		rule*
	;

// charset opcional
charset	
	:	(CHARSET_ID STRING SC)?
	;

// declaração de variáveis
variabledeclaration
	:	variable CL value SC ; // $blue: #3bbfce;

// regras de css: seletores { propriedades }
rule 
	:	rulehead BL 
			rulebody 
		BR
		{	
			System.out.println("\n" + contHead + ":rulehead: "+$rulehead.text);
			contHead++;
		}
		{
			System.out.println(contBody + ":rulebody: "+$rulebody.text);
			contBody++;
		}
	;
// cabeçalho da regra, pode ter vários seletores, inclusive separado por vírgula
rulehead
	:	selector (COMMA selector)*
	;

// seletor
selector
	:	WORD (SHARP | DOT) WORD 	// table.h1 ou li#classe
	| 	(SHARP | DOT)? WORD 		// .classe ou #id ou tag
	| 	SHARP WORD DOT WORD 		// .classe ou #id ou tag
	|	AMP CL WORD			// &:hover
	;

// corpo da regra, pode possuir uma declaração de propriedade ou uma nova regra aninhada
rulebody
	:	(
			propertydeclaration	// declaração de propriedade
		|	rule			// regra aninhada
		)*;

// declaração de uma propriedade
propertydeclaration	
	:	WORD CL
		(
			(WORD | variable)+ SC		// propriedade ou variável
		|	BL (propertydeclaration)* BR	// propriedade aninhada
		)
		;

value 		: WORD;
variable	: DOLLAR WORD;

		// tokens
DOT    	       	: '.';
COMMA			: ',';
SHARP  	       	: '#';
CL    	       	: ':';
SC     	       	: ';';
BL     	       	: '{';
BR     	       	: '}';
DOLLAR			: '$';
AMP				: '&';
CHARSET_ID     	: '@charset ';

WORD		: ('a'..'z'|'A'..'Z'|'0'..'9'|'-'|'#'|'%')+ ;
STRING  	: '\'' ( ~('\n'|'\r'|'\f'|'\'') )* '\'';



NL		: '\r'? '\n' 	{skip();} ;
WS  		: (' '|'\t')+ 	{skip();} ;
COMMENT		: '/*' .* '*/' 	{skip();} ;