package atividade1;
import java.util.Arrays;

public class exercicio2 {
	
	public static void imprimeVetor(int[] vetor) {
		int i;
		for(i = 0; i < vetor.length; i++) {
			System.out.printf("%d ", vetor[i]);
		}
		System.out.printf("\n");
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int[] v = new int[20];
		double a, Mean = 0;
		int i, j1, j2, Moda;
		
		for (i = 0; i < 20; i++) {
			a = 10*Math.random();
			v[i] = (int)(a - a%1);
		}


		for (i = 0; i < 20; i++) {
			Mean += v[i];
		}
		Mean = Mean/20;

		Arrays.sort(v);
		imprimeVetor(v);
		
		j1 = 1; Moda = v[0];
		j2 = 0;
		for (i = 1; i < 20; i++) {
			if(v[i] == Moda) {
				j1++;
			} else {
				if(v[i] != v[i-1]) j2 = 0;
				j2++;
				if(j2 > j1) {
					j1 = j2;
					Moda = v[i];
				}
			}
		}
		
		System.out.println("Média = "+Mean);
		System.out.println("Moda = " +Moda);
	}

}
