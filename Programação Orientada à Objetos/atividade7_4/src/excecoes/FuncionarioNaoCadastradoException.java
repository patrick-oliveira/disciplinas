package excecoes;

import funcionario.Funcionario;

public class FuncionarioNaoCadastradoException extends Exception {
	
	public FuncionarioNaoCadastradoException(int Id) {
		super("Funcionario com ID "+Id+" não cadastrado.");
	}
}
