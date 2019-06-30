import racional.*;

public class Principal {

	public static void main(String[] args) {
		MatrizRacional A = new MatrizRacional();
		MatrizRacional B = new MatrizRacional();
		
		int[] dimA = A.getDim();
		
		MatrizRacional C = new MatrizRacional(dimA[0], dimA[1]);
		MatrizRacional D = new MatrizRacional(5, 2);
		
		System.out.println("A = ");
		A.Imprime();
		
		System.out.println("\nB = ");
		B.Imprime();
		
		System.out.println("\nC = ");
		C.Imprime();
		
		System.out.println("\nD = ");
		D.Imprime();
		
		System.out.println("\nA + C =");
		A.Soma(C);
		A.Imprime();
		
		System.out.println("\nB + A = ");
		B.Soma(A);
		B.Imprime();
		
		System.out.println("\nC + D?");
		C.Soma(D);
	}

}
