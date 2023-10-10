package atividade1;
import java.util.Scanner;

public class exercicio3 {
	
	public static void preencheMatriz(int m, int n, int[][] A){
		int i, j;
		double a;
		for (i = 0; i < m; i++) {
			for (j = 0; j < n; j++) {
				a = 10*Math.random();
				A[i][j] = (int) (a - a%1);
			}
		}		
	}
	
	public static void imprimeMatriz(int m, int n, int[][] A) {
		int i, j;
		for (i = 0; i < m; i++) {
			for (j = 0; j < n; j++) {
				System.out.printf("%d ", A[i][j]);
			}
			System.out.printf("\n");
		}		
	}
	
	public static int[][] produtoMatrizes(int[][] A, int[][] B){
		int[][] C = new int [A.length][B[0].length];
		int i, j, k, a;
		
		for (i = 0; i < A.length; i++) {
			for (j = 0; j < B[0].length; j++) {
				a = 0;
				for (k = 0; k < A[0].length; k++) {
					a += A[i][k]*B[k][j];
				}
				C[i][j] = (int)a;
			}
		}		
		
		return C;
	}

	public static void main(String[] args) {
		
		Scanner leitor = new Scanner(System.in);
		int m, n;
		
		System.out.println("Insira as dimensões da matriz A");
		System.out.print("m = ");
		m = leitor.nextInt();
		System.out.print("n = ");
		n = leitor.nextInt();
		int[][] A = new int[m][n];

		System.out.println("Insira as dimensões da matriz B");
		System.out.print("m = ");
		m = leitor.nextInt();
		System.out.print("n = ");
		n = leitor.nextInt();
		int[][] B = new int[m][n];
		
		preencheMatriz(A.length, A[0].length, A);
		preencheMatriz(B.length, B[0].length, B);
		
		if(A[0].length != B.length) {
			System.out.println("Não é possível calcular AxB");
		} else {
			int[][] C = produtoMatrizes(A, B);
			
			System.out.println("A = ");
			imprimeMatriz(A.length, A[0].length, A);
			
			System.out.println("B = ");
			imprimeMatriz(B.length, B[0].length, B);

			System.out.println("C = ");
			imprimeMatriz(C.length, C[0].length, C);			
		}

		leitor.close();
	}

}
