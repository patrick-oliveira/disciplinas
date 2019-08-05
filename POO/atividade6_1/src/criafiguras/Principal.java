package criafiguras;

import geometria.Circulo;
import geometria.FiguraPlana;
import geometria.Quadrado;
import geometria.Retangulo;
import geometria.Triangulo;

public class Principal {

	public static void main(String[] args) {
		FiguraPlana[] figuras = new FiguraPlana[4];
		figuras[0] = new Circulo(1);
		// Supondo que um triangulo valido eh inserido. Falta implementar um metodo para verificar isso.
		figuras[1] = new Triangulo(2, 2, 3);
		figuras[2] = new Retangulo(6, 7);
		figuras[3] = new Quadrado(8);
		
		for(int i = 0; i < figuras.length; i++) {
			System.out.println(figuras[i].toString()+"\n");
		}
	}
	
}
