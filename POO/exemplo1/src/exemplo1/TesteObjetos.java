package exemplo1;

public class TesteObjetos {

	public static void main(String[] args) {
		Conta conta1 = new Conta();
		conta1.nome = "Joao";
		conta1.deposita(500);
		System.out.println(conta1);
		
		Agencia agencia = new Agencia();
		agencia.adicionaConta(conta1);;
	}

}
