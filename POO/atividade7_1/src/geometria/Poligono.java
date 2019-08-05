package geometria;

import excecoes.ValorNegativoException;

public abstract class Poligono extends FiguraPlana {
	float[] lados;
	
	public Poligono(float... lados) throws ValorNegativoException {
		super();
		this.lados = new float[lados.length];
		for(int i = 0; i < lados.length; i ++) {
			this.lados[i] = lados[i];
			if(lados[i] < 0) {
				throw new ValorNegativoException();
			}
		}
		setNumeroLados();
		setArea();
		setPerimetro();
		
	}
	
	public void getLados() {
		for(int i = 0; i < lados.length; i++) {
			System.out.println(lados[i]);
		}
	}
	
	
}
