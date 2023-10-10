package geometria;

public abstract class Poligono extends FiguraPlana {
	float[] lados;
	
	public Poligono(float... lados) {
		super();
		this.lados = new float[lados.length];
		for(int i = 0; i < lados.length; i ++)
			this.lados[i] = lados[i];
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
