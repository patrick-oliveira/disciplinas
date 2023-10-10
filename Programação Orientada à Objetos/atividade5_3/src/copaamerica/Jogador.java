package copaamerica;

public class Jogador {
	int numero;
	String posicao;
	
	
	public Jogador(int numero, String posicao) {
		setNumero(numero);
		setPosicao(posicao);
	}
	
	public String getPosicao() {
		return posicao;
	}
	
	public void setNumero(int numero) {
		this.numero = numero;
	}
	
	public void setPosicao(String posicao) {
		this.posicao = posicao;
	}
	
	public String toString() {
		return "Numero: "+((Integer)numero).toString()+" - Posicao: " +
				posicao;
	}
}
