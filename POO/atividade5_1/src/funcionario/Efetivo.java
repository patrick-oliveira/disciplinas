package funcionario;

public class Efetivo extends Funcionario{
	private float salario = 1000;
	private float horasExtras = 0;
	
	public Efetivo (String nome, String cpf, String setor) {
		super(nome, cpf, setor);
	}
	
	public void setSalario(float salario) {
		this.salario = salario;
	}
	
	public void setHorasExtras(float horasExtras) {
		this.horasExtras = horasExtras;
	}
	
	public float getSalario() {
		return this.salario;
	}
	
	public float getHorasExtras() {
		return this.horasExtras;
	}
	
	@Override
	public String toString() {
		return "Nome: "+getNome()+"\nCPF: "+getCPF()+"\nSetor: "+getSetor()
				+"\nSalario: "+this.salario
				+"\nHoras Extras: "+this.horasExtras
				+"\nSalario Mensal: "+((Float)calculaSalarioMensal()).toString();
	}
	
	@Override
	public float calculaSalarioMensal() {
		return this.salario + (float)(1.5*this.horasExtras*(getSalario()/160.0));
	}
	
}
