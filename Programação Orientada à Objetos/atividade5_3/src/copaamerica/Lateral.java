package copaamerica;

public class Lateral extends Jogador {
	private String lado;
	
	public Lateral(int numero, String posicao, String lado) {
		super(numero, posicao);
		setLado(lado);
	}
	
	public void setLado(String lado) {
		this.lado = lado;
	}
	
	public String getLado() {
		return lado;
	}
	
	@Override
	public String toString() {
		return super.toString() + " - Lado: " + lado; 
	}

}
