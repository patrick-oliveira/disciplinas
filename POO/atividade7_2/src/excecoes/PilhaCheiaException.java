package excecoes;

public class PilhaCheiaException extends PilhaException {
	int limitePilha;
	Object naoEmpilhado; 
	
	public PilhaCheiaException(int limite, Object item) {
		super("PilhaCheiaException.");
		setLimite(limite);
		setObjetoNaoEmpilhado(item);
	}
	
	public void setLimite(int limite) {
		this.limitePilha = limite;
	}
	
	public void setObjetoNaoEmpilhado(Object item) {
		this.naoEmpilhado = item;
	}
	
	public int getLimite() {
		return this.limitePilha;
	}
	
	public Object getItem() {
		return this.naoEmpilhado;
	}
}
