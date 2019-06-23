import prova.*;

public class Teste {

	public static void main(String[] args) {
		//Prova p1 = new Prova(3);
		Prova p1 = new Prova(3, "Prova Final");
		
		Pergunta q1 = new Pergunta(3, "Quanto eh 1 + 1?");
		q1.adicionarAlternativa(true, new Alternativa("2"));
		q1.adicionarAlternativa(false, new Alternativa("3"));
		q1.adicionarAlternativa(false, new Alternativa("18"));
		p1.adicionarPergunta(q1);
		
		Pergunta q2 = new Pergunta(3, "Qual o valor de PI");
		q2.adicionarAlternativa(true, new Alternativa("3.14"));
		q2.adicionarAlternativa(false, new Alternativa("80"));
		q2.adicionarAlternativa(false, new Alternativa("24"));
		p1.adicionarPergunta(q2); 
		
		// Criando pergunta com método sobrecarregado
		Pergunta q3 = new Pergunta(3, "Quanto eh 2+2?");
		q3.adicionarAlternativa(true, "4");
		q3.adicionarAlternativa(false, "55");
		q3.adicionarAlternativa(false, "12");
		p1.adicionarPergunta(q3);

	}

}
