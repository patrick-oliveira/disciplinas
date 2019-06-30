import java.util.Scanner;
import loteria.*;

public class Principal {

	public static void main(String[] args) {
		Scanner leitor = new Scanner(System.in);
		int N, i;
		boolean aux = true;
		int[] numeros = new int[3];
		NumeroLoteria[] sorteio;
		NumeroLoteria aposta;
		
		System.out.print("Digite o número de sorteios: ");
		N = leitor.nextInt();
		sorteio = new NumeroLoteria[N];
		
		System.out.println("Digite os três números da aposta: ");
		for(i = 0; i < 3; i++) {
			numeros[i] = leitor.nextInt();
		}
		aposta = new NumeroLoteria(numeros);
		
		for(i = 0; i < N; i++) {
			sorteio[i] = new NumeroLoteria();
			System.out.println("Sorteio "+(i+1)+" - "+sorteio[i].toString());
			if(sorteio[i].ganhou(aposta)) {
				aux = false;
			}
		}
		
		System.out.println("Aposta: "+aposta.toString());
		if(aux) {
			System.out.println("Não ganhou em nenhum sorteio.");
		} else {
			System.out.println("Ganhou em um sorteio.");
		}
		
		leitor.close();
	}

}