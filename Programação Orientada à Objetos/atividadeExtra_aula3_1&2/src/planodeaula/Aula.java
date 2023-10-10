package planodeaula;

public class Aula {
	private String nome_da_aula;
	
	public Aula(String nome_da_aula) {
		this.nome_da_aula = nome_da_aula;
	}
	
	@Override
	public String toString() {
		return this.nome_da_aula;
	}
	
}
