package atividade1;
import java.util.Scanner;

public class Exercicio5 {
	
	public static void insertionSort(int[] vetor) {
		int i, j, key;
		
		for (j = 1; j < vetor.length; j++) {
			key = vetor[j];
			i = j - 1;
			while(i >= 0 && vetor[i] > key) {
				vetor[i+1] = vetor[i];
				i--;
			}
			vetor[i + 1] = key;
		}
	
	}
	
	public static void preencheVetor(int [] vetor) {
		double a;
		int i;
		for(i = 0; i < vetor.length; i++) {
			a = Math.random()*10;
			vetor[i] = (int)(a - a%1);
		}
	}
	
	public static void imprimeVetor(int[] vetor) {
		int i;
		for(i = 0; i < vetor.length; i++) {
			System.out.printf("%d ", vetor[i]);
		}
		System.out.printf("\n");
	}

	public static void main(String[] args) {
		Scanner leitor = new Scanner(System.in);
		
		System.out.println("Insira o tamanho do vetor: ");
		int[] vetor = new int[leitor.nextInt()];
		
		preencheVetor(vetor);
		imprimeVetor(vetor);
		insertionSort(vetor);
		imprimeVetor(vetor);
		
		leitor.close();
	}

}
