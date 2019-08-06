package jogo;

import Observer.Ouvinte;
import strategy.ChuteAutomatico;
import strategy.ChuteJogador;

public class CobradorPessoa extends Jogador implements Ouvinte {

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
	public void update(Penalty jogo, boolean resultado) {
		System.out.println(getNome()+": recebeu notificação - Resultado do Penalty "+jogo.getContagem()+": "+(resultado?"Não acertou":"Acertou"));
	}		
	

}