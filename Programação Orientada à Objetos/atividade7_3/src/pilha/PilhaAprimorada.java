package pilha;

import excecoes.PilhaCheiaException;
import excecoes.PilhaVaziaException;

public class PilhaAprimorada extends PilhaSimples {

	public PilhaAprimorada(int tamanhoMax) {
		super(tamanhoMax);
	}
	
	@Override
	public void empilha(Object novoItem) {
		if(this.getTopo() + 1 < this.getTamanhoMax()) {
			super.empilha(novoItem);
		} else {
			throw new PilhaCheiaException(this.getTamanhoMax(), novoItem);
		}
	}
	
	@Override
	public Object desempilha() {
		if(this.getTopo() > -1) {
			return super.desempilha();
		} else {
			throw new PilhaVaziaException();
		}
	}

}
