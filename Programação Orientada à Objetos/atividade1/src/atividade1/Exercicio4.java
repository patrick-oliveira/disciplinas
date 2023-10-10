package atividade1;
import java.util.Scanner;

public class Exercicio4 {
	
	public static void imprimeVetor(int[] vetor) {
		int i;
		for (i = 0; i < vetor.length; i++) {
			System.out.printf("%d ", vetor[i]);
		}
		System.out.printf("\n");
	}

	public static void main(String[] args) {
		Scanner leitor = new Scanner(System.in);
		int[] vetor = new int[10];
		int i, id, n;
		double a;
		
		for (i = 0; i < vetor.length; i++) {
			a = Math.random()*10;
			vetor[i] = (int)(a - a%1);
		}
		
		System.out.println("Digite o valor a ser inserido: ");
		n = leitor.nextInt();
		System.out.println("Digite a posição: ");
		id = leitor.nextInt();
		
		imprimeVetor(vetor);
		if(id >= vetor.length) {
			System.out.println("A posição ultrapassa o tamanho do vetor.");
		} else {
			for(i = id; i < vetor.length; i++) {
				if(vetor[i] == 0) {
					vetor[i] = n;
					break;
				}
				if(i == vetor.length-1 && vetor[i] != 0) {
					System.out.println("Não há espaço da posição solicitada em diante.");
				}
			}
		}
		imprimeVetor(vetor);
		leitor.close();
	}

}
