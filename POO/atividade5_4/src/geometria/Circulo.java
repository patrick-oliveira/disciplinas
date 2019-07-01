package geometria;

public class Circulo {
	float raio;
	float area;
	float perimetro;
	int vertices = 1000;
	
	public Circulo(float raio) {
		this.raio = raio;
		setArea();
		setPerimetro();
	}
	
	public void setRaio(float raio) {
		this.raio = raio;
	}
	
	private void setArea() {
		this.area = (float)(Math.PI*Math.pow(this.raio, 2));
	}
	
	private void setPerimetro() {
		this.perimetro = (float)(Math.PI*2*this.raio);
	}
	
	public float getRaio() {
		return this.raio;
	}
	
	public float getArea() {
		return this.area;
	}
	
	public float getPerimetro() {
		return this.perimetro;
	}
	
	@Override
	public String toString() {
		return "Tipo: Circulo"+"\nÁrea: "+((Float)this.area).toString()
				+"\nPerímetro: "+((Float)this.perimetro).toString();
	}
}
