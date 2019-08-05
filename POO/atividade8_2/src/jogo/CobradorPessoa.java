package jogo;
import java.util.Observable;
import java.util.Observer;
import java.util.Scanner;

import strategy.ChuteAutomatico;
import strategy.ChuteJogador;

@SuppressWarnings("deprecation")
public class CobradorPessoa extends Jogador implements Observer {

	public CobradorPessoa(String nome) {
		super(nome);
	}

	public int chutar() {		
		if(!getNome().equals("C")) {
			return (new ChuteJogador()).chutar();
		} else {
			return (new ChuteAutomatico()).chutar();
		}
	}

	@Override
	public void update(Observable o, Object arg) {
		if(o instanceof Penalty) {
			boolean resultado = (boolean)arg;
			Penalty jogo = (Penalty)o;
			System.out.println(getNome()+": recebeu notificação - Resultado do Penalty "+jogo.getContagem()+": "+(resultado?"Não acertou":"Acertou"));
		}
	}		
	

}