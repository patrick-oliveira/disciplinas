package pessoa;

public class Agenda {
	public Pessoa[] contatos;
	
	public void iniciaAgenda(int n) {
		if (n > 0)
			this.contatos = new Pessoa[n];
		else
			System.out.println("n <= 0");
	}
	
	public int buscaPessoa(String nome) {
		int i;
		for(i = 0; i < 10; i++) {
			if(contatos[i] != null && contatos[i].getNome() == nome) {
				return i;
			}
		}
		return -1;
	}
	
	public String buscaTelefone(String nome) {
		int i = buscaPessoa(nome);
		if(i != -1) {
			return contatos[i].getTelefone();
		} else {
			return nome + " não consta na agenda";
		}
	}
	
	public String buscaEmail(String nome) {
		int i = buscaPessoa(nome);
		if(i != -1) {
			return contatos[i].getEmail();
		} else {
			return nome + " não consta na agenda";
		}
	}
	
	public void imprimeDados(String nome) {
		int i = buscaPessoa(nome);
		if(i != -1) {
			contatos[i].imprimeDados();
		} else {
			System.out.println(nome + " não consta na agenda.");
		}
	}
	
	public void adicionaPessoa(Pessoa pessoa) {
		int i;
		i = buscaPessoa(pessoa.getNome());
		
		// Verifica se algum dado é invalido.
		if(pessoa.getNome() == null |
				pessoa.getEmail() == null |
				pessoa.getTelefone() == null) {
			System.out.println("Dados inválidos. Não é possível adicionar na agenda.");
			return;
		}
		
		// Verifica se já existe alguém com os mesmos dados.
		if(i != -1) {
			if(contatos[i].getEmail() == pessoa.getEmail()
					&& contatos[i].getTelefone() == pessoa.getTelefone()) {
				System.out.println(pessoa.getNome()+" já está na agenda");
				return;
			}
		}
		
		// Verifica se existe espaço na agenda.
		for(i = 0; i < 10; i++) {
			if(contatos[i] == null) {
				contatos[i] = pessoa;
				System.out.println(pessoa.getNome()+" adicionada à agenda.");
				return;
			}
		}
		System.out.println("Agenda cheia");
	}
	
	public void removePessoa(String nome) {
		int i = buscaPessoa(nome);
		if(i != -1) {
			contatos[i] = null;
			System.out.println(nome + " removido(a) da agenda.");
		} else {
			System.out.println(nome + " não consta na agenda.");
		}
	}
	
}
