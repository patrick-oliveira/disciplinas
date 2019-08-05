package excecoes;

public class LimiteAtingidoException extends Exception {
	public LimiteAtingidoException() {
		super("Limite do vetor atingido. Funcionário não cadastrado.");
	}
}
