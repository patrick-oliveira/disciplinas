package loteria;

import loteria.NumeroAleatorio;

public class NumeroLoteria {
	private int[] numeros;

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
	
	public String toString() {
		String stringNumeros = "";
		for(int i = 0; i < 3; i++) {
			stringNumeros = stringNumeros.concat(((Integer)numeros[i]).toString()+" ");
		}
		return stringNumeros;
	}
	
	public boolean ganhou(NumeroLoteria nLoteria) {
		return this.toString().equals(nLoteria.toString());
	}
}
