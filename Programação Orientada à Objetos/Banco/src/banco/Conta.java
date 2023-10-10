package banco;

public class Conta {
	public String nome;
	private double saldo;
	boolean ativo = false;
	
	public Conta(String nome) {
		setNome(nome);
		this.saldo = 0;
		System.out.println("Conta criada.");
	}
	
	public void mostraSaldo() {
		System.out.println("Saldo atual: " + saldo);
	}
	public void deposita(double valor) {
		saldo += valor;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
}
