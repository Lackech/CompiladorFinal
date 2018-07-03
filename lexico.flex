
/* --------------------------Codigo de Usuario----------------------- */
package analizadorsyntax;

import java_cup.runtime.*;
import java.io.Reader;
      
%% //inicio de opciones
   
/* ------ Seccion de opciones y declaraciones de JFlex -------------- */  
   
/* 
    Cambiamos el nombre de la clase del analizador a Lexer
*/
%class AnalizadorLexico

/*
    Activar el contador de lineas, variable yyline
    Activar el contador de columna, variable yycolumn
*/
%line
%column
    
/* 
   Activamos la compatibilidad con Java CUP para analizadores
   sintacticos(parser)
*/
%cup
   
/*
    Declaraciones

    El codigo entre %{  y %} sera copiado integramente en el 
    analizador generado.
*/
%{

	public String lexeme;
    
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
    
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}
   

/*
    Macro declaraciones
  
    Declaramos expresiones regulares que despues usaremos en las
    reglas lexicas.
*/
   
Numerico = -?[\d]+
WHITE=[ \t\r]
SALTO=[\n]
L=[a-zA-Z_]
D=[0-9]


%% //fin de opciones
/* -------------------- Seccion de reglas lexicas ------------------ */
   

   
//Declaracion


<YYINITIAL> {

"Funcion" {	//System.out.println(yytext() + "  - $Funcion$"); 	
                lexeme = yytext();
                return symbol(sym.funcion,yytext());                 }


//Símbolos

\[ {		//System.out.println(yytext() + "  - símbolo");
                lexeme = yytext();
		return symbol(sym.simbolo_cuadrado_inicio,yytext()); }

\] {		//System.out.println(yytext() + "  - símbolo");	
                lexeme = yytext();
            	return symbol(sym.simbolo_cuadrado_fin,yytext());    }

Y {		//System.out.println(yytext() + "  - símbolo");	
                lexeme = yytext();
                return symbol(sym.simbolo_and,yytext());             }

O {		//System.out.println(yytext() + "  - símbolo");	
                lexeme = yytext();
        	return symbol(sym.simbolo_or,yytext());              }

\( {		//System.out.println(yytext() + "  - símbolo");
                lexeme = yytext();
                return symbol(sym.simbolo_paren_inicio,yytext());	}

\) {		//System.out.println(yytext() + "  - símbolo");	
                lexeme = yytext();
        	return symbol(sym.simbolo_paren_fin,yytext());       }
		
		
"Terminar" {	//System.out.println(yytext() + "  - símbolo");
                lexeme = yytext();
		return symbol(sym.terminar,yytext());                }

Es {		//System.out.println(yytext() + "  - símbolo =");
                lexeme = yytext();
        	return symbol(sym.simbolo_assign,yytext());          }

\+ {		//System.out.println(yytext() + "  - símbolo +");	
                lexeme = yytext();
        	return symbol(sym.simbolo_suma,yytext());            }

- {		//System.out.println(yytext() + "  - símbolo -");	
                lexeme = yytext();
        	return symbol(sym.simbolo_resta,yytext());           }

\* {		//System.out.println(yytext() + "  - símbolo *");
                lexeme = yytext();
                return symbol(sym.simbolo_multi,yytext());		}

\/ {		//System.out.println(yytext() + "  - símbolo /");
                lexeme = yytext();
                return symbol(sym.simbolo_div,yytext());     	}

//Declaraciones de variables

Numero {	//System.out.println(yytext() + "  - declaración de variable");	
                lexeme = yytext();
                return symbol(sym.decla_numero,yytext());                  }

Booleano {	//System.out.println(yytext() + "  - declaración de variable");	
                lexeme = yytext();
                return symbol(sym.decla_bool,yytext());                    }

Hilera {	//System.out.println(yytext() + "  - declaración de variable");	
                lexeme = yytext();
                return symbol(sym.decla_hilera,yytext());                  }

//Valores de variables

Verdadero {	//System.out.println(yytext() + "  - booleano");
                lexeme = yytext();
                return symbol(sym.true_tk,yytext());                    }

Falso {		//System.out.println(yytext() + "  - booleano");
                lexeme = yytext();
                return symbol(sym.false_tk,yytext());                   }

{Numerico} {	//System.out.println(yytext() + "  - número");	
                lexeme = yytext();
                return symbol(sym.numero,yytext());                  }


		
//Instrucciones

Desde {		//System.out.println(yytext() + "  - inicio for");
                lexeme = yytext();
                return symbol(sym.inicio_for,yytext());              }

Hasta {		//System.out.println(yytext() + "  - final for");	
                lexeme = yytext();
                return symbol(sym.final_for,yytext());               }

Restar {	//System.out.println(yytext() + " - altera contador");	
                lexeme = yytext();
                return symbol(sym.dec_contador,yytext());            }

Sumar {         //System.out.println(yytext() + " - altera contador");	
                lexeme = yytext();
                return symbol(sym.inc_contador,yytext());            }		

Imprime {	//System.out.println(yytext() + "  - print");	
                lexeme = yytext();
                return symbol(sym.print_tk,yytext());                   }

ImprimeCambioLinea {	//System.out.println(yytext() + "  - println");	
                lexeme = yytext();
                return symbol(sym.println_tk,yytext());                 }
		
Modulo {	//System.out.println(yytext() + "  - operacion mod");	
                lexeme = yytext();
                return symbol(sym.mod,yytext());                     }

Raiz {		//System.out.println(yytext() + "  - calculo raiz");	
                lexeme = yytext();
                return symbol(sym.raiz,yytext());                    }

Si {		//System.out.println(yytext() + "  - instruccion if");
                lexeme = yytext();
                return symbol(sym.if_tk,yytext());                      }
		
Sino {		//System.out.println(yytext() + "  - instruccion else");
                lexeme = yytext();
                return symbol(sym.else_tk,yytext());                    }

Retornar {	//System.out.println(yytext() + " - instruccion return");
                lexeme = yytext();
                return symbol(sym.return_tk,yytext());                  }

Mientras {	//System.out.println(yytext() + "  - instruccion while");
                lexeme = yytext();
                return symbol(sym.while_tk,yytext());                   }

//Comparacion

Igual {		//System.out.println(yytext() + "  - comparación igual");	
                lexeme = yytext();
                return symbol(sym.comp_igual,yytext());              }

Diferente {	//System.out.println(yytext() + " - comparacion diferente");
                lexeme = yytext();
                return symbol(sym.comp_difer,yytext());              }

MenorIgual {	//System.out.println(yytext() + " - comparacion menor o igual");
                lexeme = yytext();
                return symbol(sym.comp_menor_igual,yytext());        }
		
MayorIgual {	//System.out.println(yytext() + "  - comparacion mayor o igual");
                lexeme = yytext();
                return symbol(sym.comp_mayor_igual,yytext());        }

Menor {		//System.out.println(yytext() + "  - comparación menor");	
                lexeme = yytext();
                return symbol(sym.comp_menor,yytext());              }

Mayor {		//System.out.println(yytext() + "  - comparacion mayor");
                lexeme = yytext();
                return symbol(sym.comp_mayor,yytext());              }
				
{SALTO} { return symbol(sym.salto,yytext());}				
{WHITE} {/* ignore */}

{L}({L}|{D})* {lexeme=yytext(); return symbol(sym.id,yytext());}
	
		
. {             //Nothing   
                return symbol(sym.error_tk,yytext());               
}

}

/* Si el token contenido en la entrada no coincide con ninguna regla
    entonces se marca un token ilegal */
[^]                    { throw new Error("Caracter ilegal <"+yytext()+">"); }