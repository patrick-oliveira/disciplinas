import pilha.PilhaRecurso;

public class Teste {

	public static void main(String[] args) {
		
		try(PilhaRecurso pilha = new PilhaRecurso(5)) {
			pilha.empilha("Teste1");
			pilha.empilha("Teste2");
			System.out.println(pilha.desempilha());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
