package sujeitos;

public abstract class Pessoa {
	String nome;
	protected String cpf;
	
	public Pessoa(String nome, String cpf) {
		this.nome = nome;
		this.cpf = cpf;
	}
	
	public String getCPF() {
		return this.cpf;
	}
	public String getNome() {
		return this.nome;
	}
}
