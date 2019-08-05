import java.util.Scanner;
import conversaotemp.*;

public class Teste {

	public static void main(String[] args) {
		String in;
		String out;
		double temp;
		Scanner leitor = new Scanner(System.in);
		ConversorTemp conversor = new ConversorTemp();

		do {
			System.out.println("Insira: Temperatura -UnidadeEntrada- -UnidadeSaída-. Ex: 15 C F.");
			System.out.println("Digite 0 0 0 para sair do loop.");
			temp = leitor.nextDouble();
			in = leitor.next();
			out = leitor.next();
			if (in.equals("C") && out.equals("F")) {
				System.out.println(conversor.CparaF(temp)+" F");
			} else if (in.equals("F") && out.equals("C")) {
				System.out.println(conversor.FparaC(temp)+" C");
			} else if (in.equals("C") && out.equals("K")) {
				System.out.println(conversor.CparaK(temp)+" K");
			} else if (in.equals("K") && out.equals("C")) {
				System.out.println(conversor.KparaC(temp)+" C");
			} else if (in.equals("F") && out.equals("K")) {
				System.out.println(conversor.FparaK(temp)+" K");
			} else if (in.equals("K") && out.equals("F")) {
				System.out.println(conversor.KparaF(temp)+" F");
			}
		} while(!in.equals("0") && !out.equals("0"));
		leitor.close();
	}

}
