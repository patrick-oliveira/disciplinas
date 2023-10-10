import funcionario.*;

public class Main {

	public static void main(String[] args) {
		Funcionario[] funcionarios = new Funcionario[5];
		funcionarios[0] = new Efetivo("Pessoa 1", "123", "Setor1");
		((Efetivo) funcionarios[0]).setHorasExtras(20);
		funcionarios[1] = new Horista("Pessoa 2", "456", "Setor2");
		((Horista) funcionarios[1]).setTotalHoras(45);
		((Horista) funcionarios[1]).setValorHora(20);
		funcionarios[2] = new Horista("Pessoa 3", "789", "Setor3");
		((Horista) funcionarios[2]).setTotalHoras(34);
		funcionarios[3] = new Efetivo("Pessoa 4", "101112", "Setor4");
		((Efetivo) funcionarios[3]).setSalario(2700);
		funcionarios[4] = new Efetivo("Pessoa 5", "131415", "Setor5");
		((Efetivo) funcionarios[4]).setSalario(1300);
		((Efetivo) funcionarios[4]).setHorasExtras(15);
;
		
		for(int i = 0; i < funcionarios.length; i++) {
			System.out.println(funcionarios[i].toString());
			System.out.print("\n");
		}
	}

}
