import planodeaula.*;

public class Principal {

	public static void main(String[] args) {
		PlanoDeEnsino plano1 = new PlanoDeEnsino();
		
		PlanoDeEnsino plano2 = new PlanoDeEnsino(10);
		
		Aula aula1 = new Aula("aula1");
		
		plano2.adicionarAula(aula1);
		
		for(int i = 1; i < 10; i++) {
			plano2.adicionarAula("aula"+((Integer)(i+1)).toString());
		}
		
		plano2.adicionarAula("aula11");
		plano2.imprimirAulas();
	}

}
