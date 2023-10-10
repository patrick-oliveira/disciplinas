package caixaatendimento;

public class CaixaAtendimento {
	private int identificador = -1;
	public static int senha = 0;
	
	public CaixaAtendimento(int identificador) {
		setIdentificador(identificador);
	}
	public void setIdentificador(int identificador) {
		this.identificador = identificador;
	}
	public void chamaProximoFila() {
		System.out.println("Próxima Senha: "+CaixaAtendimento.senha);
		CaixaAtendimento.senha++;
	}
	public int getIdentificador() {
		return this.identificador;
	}
}
