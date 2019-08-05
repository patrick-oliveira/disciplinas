package strategy;

import java.util.Scanner;

public class ChuteJogador implements Chute {

	@Override
	public int chutar() {
		System.out.println("Qual lado voce vai chutar? 1=esquerda 2=meio 3=direita");
		Scanner leitor = new Scanner(System.in);
		return leitor.nextInt();
	}

}
