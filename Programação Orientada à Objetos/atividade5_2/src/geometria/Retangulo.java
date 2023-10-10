package geometria;

public class Retangulo extends Poligono {
	
	public Retangulo(float a, float b) {
		super(a, b);
		setArea();
		setPerimetro();
	}
	
	public void setNumeroLados() {
		this.numero_lados = 4;
	}
	
	public void setArea() {
		float a = this.lados[0];
		float b = this.lados[1];
		this.area = a*b;
	}
	
	public void setPerimetro() {
		float a = this.lados[0];
		float b = this.lados[1];
		this.perimetro = 2*(a + b);
	}
	
	public float getA() {
		return this.lados[0];
	}
	
	public float getB() {
		return this.lados[1];
	}
	
	@Override
	public String toString() {
		return "Tipo: Retangulo"+"\nArea: "+((Float)this.area).toString()
				+"\nPerimetro: "+((Float)this.perimetro).toString();
	}
}
