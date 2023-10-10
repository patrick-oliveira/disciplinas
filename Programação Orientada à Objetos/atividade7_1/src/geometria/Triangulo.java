package geometria;

import excecoes.TrianguloInvalidoException;

public class Triangulo extends Poligono {
	
	public Triangulo(float a, float b, float c) throws TrianguloInvalidoException {
		super(a, b, c);
		if(a + b <= c || a + c <= b || b + c <= a) {
			throw new TrianguloInvalidoException();
		}
	}
	
	public void setNumeroLados() {
		this.numero_lados = 3;
	}

	public void setArea() {
		float a = this.lados[0];
		float b = this.lados[1];
		float c = this.lados[2];
		
		float S = (a+b+c)/2.0f;
		
		this.area = (float)(Math.sqrt(S*(S-a)*(S-b)*(S-c)));
	}
	
	public void setPerimetro() {
		float a = this.lados[0];
		float b = this.lados[1];
		float c = this.lados[2];
		this.perimetro = a + b + c;
	}
	
	public float getA() {
		return this.lados[0];
	}
	
	public float getB() {
		return this.lados[1];
	}
	
	public float getC() {
		return this.lados[2];
	}
	
	@Override
	public String toString() {
		return "Tipo: Triangulo"+"\nArea: "+((Float)this.area).toString()
				+"\nPerimetro: "+((Float)this.perimetro).toString();
	}
}
