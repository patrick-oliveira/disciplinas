import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

import Estacao.EstacaoMetereologica;

public class Teste {

	public static void main(String[] args) {
		EstacaoMetereologica estacao = EstacaoMetereologica.getInstance();
		for(int i = 0; i < 180; i++) {
			estacao.atualizaDados(getTemperatura(), getPressao(), getUmidade());
			System.out.println("");
		}
	}
	
	private static float getTemperatura() {
		return (new Random()).nextFloat()*100;
	}
	
	private static float getPressao() {
		return (new Random()).nextFloat()*100;
	}
	
	private static float getUmidade() {
		return (new Random()).nextFloat()*100;
	}

}
