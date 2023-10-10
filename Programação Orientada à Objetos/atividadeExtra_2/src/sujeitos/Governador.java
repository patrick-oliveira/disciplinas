package sujeitos;

public class Governador extends Politico {
	String estado;
	static int numero_governadores = 0;
	
	public Governador(String nome, String cpf, String partido, String estado) {
		super(nome, cpf, partido);
		this.estado = estado;
		Governador.numero_governadores++;
		Politico.numero_politicos++;
	}
	
	public String getEstado() {
		return this.estado;
	}
	
	@Override
	public String toString() {
		return "Nome: "+ this.getNome() +
				"CPF: "+ this.getCPF() +
				"Partido: "+ this.getPartido() +
				"Cargo: Prefeito" +
				"CidadE: " + this.getEstado();
	}
}
