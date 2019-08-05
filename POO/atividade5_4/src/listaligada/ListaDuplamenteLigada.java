package listaligada;
import geometria.*;

public class ListaDuplamenteLigada {
	private LinkedNode first = null;
	private LinkedNode last = null;
	
	public void adiciona(FiguraPlana item) {
		LinkedNode novoItem = new LinkedNode();
		novoItem.figura = item;
		novoItem.proximo = null;
		novoItem.anterior = null;
		
		if (this.first == null) {
			this.first = novoItem;
			this.last = novoItem;
		} else {
			LinkedNode anterior = null;
			LinkedNode atual = first;
			while (atual != null && atual.figura.comparaFigura(item) <= 0) {
				anterior = atual;
				atual = atual.proximo;
			}
			if(atual != null) {
				novoItem.proximo = atual;
				atual.anterior = novoItem;
				novoItem.anterior = anterior;
				if (anterior != null) {
					anterior.proximo = novoItem;
				} else {
					this.first = novoItem;
				}
			} else {
				anterior.proximo = novoItem;
				novoItem.anterior = anterior;
				this.last = novoItem;
			}
		}
	}
	
	public void imprimeListaLigada() {
		LinkedNode atual = first;
		while (atual != null) {
			System.out.println(atual.figura.toString() + "\n");
			atual = atual.proximo;
		}
	}
	
	/*
	public void inverteLista() {
		LinkedNode atual = this.first;
		LinkedNode proximo = atual.proximo;
		this.last = atual;
		while(proximo != null) {
			atual.proximo = atual.anterior;
			atual.anterior = proximo;
			atual = proximo;
			proximo = proximo.proximo;
		}
		atual.proximo = atual.anterior;
		atual.anterior = proximo;
		this.first = atual;
	}
	
	
	public void removeItem(String item) {
		LinkedNode anterior = null;
		LinkedNode atual = first;
		
		while(atual != null && !atual.data.getNome().equals(item)) {
			anterior = atual;
			atual = atual.proximo;
		}
		if (atual != null) {
			if(anterior == null) {
				first = atual.proximo;
				first.anterior = null;
			} else {
				anterior.proximo = atual.proximo;
				if(atual.proximo != null) {
					atual.proximo.anterior = anterior;
				}
			}
		}
	}
	
	public boolean buscaItem(String item) {
		LinkedNode anterior = null;
		LinkedNode atual = first;
		while(atual != null && !atual.data.getNome().equals(item)) {
			anterior = atual;
			atual = atual.proximo;
		}
		if (atual != null) {
			return true;
		}
		return false;
	}
	
	public void imprimePrimeiro() {
		if(this.first != null) {
			System.out.println(this.first.data.getNome());
		}
	}
	
	public void imprimeUltimo() {
		if(this.last != null) {
			System.out.println(this.last.data.getNome());
		}
	}
	*/
}
