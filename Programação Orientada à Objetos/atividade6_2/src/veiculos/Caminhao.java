package veiculos;

public class Caminhao extends Veiculo {
	private int eixos;
	private float capacidade;
	
	public Caminhao(String modelo, int ano, 
			float precoTabelaFipe, String placa, int eixos, float capacidade) {
		super("Caminhao", modelo, ano, precoTabelaFipe, placa);
		setEixos(eixos);
		setCapacidade(capacidade);
	}
	
	@Override
	public float calculaIpva() {
		if(2019 - this.getAno() > 20) {
			return 0;
		} else {
			return (float)(0.015f*this.getPrecoTabelaFipe());
		}
	}
	
	public void setEixos(int eixos) {
		this.eixos = eixos;
	}
	public void setCapacidade(float capacidade) {
		this.capacidade = capacidade;
	}
	
	public int getEixos() {
		return this.eixos;
	}
	public float getCapacidade() {
		return this.capacidade;
	}
	
	@Override
	public String toString() {
		return super.toString() +
				"\nEixos: "+ ((Integer)getEixos()).toString() +
				"\nCapacidade: "+ ((Float)getCapacidade()).toString()+
				"\nIPVA: "+((Float)calculaIpva()).toString();
	}
}
