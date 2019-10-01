package Observadores;

import interfaces.Observer;

public class MediaObserver implements Observer {
	private static MediaObserver obj;
	private int qde;
	private float[] temperatura;
	private float[] umidade;
	private float[] pressao;
	
	private MediaObserver() {
		temperatura = new float[1000];
		umidade = new float[1000];
		pressao = new float[1000];
		qde = 0;
	}
	
	public static MediaObserver getInstancia() {
		if(obj == null) {
			obj = new MediaObserver();
		} 
		return obj;
	}
	
	@SuppressWarnings("null")
	private float getMedia(int escolha) {
		if(escolha == 1) {
			return getMedia(temperatura);
		} else if(escolha == 2) {
			return getMedia(pressao);
		} else if(escolha == 3) {
			return getMedia(umidade);
		} else {
			return (Float)null;
		}
	}
	
	@SuppressWarnings("null")
	private float getMedia(float[] vetor) {
		try {
			float soma = vetor[0];
			for(int i = 1; i < qde; i++)
				soma += vetor[i];
			return soma/qde;
		} catch(NullPointerException e) {
			System.out.println(e.getMessage());
			return (Float) null;
		}
	}

	@Override
	public void update(float temperatura, float pressao, float umidade) {
		System.out.println("MediaObserver - Dados recebidos.");
		this.temperatura[qde++] = temperatura;
		this.pressao[qde++] = pressao;
		this.umidade[qde++] = umidade;
		
		System.out.println("Temperatura média: "+getMedia(1));
		System.out.println("Pressao média: "+getMedia(2));
		System.out.println("Umidade média: "+getMedia(3));
	}
	
}
