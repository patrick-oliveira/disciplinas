package jogo;

import Observer.Ouvinte;
import strategy.DefesaAutomatico;
import strategy.DefesaJogador;

public class GoleiroPessoa extends Jogador implements Ouvinte {

	public GoleiroPessoa(String nome) {
		super(nome);
	}

	public int defender() {		
		if(!getNome().equals("C")) {
			return (new DefesaJogador()).defender();
		} else {
			return (new DefesaAutomatico()).defender();
		}
	}

	@Override
	public void update(Penalty jogo, boolean resultado) {
		System.out.println(getNome()+": recebeu notificação - Resultado do Penalty "+jogo.getContagem()+": "+(resultado?"Defendeu":"Não defendeu"));
	}

}