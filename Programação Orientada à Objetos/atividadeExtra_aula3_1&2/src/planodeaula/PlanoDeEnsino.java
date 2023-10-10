package planodeaula;

public class PlanoDeEnsino {
	private Aula[] lista_de_aulas;
	private String nome_disciplina;
	int numero_de_aulas;
	static int quantidade_planos = 0;
	
	public PlanoDeEnsino() {
		PlanoDeEnsino.quantidade_planos++;
	}
	
	public PlanoDeEnsino(int numero_aulas) {
		this.numero_de_aulas = numero_aulas;
		this.lista_de_aulas = new Aula[numero_aulas];
		PlanoDeEnsino.quantidade_planos++;
	}
	
	public PlanoDeEnsino(int numero_aulas, String nome) {
		this.numero_de_aulas = numero_aulas;
		this.lista_de_aulas = new Aula[numero_aulas];
		this.nome_disciplina = nome;
	}
	
	public void adicionarAula(Aula nova_aula) {
		int i;
		for(i = 0; i < this.numero_de_aulas && this.lista_de_aulas[i] != null; i++);
		if(i < this.numero_de_aulas) {
			this.lista_de_aulas[i] = nova_aula;
			System.out.println("Adicionado aula "+i);
		}
	}
	
	public void adicionarAula(String nome_aula) {
		int i;
		for(i = 0; i < this.numero_de_aulas && this.lista_de_aulas[i] != null; i++);
		if(i < this.numero_de_aulas) {
			this.lista_de_aulas[i] = new Aula(nome_aula);
			System.out.println("Adicionado aula "+i);
		}
	}
	
	public void imprimirAulas() {
		for(int i = 0; i < numero_de_aulas && this.lista_de_aulas[i] != null; i++) {
			System.out.println(this.lista_de_aulas[i].toString());
		}
	}
	
	public int getNumeroAulas() {
		return this.numero_de_aulas;
	}
}
