package exemplo1;

public class Conta {
	public String nome;
	private double saldo;
	boolean ativo = false;
	
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
