import universidade.*;
import autenticacao.*;
import java.util.Scanner;

public class SistemaNotas {

	private static IMetodoAutenticacao autenticacao;

	private static void inicializaAutenticacao(String tipo) throws Exception {
		if (tipo.equals("senha"))
			autenticacao = new AutenticacaoPorSenha();
		else if (tipo.equals("swipe"))
			autenticacao = new AutenticacaoPorSwipe();
		else
			throw new Exception("Tipo de autenticacao invalido!");
	}

	public static void main(String[] args) throws Exception {
		Scanner leitor = new Scanner(System.in);

		System.out.println("Digite o tipo de autenticação: senha/swipe");
		String tipo = leitor.next();

		inicializaAutenticacao(tipo);

		ListaNotas lista = new ListaNotas(10);
		lista.adicionarItemNota(new ItemNota(123, "POO", 10.0));
		lista.adicionarItemNota(new ItemNota(555, "PI", 8.0));
		lista.adicionarItemNota(new ItemNota(555, "POO", 10.0));
		lista.adicionarItemNota(new ItemNota(123, "PE", 5.0));
		lista.adicionarItemNota(new ItemNota(123, "PI", 2.0));

		lista.imprimirNotasAula(autenticacao); // Passa metodo de autenticacao instanciado
	}

}