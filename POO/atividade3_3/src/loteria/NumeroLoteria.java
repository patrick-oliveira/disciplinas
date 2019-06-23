package loteria;

import loteria.NumeroAleatorio;

public class NumeroLoteria {
	private int[] numeros;
	private int numero_sorteio;
	private boolean sorteio_vencedor = false;

	public NumeroLoteria() {
		this.numeros = new int[3];
		for(int i = 0; i < 3; i++) {
			this.numeros[i] = NumeroAleatorio.getAleatorio();
		}
	}
	
	public NumeroLoteria(int[] numeros) {
		this.numeros = new int[3];
		for(int i = 0; i < 3; i++) {
			this.numeros[i] = numeros[i];
		}
	}
	
	public void setNumeroSorteio(int num) {
		this.numero_sorteio = num;
	}
	
	public int getNumero_Sorteio() {
		return this.numero_sorteio;
	}
	
	public boolean getSorteio_Vencedor() {
		return this.sorteio_vencedor;
	}
	
	public String toString() {
		String stringNumeros = "";
		for(int i = 0; i < 3; i++) {
			stringNumeros = stringNumeros.concat(((Integer)numeros[i]).toString()+" ");
		}
		return stringNumeros;
	}
	
	public void ganhou(NumeroLoteria nLoteria) {
		this.sorteio_vencedor = this.toString().equals(nLoteria.toString());
	}
}
