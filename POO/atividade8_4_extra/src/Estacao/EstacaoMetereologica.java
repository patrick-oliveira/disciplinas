package Estacao;

import java.util.Observable;
import java.util.Observer;

import Observadores.DadosAtuaisObserver;
import Observadores.MediaObserver;
import Observadores.MinMaxObserver;

@SuppressWarnings("deprecation")
public class EstacaoMetereologica extends Observable {
	private static EstacaoMetereologica estacao;
	private float temperatura;
	private float pressao;
	private float umidade;
	
	private EstacaoMetereologica() {
		this.addObserver((Observer) DadosAtuaisObserver.getInstancia());
		this.addObserver((Observer) MediaObserver.getInstancia());
		this.addObserver((Observer) MinMaxObserver.getInstancia());
	}
	
	public static EstacaoMetereologica getInstance() {
		if(estacao == null)
			estacao = new EstacaoMetereologica();
		return estacao;
	}
	
	public void atualizaDados(float temperatura, float pressao, float umidade) {
		this.temperatura = temperatura;
		this.pressao = pressao;
		this.umidade = umidade;
		notifyObservers(getMedicoes());
	}
	
	private float[] getMedicoes() {
		float[] medicoes = new float[3];
		medicoes[0] = temperatura;
		medicoes[1] = pressao;
		medicoes[2] = umidade;
		return medicoes;
	}
}
