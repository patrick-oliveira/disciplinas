package sujeitos;

public class Prefeito extends Politico{
	String cidade;
	static int numero_prefeitos = 0;
	
	public Prefeito (String nome, String cpf, String partido, String cidade) {
		super(nome, cpf, partido);
		this.cidade = cidade;
		Prefeito.numero_prefeitos++;
		Politico.numero_politicos++;
	}
	
	public String getCidade() {
		return this.cidade;
	}
	
	@Override
	public String toString() {
		return "Nome: "+ this.getNome() +
				"CPF: "+ this.getCPF() +
				"Partido: "+ this.getPartido() +
				"Cargo: Prefeito" +
				"CidadE: " + this.getCidade();
	}
}
