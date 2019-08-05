package jogo;
import java.util.Observable;
import java.util.Observer;
import java.util.Scanner;

import strategy.DefesaAutomatico;
import strategy.DefesaJogador;

public class GoleiroPessoa extends Jogador implements Observer {

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
	public void update(Observable o, Object arg) {
		if(o instanceof Penalty) {
			boolean resultado = (boolean)arg;
			Penalty jogo = (Penalty)o;
			System.out.println(getNome()+": recebeu notificação - Resultado do Penalty "+jogo.getContagem()+": "+(resultado?"Defendeu":"Não defendeu"));
		}
	}

}