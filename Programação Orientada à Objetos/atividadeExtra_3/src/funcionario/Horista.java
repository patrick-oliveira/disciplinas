package funcionario;

public class Horista extends Funcionario{
	private float totalHoras = 0;
	private float valorHora = 10;
	
	public Horista(String nome, String cpf, String setor) {
		super(nome, cpf, setor);
	}
	
	public void setTotalHoras(float totalHoras) {
		this.totalHoras = totalHoras;
	}
	
	public void setValorHora(float valorHora) {
		this.valorHora = valorHora;
	}
	
	public float getTotalHoras() {
		return this.totalHoras;
	}
	
	public float getValorHora() {
		return this.valorHora;
	}
	
	@Override
	public float calculaSalarioMensal() {
		if(totalHoras > 160) {
			float diferenca = this.totalHoras - 160;
			return this.valorHora*160.0f + (float)(1.4*diferenca*this.valorHora);
		} else {
			return this.totalHoras*this.valorHora;
		}
	}
	
	@Override
	public String toString() {
		return "Nome: "+getNome()+"\nCPF: "+getCPF()+"\nSetor: "+getSetor()
				+"\nValor por hora: "+this.valorHora
				+"\nHoras trabalhadas: "+this.totalHoras
				+"\nSalario Mensal: "+((Float)calculaSalarioMensal()).toString();
	}

	
	@Override
	public void setHorasExtras(float horasExtras) {
	}
	@Override
	public void setSalario(float salario) {
	}
}
