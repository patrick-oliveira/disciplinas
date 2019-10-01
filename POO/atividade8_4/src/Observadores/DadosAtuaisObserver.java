package Observadores;

import interfaces.Observer;

public class DadosAtuaisObserver implements Observer{
	private static DadosAtuaisObserver observador;
	
	private DadosAtuaisObserver() {
		
	}
	
	public static DadosAtuaisObserver getInstancia() {
		if(observador == null)
			observador = new DadosAtuaisObserver();
		return observador;
	}
	@Override
	public void update(float temperatura, float pressao, float umidade) {
		System.out.println("DadosAtuaisObserver - Dados recebidos.");
		System.out.println("Temperatura: "+ temperatura);
		System.out.println("Pressão: "+ pressao);
		System.out.println("Umidade: "+ umidade);
	}

}
