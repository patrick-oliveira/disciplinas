package racional;

public class NumeroRacional {
	public int a;
	public int b;
	
	public NumeroRacional() {
		this.a = NumeroAleatorio.getAleatorio();
		do {
			this.b = NumeroAleatorio.getAleatorio();
		} while(this.b == 0);
		Simplificar();
	}
	
	public NumeroRacional(int a, int b) {
		if(b != 0) {
			this.a = a;
			this.b = b;
		} else {
			System.out.println("Denominador não pode ser nulo.");
		}
		Simplificar();
	}
	
	private void Simplificar() {
		int mdc = Math.min(this.a, this.b);
		if(this.a == 0) {
			this.b = 1;
			return;
		}
		
		while(this.a%mdc != 0 || this.b%mdc != 0){
			mdc--;
		}
		
		this.a = this.a/mdc;
		this.b = this.b/mdc;
	}
	
	public void Soma (NumeroRacional c) {
		int s_b = this.b*c.b;
		int s_a = this.a*c.b + c.a*this.b;
		this.a = s_a;
		this.b = s_b;
		Simplificar();
	}
	
	public String toString() {
		return ((Integer)this.a).toString()+"/"+((Integer)this.b).toString();
	}
}
