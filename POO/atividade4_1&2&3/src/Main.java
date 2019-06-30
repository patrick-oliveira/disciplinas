import listaligada.*;

public class Main {
	
	public static int getAleatorio() {
		return 0 + (int)(Math.random() * ((10 - 0) + 1));
	}
	
	public static void main(String[] args) {
		ListaLigada lista = new ListaLigada();
		ListaLigada lista_ordenada = new ListaLigada();
		int i, n;
		
		for (i = 0; i < 20; i++) {
			lista.adicionaItemNoFinal(getAleatorio());
		}
		
		lista.imprimeListaLigada();
		
		for (i = 0; i < 10; i++) {
			n = getAleatorio();
			if(lista.buscaItem(n)) {
				System.out.println("Removendo "+ n);
				lista.removeItem(n);
			} else {
				System.out.println("N�o encontrou "+ n);
			}
		}
		
		lista.imprimeListaLigada();
		
		System.out.println("Testando inser��o ordenada.");
		
		for(i = 0; i < 20; i++) {
			lista_ordenada.adicionaOrdenado(getAleatorio());
		}
		
		lista_ordenada.imprimeListaLigada();
		
		System.out.println("Testando invers�o de lista.");
		
		lista_ordenada.inverteLista();
		lista_ordenada.imprimeListaLigada();
		
		lista.inverteLista();
		lista.imprimeListaLigada();
	}

}
