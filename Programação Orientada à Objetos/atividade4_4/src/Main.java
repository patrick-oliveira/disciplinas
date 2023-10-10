import listaligada.*;
import pessoa.Pessoa;

public class Main {

	public static void main(String[] args) {
		Pessoa p1 = new Pessoa("Pessoa 1");
		Pessoa p2 = new Pessoa("Pessoa 2");
		Pessoa p3 = new Pessoa("Pessoa 3");
		Pessoa p4 = new Pessoa("Pessoa 4");
		Pessoa p5 = new Pessoa("Pessoa 5");
		
		Pessoa joao = new Pessoa("Jo�o");
		Pessoa p0 = new Pessoa("Pessoa 0");
		Pessoa p9 = new Pessoa("Pessoa 9");
		Pessoa p25 = new Pessoa("Pessoa 2.5");
		
		ListaLigada lista = new ListaLigada();

		System.out.println("Testando inser��o no final");
		lista.adicionaItemNoFinal(p1);
		lista.adicionaItemNoFinal(p2);
		lista.adicionaItemNoFinal(p3);
		lista.adicionaItemNoFinal(p4);
		lista.adicionaItemNoFinal(p5);
		lista.adicionaItemNoFinal(joao);
		lista.imprimeListaLigada();
		
		System.out.println("Testando remo��o (por nome).");
		lista.removeItem("Jo�o");
		lista.removeItem("Pessoa 3");
		lista.imprimeListaLigada();
		
		System.out.println("Testando busca (por nome).");
		if(lista.buscaItem("Jo�o")) {
			System.out.println("Encontrado");
		} else {
			System.out.println("Jo�o n�o encontrado(a)");
		} 
		if (lista.buscaItem("Pessoa 1")) {
			System.out.println("Pessoa 1 encontrado(a).");
		}
		
		System.out.println("Testando inser��o ordenada");
		lista.adicionaOrdenado(p0);
		lista.adicionaOrdenado(p9);
		lista.adicionaOrdenado(p25);
		lista.imprimeListaLigada();
		
		System.out.println("Testando invers�o.");
		lista.inverteLista();
		lista.imprimeListaLigada();

	}

}
