package jogo;

import java.util.Observable;

@SuppressWarnings("deprecation")
public class Penalty extends Observable {
	
	private static int contagem = 0;
	
	private GoleiroPessoa goleiro;
	private CobradorPessoa cobrador;

	public Penalty(GoleiroPessoa goleiro, CobradorPessoa cobrador) {
		this.goleiro = goleiro;
		this.cobrador = cobrador;
	}

	// Retorna true se a cobrança for convertida em gol
	public boolean cobrar() {
		System.out.println("--- Penalty " + ++contagem + " ---");
		
		int ladoChute = cobrador.chutar();
		int ladoDefesa = goleiro.defender();
		
		System.out.println();
		notifyObservers(ladoChute != ladoDefesa);
		return (ladoChute != ladoDefesa); // Bola entra se o goleiro pular para o lado diferente de onde a bola foi chutada
	}
	
	public int getContagem() {
		return contagem;
	}

}