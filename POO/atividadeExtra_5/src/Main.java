import veiculos.Caminhao;
import veiculos.Carro;
import veiculos.Motocicleta;
import veiculos.Veiculo;

public class Main {

	public static void main(String[] args) {
		Veiculo[] veiculos = new Veiculo[3];

		veiculos[0] = new Carro("Gol", 2015, 50000, "SP46140", 4);
		veiculos[1] = new Motocicleta("Honda", 2010, 15000, "BA12345", 120);
		veiculos[2] = new Caminhao("BMW", 2019, 230000, "CA90954", 3, 2000);
		
		for(int i = 0; i < 3; i++) {
			System.out.print(veiculos[i].toString()+"\n\n");
		}
		
		for(int i = 0; i < 3; i++) {
			if(veiculos[i] instanceof Caminhao)
				System.out.println("É um caminhão.");
		}
	}

}
