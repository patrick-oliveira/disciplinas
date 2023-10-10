import java.util.Scanner;

import copaamerica.Atacante;
import copaamerica.Goleiro;
import copaamerica.Lateral;
import copaamerica.TimeDeFutebol;

public class Principal {

	public static void main(String[] args) {
		Scanner leitor = new Scanner(System.in);
		TimeDeFutebol ABC = new TimeDeFutebol();
		TimeDeFutebol DEF = new TimeDeFutebol();
		
		
		System.out.println("Insira os jogadores do time ABC: ");
		for(int i = 0; i < 3; i++) {
			int numero = leitor.nextInt();
			String posicao = leitor.next();
			String lado;
			if(posicao.equals("lateral")) {
				lado = leitor.next();
				ABC.adicionaJogador(new Lateral(numero, posicao, lado));
			} else if (posicao.equals("goleiro")) {
				ABC.adicionaJogador(new Goleiro(numero, posicao));
			} else {
				ABC.adicionaJogador(new Atacante(numero, posicao));
			}
		}
		
		System.out.println("Insira os jogadores do time DEF:");
		for(int i = 0; i < 3; i++) {
			int numero = leitor.nextInt();
			String posicao = leitor.next();
			String lado;
			if(posicao.equals("lateral")) {
				lado = leitor.next();
				DEF.adicionaJogador(new Lateral(numero, posicao, lado));
			} else if (posicao.equals("goleiro")) {
				DEF.adicionaJogador(new Goleiro(numero, posicao));
			} else {
				DEF.adicionaJogador(new Atacante(numero, posicao));
			}
		}
		
		System.out.println("Imprimindo escalacao do time ABC: ");
		// Criar um metodo que retorna as strings, ao inves de 
		// imprimi-las na tela diretamente, eh mais versatil.
		String[] escalacao = ABC.escalacao();
		for(int i = 0; i < 3; i++) {
			System.out.println(escalacao[i]);
		}
		
		System.out.println("Imprimindo escalacao do time DEF: ");
		escalacao = DEF.escalacao();
		for(int i = 0; i < 3; i++) {
			System.out.println(escalacao[i]);
		}
		
		System.out.println("Insira o numero de um jogador do time ABC e de um substituto: ");
		int substituir = leitor.nextInt();
		int substituto = leitor.nextInt();
		
		ABC.substituiJogador(substituto, substituir);
		
		System.out.println("Imprimindo escalacao do time ABC: ");
		escalacao = ABC.escalacao();
		for(int i = 0; i < 3; i++) {
			System.out.println(escalacao[i]);
		}
		
		System.out.println("Imprimindo escalacao do time DEF: ");
		escalacao = DEF.escalacao();
		for(int i = 0; i < 3; i++) {
			System.out.println(escalacao[i]);
		}
		
		
		System.out.println("Verificando time ABC: ");
		if(ABC.VerificaTime()) {
			System.out.println("Time valido.");
		} else {
			System.out.println("Time invalido");
		}
		
	}

}
