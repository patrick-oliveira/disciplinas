package Estacao;

import java.util.ArrayList;
import java.util.List;

import Observadores.DadosAtuaisObserver;
import Observadores.MediaObserver;
import Observadores.MinMaxObserver;
import interfaces.Observer;

public class EstacaoMetereologica {
	private static EstacaoMetereologica estacao;
	private List<Observer> observadores;
	private float temperatura;
	private float pressao;
	private float umidade;
	
	private EstacaoMetereologica() {
		observadores = new ArrayList<Observer>();
		observadores.add(DadosAtuaisObserver.getInstancia());
		observadores.add(MediaObserver.getInstancia());
		observadores.add(MinMaxObserver.getInstancia());
	}
	
	public static EstacaoMetereologica getInstance() {
		if(estacao == null)
			estacao = new EstacaoMetereologica();
		return estacao;
	}
	
	
	private void adiciona(Observer observer) {
		observadores.add(observer);
	}
	
	private void remove(Observer observer) {
		observadores.remove(observer);
	}
	
	private void notifica() {
		for(Observer obj : observadores)
			obj.update(temperatura, pressao, umidade);
	}
	
	public void atualizaDados(float temperatura, float pressao, float umidade) {
		this.temperatura = temperatura;
		this.pressao = pressao;
		this.umidade = umidade;
		notifica();
	}
}
