package excecoes;

public class NaoHaFuncionariosCadastradosException extends Exception {
	public NaoHaFuncionariosCadastradosException() {
		super("N�o h� funcion�rios cadastrados. Leitura n�o realizada.");
	}
}
