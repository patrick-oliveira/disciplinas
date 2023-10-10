package excecoes;

public class ValorNegativoException extends RuntimeException {
	
	public ValorNegativoException() {
		super("Valor negativo passado como argumento.");
	}
}
