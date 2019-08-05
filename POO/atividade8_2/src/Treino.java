import java.util.Scanner;

import jogo.CobradorPessoa;
import jogo.GoleiroPessoa;
import jogo.Jogador;
import jogo.Penalty;

public class Treino {

	public static void main(String[] args) {
		Scanner leitor = new Scanner(System.in);
		
		System.out.println("Digite o nome do cobrador ou C se sera o computador:");
		CobradorPessoa cobrador = new CobradorPessoa(leitor.next());
		System.out.println("Digite o nome do goleiro ou C se sera o computador:");
		GoleiroPessoa goleiro = new GoleiroPessoa(leitor.next());
		
		Penalty p = new Penalty(goleiro, cobrador);
		p.addObserver(cobrador);
		p.addObserver(goleiro);
		
		int acertosCobrador = 0;
		int defesas = 0;
		
		for (int i = 0; i < 3; i++)
			if (p.cobrar())
				acertosCobrador++;
			else
				defesas++;
			
		System.out.println("[" + ((Jogador) cobrador).getNome() + "] Gols = " + acertosCobrador 
						+ "  [" + ((Jogador) goleiro).getNome() + "] Defesas = " + defesas);
	}

}