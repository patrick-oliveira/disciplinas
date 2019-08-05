package autenticacao;

import java.util.Scanner;

public class AutenticacaoPorSwipe implements IMetodoAutenticacao {

	@Override
	public UsuarioAutenticado autenticar() throws UsuarioNaoAutenticadoException {
		Scanner leitor = new Scanner(System.in);
		System.out.println("Código:\n");
		int codigo = leitor.nextInt();
		System.out.println("Nome:");
		String nome = leitor.next();
		
		System.out.println("   1 2 3");
		System.out.println("1  o o o");
		System.out.println("2  o o o");
		System.out.println("3  o o o");
		
		System.out.println("Senha:");
		int senha = leitor.nextInt();
		if(senha == 112233) {
			return new UsuarioAutenticado(codigo, nome);
		} else {
			throw new UsuarioNaoAutenticadoException();
		}
	}
	
}
