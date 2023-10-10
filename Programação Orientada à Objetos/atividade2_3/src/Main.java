import carro.*;
import java.util.Scanner;

public class Main {

	public static void main(String[] args) {
		int i, j, n = 3;
		Carro[] c = new Carro[n];
		Scanner leitor = new Scanner(System.in);
		
		for(i = 0 ; i < 3; i++) {
			c[i] = new Carro();
		}
		
		c[0].criaCarro("Modelo 1", "Tipo 1", 
				(double)Math.round(100*Math.random())/10, 
				 Math.round(10*Math.random()));
		
		c[1].criaCarro("Modelo 2", "Tipo 2", 
				(double)Math.round(100*Math.random())/10, 
				Math.round(10*Math.random()));
		
		c[2].criaCarro("Modelo 3", "Tipo 3", 
				(double)Math.round(100*Math.random())/10, 
				Math.round(10*Math.random()));
		
		System.out.print("Digite uma distância a ser percorrida: ");
		double distancia = leitor.nextDouble();
		
		j = 0;
		for(i = 0; i < n; i++) {
			if(c[i].getConsumo() < c[j].getConsumo()) {
				j = i;
			}
		}
		
		System.out.print("O carro "+c[j].getModelo()+" com combustível "
				+c[j].getTipoCombustivel()+" é o mais econômico.");
		System.out.println(" Possui "+c[j].getQtdeCombustivel()+"l de combustível e "
				+ "faz "+c[j].getConsumo()+"km/l.");
		
		c[j].simulaViagem(distancia);
		
		leitor.close();
	}

}
