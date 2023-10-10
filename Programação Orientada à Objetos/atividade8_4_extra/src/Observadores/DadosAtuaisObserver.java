package Observadores;

import java.util.Observer;
import java.util.Observable;
import Estacao.EstacaoMetereologica;

@SuppressWarnings("deprecation")
public class DadosAtuaisObserver implements Observer {
	private static DadosAtuaisObserver observador;
	
	private DadosAtuaisObserver() {
		
	}
	
	public static DadosAtuaisObserver getInstancia() {
		if(observador == null)
			observador = new DadosAtuaisObserver();
		return observador;
	}

	@Override
	public void update(Observable o, Object arg) {
		float[] medicoes = ((float[])arg);
		System.out.println("DadosAtuaisObserver - Dados recebidos.");
		System.out.println("Temperatura: "+ medicoes[0]);
		System.out.println("Pressão: "+ medicoes[1]);
		System.out.println("Umidade: "+ medicoes[2]);
	}


}
