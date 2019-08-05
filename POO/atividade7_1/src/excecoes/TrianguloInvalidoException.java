package excecoes;

public class TrianguloInvalidoException extends Exception {
	
	public TrianguloInvalidoException() {
		super("Este não é um triângulo válido.");
	}
}
