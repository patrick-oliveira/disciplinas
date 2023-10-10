package autenticacao;

import java.util.Scanner;

public class AutenticacaoPorSenha implements IMetodoAutenticacao {

	@Override
	public UsuarioAutenticado autenticar() throws UsuarioNaoAutenticadoException {
		Scanner leitor = new Scanner(System.in);
		System.out.println("Código:");
		int codigo = leitor.nextInt();
		System.out.println("Nome:");
		String nome = leitor.next();
		System.out.println("Senha:");
		String senha = leitor.next();
		if(senha.equals("1234")) {
			return new UsuarioAutenticado(codigo, nome);
		} else {
			throw new UsuarioNaoAutenticadoException();
		}
	}

}
