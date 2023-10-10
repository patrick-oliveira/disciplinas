package criafiguras;

import geometria.Circulo;
import geometria.FiguraPlana;
import geometria.Quadrado;
import geometria.Retangulo;
import geometria.Triangulo;
import listaligada.*;

public class Principal {

	public static void main(String[] args) {
		FiguraPlana[] figuras = new FiguraPlana[4];
		ListaDuplamenteLigada lista = new ListaDuplamenteLigada();
		
		
		lista.adiciona(new Circulo(1));
		// Supondo que um triangulo valido eh inserido. Falta implementar um metodo para verificar isso.
		lista.adiciona(new Triangulo(2, 2, 3));
		lista.adiciona(new Retangulo(6, 7));
		lista.adiciona(new Quadrado(8));
		lista.adiciona(new Quadrado(1));
		lista.adiciona(new Triangulo(4, 4, 3));
		lista.adiciona(new Circulo(3));
		lista.adiciona(new Retangulo(3, 14));
		
		
		lista.imprimeListaLigada();
		
	}
	
}
