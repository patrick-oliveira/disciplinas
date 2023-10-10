import banco.*;

public class Teste {

	public static void main(String[] args) {
		Conta conta1 = new Conta("João");
		conta1.deposita(500);
		System.out.println(conta1);
		
		Agencia agencia = new Agencia();
		agencia.adicionaConta(conta1);;
	}

}
