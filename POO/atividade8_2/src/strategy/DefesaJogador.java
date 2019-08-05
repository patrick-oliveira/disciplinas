package strategy;

import java.util.Scanner;

public class DefesaJogador implements Defesa {

	@Override
	public int defender() {
		System.out.println("Qual lado voce vai defender? 1=esquerda 2=meio 3=direita");
		Scanner leitor = new Scanner(System.in);
		return leitor.nextInt();
	}

}
