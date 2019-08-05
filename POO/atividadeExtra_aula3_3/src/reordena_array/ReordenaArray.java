package reordena_array;

import java.util.Random;

public class ReordenaArray {
	
	public int[] reordena(int[] array) {
		Random rgen = new Random();
		
		int[] array_reordenado = new int[array.length];
		
		for(int i = 0; i < array.length; i++) {
			array_reordenado[i] = array[i];
		}
		
		for(int i = 0; i < array.length; i++) {
			int randomPosition = rgen.nextInt(array.length);
			int temp = array_reordenado[i];
			array_reordenado[i] = array_reordenado[randomPosition];
			array_reordenado[randomPosition] = temp;
		}
		
		return array_reordenado;
	}
	
	public int[] reordena_indices(int array_tamanho) {
		Random rgen = new Random();
		
		int[] indice_reordenado = new int[array_tamanho];
		
		for(int i = 0; i < array_tamanho; i++) {
			indice_reordenado[i] = i;
		}
		
		for(int i = 0; i < array_tamanho; i++) {
			int randomPosition = rgen.nextInt(array_tamanho);
			int temp = indice_reordenado[i];
			indice_reordenado[i] = indice_reordenado[randomPosition];
			indice_reordenado[randomPosition] = temp;
		}
		
		return indice_reordenado;
	}
}
