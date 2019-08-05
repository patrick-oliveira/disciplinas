package excecoes;

public class NaoHaFuncionariosCadastradosException extends Exception {
	public NaoHaFuncionariosCadastradosException() {
		super("Não há funcionários cadastrados. Leitura não realizada.");
	}
}
