import complexo.*;

public class Main {

	public static void main(String[] args) {
		NumeroComplexo[] c = new NumeroComplexo[5];
		NumeroComplexo tmp = new NumeroComplexo();
		int i;
		double a, b;
		
		for (i = 0; i < 5; i++) {
			a = Math.round(10*Math.random());
			b = Math.round(10*Math.random());
			c[i] = new NumeroComplexo();
			c[i].inicializaNumero(a, b);
		}
		
		System.out.println("Teste do m�todo de impress�o:");
		for (i = 0; i < 5; i++) {
			System.out.print("c"+i+" = ");
			c[i].imprimeNumero();
			System.out.print("\n");
		}
		
		System.out.println("\nTeste do m�todo 'ehIgual'.");
		tmp = c[0];
		tmp.imprimeNumero(); System.out.print("\n");
		c[0].imprimeNumero(); System.out.print("\n");
		if(tmp.ehIgual(c[0])) {
			System.out.println("S�o iguais.");
		} else {
			System.out.println("S�o diferentes.");
		}
		c[0].imprimeNumero(); System.out.print("\n");
		c[1].imprimeNumero(); System.out.print("\n");
		if(c[0].ehIgual(c[1])) {
			System.out.println("S�o iguais.");
		} else {
			System.out.println("S�o diferentes.");
		}
		
		System.out.println("\nTestando m�todo de soma.");
		System.out.print("a = "); c[0].imprimeNumero();
		System.out.print("\nb = "); c[1].imprimeNumero();
		System.out.print("\na + b = "); c[0].soma(c[1]).imprimeNumero();;
		
		System.out.println("\n\nTestando m�todo de subtra��o.");
		System.out.print("a = "); c[2].imprimeNumero();
		System.out.print("\nb = "); c[3].imprimeNumero();
		System.out.print("\na - b = "); c[2].subtrai(c[3]).imprimeNumero();;		
		
		System.out.println("\n\nTestando m�todo de produto.");
		System.out.print("a = "); c[3].imprimeNumero();
		System.out.print("\nb = "); c[4].imprimeNumero();
		System.out.print("\na * b = "); c[3].multiplica(c[4]).imprimeNumero();;
		
		System.out.println("\n\nTestando m�todo de divis�o.");
		System.out.print("a = "); c[2].imprimeNumero();
		System.out.print("\nb = "); c[4].imprimeNumero();
		System.out.print("\na + b = "); c[2].divide(c[4]).imprimeNumero();;
	}

}
