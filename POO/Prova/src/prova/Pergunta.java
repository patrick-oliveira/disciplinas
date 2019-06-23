package prova;

public class Pergunta {
	public String textoPergunta;
	private Alternativa[] alternativas;
	private int alternativaCorreta;
	private int indiceAtual;
	
	// Construtor do objeto "Pergunta"
	public Pergunta(int qtdAlternativas, String textoPergunta) {
		alternativas = new Alternativa[qtdAlternativas];
		alternativaCorreta = -1;
		indiceAtual = -1;
		this.textoPergunta = textoPergunta;
	}
	
	public void adicionarAlternativa(boolean correta, Alternativa alternativa) {
		if (indiceAtual + 1 >= alternativas.length) {
			System.out.println("Limite de alternativas atingido!");
			return;
		}
		indiceAtual++;
		alternativas[indiceAtual] = alternativa;
		if(correta) {
			if(alternativaCorreta > 0) {
				System.out.println("Há outra alternativa correta!");
			} else {
				alternativaCorreta = indiceAtual;
			}
		}
	}
	// Sobrecarga do método "adicionarAlternativa"
	public void adicionarAlternativa(boolean correta, String alternativa) {
		adicionarAlternativa(correta, new Alternativa(alternativa));
	}
}
