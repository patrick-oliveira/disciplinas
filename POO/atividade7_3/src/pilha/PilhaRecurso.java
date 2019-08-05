package pilha;

public class PilhaRecurso extends PilhaAprimorada implements AutoCloseable {
	
	public PilhaRecurso(int tamanhoMax) {
		super(tamanhoMax);
	}

	@Override
	public void close() throws Exception {
		while(this.getTopo() > -1) {
			this.desempilha();
		}
		System.out.println("Pilha esvaziada!");
	}
	
	
}
