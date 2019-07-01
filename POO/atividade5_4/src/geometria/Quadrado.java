package geometria;

public class Quadrado extends Retangulo{
	
	public Quadrado(float a) {
		super(a, a);
	}
	
	@Override
	public String toString() {
		return "Tipo: Quadrado"+"\nÁrea: "+((Float)this.area).toString()
				+"\nPerímetro: "+((Float)this.perimetro).toString();
	}
}
