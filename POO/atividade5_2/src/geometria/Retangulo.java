package geometria;

public class Retangulo extends Polígono {
	float a;
	float b;
	float area;
	float perimetro;
	
	public Retangulo(float a, float b) {
		this.a = a;
		this.b = b;
		setArea();
		setPerimetro();
	}
	
	private void setArea() {
		this.area = this.a*this.b;
	}
	
	private void setPerimetro() {
		this.perimetro = 2*(this.a + this.b);
	}
	
	public float getA() {
		return this.a;
	}
	
	public float getB() {
		return this.b;
	}
	
	public float getArea() {
		return this.area;
	}
	
	public float getPerimetro() {
		return this.perimetro;
	}
	
	@Override
	public String toString() {
		return "Tipo: Retângulo"+"\nÁrea: "+((Float)this.area).toString()
				+"\nPerímetro: "+((Float)this.perimetro).toString();
	}
}
