package listaligada;

import listaligada.LinkedNode;
import pessoa.Pessoa;

public class ListaLigada {
	private LinkedNode first = null;
	
	public void adicionaItemNoFinal(Pessoa item) {
		LinkedNode novoItem = new LinkedNode();
		novoItem.data = item;
		novoItem.next = null;
		
		if (this.first == null) {
			this.first = novoItem;
		} else {
			LinkedNode anterior = null;
			LinkedNode atual = first;
			while(atual != null) {
				anterior = atual;
				atual = atual.next;
			}
			anterior.next = novoItem;
		}
	}
	
	public void adicionaOrdenado(Pessoa item) {
		LinkedNode novoItem = new LinkedNode();
		novoItem.data = item;
		novoItem.next = null;
		
		if (this.first == null) {
			this.first = novoItem;
		} else {
			LinkedNode anterior = null;
			LinkedNode atual = first;
			while (atual != null && atual.data.getNome().compareTo(item.getNome()) <= 0) {
				anterior = atual;
				atual = atual.next;
			}
			if(atual != null) {
				novoItem.next = atual;
				if (anterior != null) {
					anterior.next = novoItem;
				} else {
					this.first = novoItem;
				}
			} else {
				anterior.next = novoItem;
			}
		}
	}
	
	public void inverteLista() {
		LinkedNode anterior = null;
		LinkedNode atual = this.first;
		LinkedNode proximo = atual.next;
		
		while(proximo != null) {
			atual.next = anterior;
			anterior = atual;
			atual = proximo;
			proximo = proximo.next;
		}
		atual.next = anterior;
		this.first = atual;
	}
	
	public void removeItem(String item) {
		LinkedNode anterior = null;
		LinkedNode atual = first;
		while(atual != null && !atual.data.getNome().equals(item)) {
			anterior = atual;
			atual = atual.next;
		}
		if (atual != null) {
			if(anterior == null)
				first = atual.next;
			else
				anterior.next = atual.next;
		}
	}
	
	public boolean buscaItem(String item) {
		LinkedNode anterior = null;
		LinkedNode atual = first;
		while(atual != null && !atual.data.getNome().equals(item)) {
			anterior = atual;
			atual = atual.next;
		}
		if (atual != null) {
			return true;
		}
		return false;
	}
	
	public void imprimeListaLigada() {
		LinkedNode atual = first;
		while (atual != null) {
			System.out.print(atual.data.getNome() + " ");
			atual = atual.next;
		}
		System.out.print("\n");
	}
	
}
