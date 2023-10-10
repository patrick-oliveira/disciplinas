package sujeitos;

public class Politico extends Pessoa {
	String partido;
	static int numero_politicos = 0;
	
	public Politico (String nome, String cpf, String partido) {
		super(nome, cpf);
		this.partido = partido;
	}
	
	public String getPartido() {
		return this.partido;
	}
	
	@Override
	public String toString() {
		return "Nome: "+ this.getNome() +
				"CPF: "+ this.getCPF() +
				"Partido: "+ this.getPartido();
	}
}
