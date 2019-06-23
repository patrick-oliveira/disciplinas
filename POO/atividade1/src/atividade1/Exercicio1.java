package atividade1;

public class Exercicio1 {

	public static void main(String[] args) {
		
		double PI1, PI2 = 0;
		int i = 0;
		
		do {
			PI1 = PI2;
			PI2 = PI2 + (4.0/(2*i + 1))*Math.pow(-1, i);
			i++;
		} while(Math.abs(PI2 - PI1) > 0.00001);
		
		System.out.println("pi = " + PI2);
	}

}
