package geometria;

public class Circulo extends FiguraPlana {
	float raio;
	
	public Circulo(float raio) {
		super();
		setRaio(raio);
		setArea();
		setPerimetro();
		setNumeroLados();
	}
	
	public void setNumeroLados() {
		this.numero_lados = Integer.MAX_VALUE;
	}
	
	public void setRaio(float raio) {
		this.raio = raio;
	}
	
	public void setArea() {
		this.area = (float)(Math.PI*Math.pow(this.raio, 2));
	}
	
	public void setPerimetro() {
		this.perimetro = (float)(Math.PI*2*this.raio);
	}
	
	public float getRaio() {
		return this.raio;
	}
	
	@Override
	public float getArea() {
		return this.area;
	}
	
	@Override
	public float getPerimetro() {
		return this.perimetro;
	}
	
	@Override
	public String toString() {
		return "Tipo: Circulo"+"\nArea: "+((Float)this.area).toString()
				+"\nPerimetro: "+((Float)this.perimetro).toString();
	}
}
