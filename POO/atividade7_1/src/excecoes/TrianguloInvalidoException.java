package excecoes;

public class TrianguloInvalidoException extends Exception {
	
	public TrianguloInvalidoException() {
		super("Este n�o � um tri�ngulo v�lido.");
	}
}
