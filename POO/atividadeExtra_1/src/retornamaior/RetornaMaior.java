package retornamaior;


/*
 * 
 * Objetivo: praticar sobrecarga de metodos
 * 
 */

public class RetornaMaior {
	
	public static int retornaMaior(int a, int b) {
		return (a > b) ? a:b;
	}
	
	public static int retornaMaior(int a, int b, int c) {
		int maior = (a > b) ? a:b;
		return retornaMaior(maior, c);
	}
	
	public static int retornaMaior(int a, int b, int c, int d) {
		int maior = (a > b) ? a:b;
		return retornaMaior(maior, c, d);
	}
	
	public static int retornaMaior(int a, int b, int c, int d, int e) {
		int maior = (a > b) ? a:b;
		return retornaMaior(maior, c, d, e);
	}
	
	/*
	public static int retornaMaior(int... valores) {
		int n = valores.length;
		int maior = valores[0];
		for(int i = 0; i < n; i++) {
			if(valores[i] > maior) {
				maior = valores[i];
			}
		}
		return maior;
	}
	*/
}
