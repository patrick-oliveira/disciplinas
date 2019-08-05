package geometria;

public abstract class FiguraPlana {
	public float area;
	public float perimetro;
	public float numero_lados;

	public float getArea() {
		return area;
	}
	public float getPerimetro() {
		return perimetro;
	}
	public float getNumeroLados() {
		return numero_lados;
	}
	public abstract void setArea();
	public abstract void setPerimetro();
	public abstract void setNumeroLados();
}
