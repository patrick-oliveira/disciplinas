import pessoa.*;

public class Main {

	public static void main(String[] args) {
		Pessoa p1 = new Pessoa();
		Pessoa p2 = new Pessoa();
		Pessoa p3 = new Pessoa();
		Agenda agenda = new Agenda();
		
		
		p1.criaPessoa("Joao", "912345678", "joao@aluno.ufabc.edu.br");
		p2.criaPessoa("Maria", "123456789", "maria@aluno.ufabc.edu.br");
		p3.criaPessoa("Jose", "753159824","jose@aluno.ufabc.edu.br");
		
		p1.imprimeDados();
		p2.imprimeDados();
		p3.imprimeDados();
		
		p3.alterarEmailTelefone("", p3.getTelefone());
		p3.alterarEmailTelefone(p3.getEmail(), "      ");
		System.out.println(p3.getEmail());
		
		
		p3.alterarEmailTelefone("jose@hotmail.com", "987615487");
		p3.imprimeDados();
		
		System.out.println("\nTestando agenda.");
		
		agenda.iniciaAgenda(10);
		
		// Testando adições;
		agenda.adicionaPessoa(p1);
		agenda.adicionaPessoa(p2);
		agenda.adicionaPessoa(p3);
		agenda.adicionaPessoa(p3);

		// Testando verificações.
		System.out.print("\n");
		Pessoa p4 = new Pessoa();
		p4.setNome("Teste");
		p4.setEmail("Teste");
		agenda.adicionaPessoa(p4);
		
		Pessoa p5 = new Pessoa();
		p5.setNome("Teste");
		p5.setTelefone("Teste");
		agenda.adicionaPessoa(p5);
		
		Pessoa p6 = new Pessoa();
		p6.setTelefone("Teste");
		p6.setEmail("Teste");
		agenda.adicionaPessoa(p6);
		
		
		// Testando busca por nome e impressão dos dados
		System.out.print("\n");
		int i = agenda.buscaPessoa("Jose");
		agenda.imprimeDados(agenda.contatos[i].getNome());
		
		System.out.print("\n");
		agenda.buscaPessoa("Marcelo");
		
		// Buscando email por nome;
		System.out.print("\n");
		System.out.println(agenda.buscaEmail("Marcelo"));
		System.out.println(agenda.buscaEmail("Joao"));
		
		// Buscando telefone por nome;
		System.out.print("\n");
		System.out.println(agenda.buscaTelefone("Marcelo"));
		System.out.println(agenda.buscaTelefone("Joao"));
	
		
		// Testando remoção.
		System.out.print("\n");
		agenda.removePessoa("Joao");
		agenda.removePessoa("Joao");
		
		
		
	}

}
