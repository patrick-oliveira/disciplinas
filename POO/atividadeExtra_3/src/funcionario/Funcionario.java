package funcionario;

public abstract class Funcionario {
	private String nome;
	private String cpf;
	private String setor;
	
	public Funcionario(String nome, String cpf, String setor) {
		setNome(nome);
		setCPF(cpf);
		setSetor(setor);
	}
	
	
	
	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public void setCPF(String cpf) {
		this.cpf = cpf;
	}
	
	public void setSetor(String setor) {
		this.setor = setor;
	}
	
	public String getNome() {
		return this.nome;
	}
	
	public String getCPF() {
		return this.cpf;
	}
	
	public String getSetor() {
		return this.setor;
	}
	
	public abstract void setHorasExtras(float horasExtras);
	public abstract void setTotalHoras(float totalHoras);
	public abstract void setValorHora(float valorHora);
	public abstract void setSalario(float salario);
	public abstract float calculaSalarioMensal();
	public abstract String toString();
}
