package Observadores;

import interfaces.Observer;

public class MinMaxObserver implements Observer {
	int quant;
	private float[] temperatura;
	private float[] pressao;
	private float[] umidade;
	private static MinMaxObserver objeto;
	
	private MinMaxObserver() {
		temperatura = new float[1000];
		pressao = new float[1000];
		umidade = new float[1000];
		quant = 0;
	}
	
	public static MinMaxObserver getInstancia() {
		if(objeto == null) {
			objeto = new MinMaxObserver();
		}
		return objeto;
	}
	
	@Override
	public void update(float temperatura, float pressao, float umidade) {
		System.out.println("MinMaxObserver - Dados recebidos.");
		this.temperatura[quant++] = temperatura;
		this.pressao[quant++] = pressao;
		this.umidade[quant++] = umidade;
		System.out.println("Temperatura mínima: "+valorMinimo(1)+" - Temperatura máxima: "+valorMaximo(1));
		System.out.println("Pressao mínima: "+valorMinimo(2)+" - Pressão máxima: "+valorMaximo(2));
		System.out.println("Umidade mínima: "+valorMinimo(3)+" - Umidade máxima: "+valorMaximo(3));
	}
	
	@SuppressWarnings("null")
	private float valorMinimo(int escolha) {
		if(escolha == 1) {
			return valorMinimo(temperatura);
		} else if(escolha == 2) {
			return valorMinimo(pressao);
		} else if(escolha == 3) {
			return valorMinimo(umidade);
		} else {
			return (Float)null;
		}
	}
	
	@SuppressWarnings("null")
	private float valorMaximo(int escolha) {
		if(escolha == 1) {
			return valorMaximo(temperatura);
		} else if(escolha == 2) {
			return valorMaximo(pressao);
		} else if(escolha == 3) {
			return valorMaximo(umidade);
		} else {
			return (Float)null;
		}
		
	}
	
	@SuppressWarnings("null")
	private float valorMinimo(float[] vetor) {
		try {
			float min = vetor[0];
			for(int i = 0; i < quant; i++) {
				if(vetor[i] < min)
					min = vetor[i];
			}
			return min;
		} catch(NullPointerException e) {
			System.out.println(e.getMessage());
			return (Float)null;
		}
	}
	
	@SuppressWarnings("null")
	private float valorMaximo(float[] vetor) {
		try {
			float max = vetor[0];
			for(int i = 0; i < quant; i++) {
				if(vetor[i] > max)
					max = vetor[i];
			}
			return max;
		} catch(NullPointerException e) {
			System.out.println(e.getMessage());
			return (Float)null;
		}
	}

}
