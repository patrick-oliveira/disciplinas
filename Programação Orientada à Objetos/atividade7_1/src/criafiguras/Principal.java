package criafiguras;

import excecoes.TrianguloInvalidoException;
import excecoes.ValorNegativoException;
import geometria.Circulo;
import geometria.FiguraPlana;
import geometria.Quadrado;
import geometria.Retangulo;
import geometria.Triangulo;

public class Principal {

	public static void main(String[] args) {
		FiguraPlana[] figuras = new FiguraPlana[6];
		
		try {
			figuras[0] = new Circulo(1);
			figuras[1] = new Triangulo(2, 2, 3);
			figuras[2] = new Retangulo(6, 7);
			figuras[3] = new Quadrado(8);
			figuras[4] = new Triangulo(1, 1, 2);
		} catch(TrianguloInvalidoException e) {
			e.printStackTrace();
		}
		
		try {
			figuras[5] = new Retangulo(-5, 6);
		} catch(ValorNegativoException e) {
			e.printStackTrace();
		}
		
		for(int i = 0; i < figuras.length; i++) {
			try {
				System.out.println(figuras[i].toString()+"\n");
			} catch (NullPointerException e) {
				System.out.println("Problemas com a figura "+i);
			}
		}
	}
	
}
