package complexo;

public class NumeroComplexo {
	private double real;
	private double imaginario;
	
	public void inicializaNumero(double a, double b) {
		this.real = a;
		this.imaginario = b;
	}
	
	public void imprimeNumero() {
		System.out.print(this.real+" + "+this.imaginario+"i");
	}
	
	public boolean ehIgual(NumeroComplexo c) {
		return (this.real == c.real && this.imaginario == c.imaginario);
	}
	
	public NumeroComplexo soma(NumeroComplexo c) {
		NumeroComplexo soma = new NumeroComplexo();
		soma.inicializaNumero(this.real + c.real, this.imaginario + c.imaginario);
		return soma;
	}
	
	public NumeroComplexo subtrai(NumeroComplexo c) {
		NumeroComplexo subtracao = new NumeroComplexo();
		subtracao.inicializaNumero(this.real - c.real, this.imaginario - c.imaginario);
		return subtracao;
	}
	
	public NumeroComplexo multiplica(NumeroComplexo c) {
		NumeroComplexo produto = new NumeroComplexo();
		produto.inicializaNumero(this.real*c.real - this.imaginario*c.imaginario, 
				this.real*c.imaginario + this.imaginario*c.real);
		return produto;
	}
	
	public NumeroComplexo divide(NumeroComplexo c) {
		NumeroComplexo divisao = new NumeroComplexo();
		double den = Math.pow(c.real, 2) + Math.pow(c.imaginario, 2);
		double a = (this.real*c.real + this.imaginario*c.imaginario)/den;
		double b = (this.imaginario*c.real - this.real*c.imaginario)/den;
		divisao.inicializaNumero(a, b);
		return divisao;
	}
}
