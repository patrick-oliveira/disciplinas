import java.util.concurrent.ThreadLocalRandom;
import java.util.Scanner;
import caixaatendimento.*;

public class Principal {

	public static void main(String[] args) {
		CaixaAtendimento[] caixas = new CaixaAtendimento[5];
		int i, randomint;
		String c;
		Scanner leitor = new Scanner(System.in);
		
		for(i = 0; i < 5; i++) {
			caixas[i] = new CaixaAtendimento();
			caixas[i].criaCaixa(i+1);
		}
		
		do {
			randomint = ThreadLocalRandom.current().nextInt(0, 5);
			System.out.print("Caixa "+randomint+" - ");
			caixas[randomint].chamaProximoFila();
			System.out.println("Digite c para continuar, ou qualquer coisa para sair.");
			c = leitor.next();
		} while(c.equals("c"));
		
		leitor.close();
	}

}
