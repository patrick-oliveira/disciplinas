package geometria;

public class Quadrado extends Retangulo{
	
	public Quadrado(float a) {
		super(a, a);
	}
	
	@Override
	public String toString() {
		return "Tipo: Quadrado"+"\nArea: "+((Float)this.area).toString()
				+"\nPerimetro: "+((Float)this.perimetro).toString();
	}
}
