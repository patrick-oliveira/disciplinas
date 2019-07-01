package geometria;

public class Triangulo extends Polígono {
	float a;
	float b;
	float c;
	float area;
	float perimetro;
	
	public Triangulo(float a, float b, float c) {
		this.a = a;
		this.b = b;
		this.c = c;
		setArea();
		setPerimetro();
	}
	
	private void setArea() {
		float altura = (float)Math.sqrt(Math.pow(this.a, 2) + Math.pow(this.c/2.0, 2));
		this.area = (float)(this.c*altura/2.0);
	}
	
	private void setPerimetro() {
		this.perimetro = this.a + this.b + this.c;
	}
	
	public float getA() {
		return this.a;
	}
	
	public float getB() {
		return this.b;
	}
	
	public float getC() {
		return this.c;
	}
	
	public float getArea() {
		return this.area;
	}
	
	public float getPerimetro() {
		return this.perimetro;
	}
	
	@Override
	public String toString() {
		return "Tipo: Triângulo"+"\nÁrea: "+((Float)this.area).toString()
				+"\nPerímetro: "+((Float)this.perimetro).toString();
	}
}
