package banco;

public class Agencia {
	private Conta[] contas = new Conta[3];
	
	public void removeConta(int indice) {
		// modifique depois para retornar Conta
	}
	private int encontraIndiceLivre() {
		for (int i = 0; i < contas.length; i++) {
			if (contas[i] == null)
				return i;
		}
		return -1;
	}
	public void adicionaConta(Conta conta) {
		int i = encontraIndiceLivre();
		if (i == -1) {
			System.out.println("Erro!");
			return;
		}
		contas[i] = conta;
		conta.ativo = true;
	}
}
