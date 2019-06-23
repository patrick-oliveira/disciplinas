package prova;

public class Prova {
	private Pergunta[] perguntas;
	private int indiceAtual;
	public String titulo;
	
	// Construtor do objeto "prova"
	public Prova(int qtdPerguntas) {
		perguntas = new Pergunta[qtdPerguntas];
		indiceAtual = -1;
	}
	
	// Sobrecarga do construtor
	public Prova(int qtdPerguntas, String titulo) {
		perguntas = new Pergunta[qtdPerguntas];
		indiceAtual = -1;
		this.titulo = titulo;
	}
	
	public void adicionarPergunta(Pergunta novaPergunta) {
		if (indiceAtual + 1 >= perguntas.length) {
			System.out.println("Limite atingido!");
			return;
		}
		indiceAtual++;
		perguntas[indiceAtual] = novaPergunta;
	}
}
