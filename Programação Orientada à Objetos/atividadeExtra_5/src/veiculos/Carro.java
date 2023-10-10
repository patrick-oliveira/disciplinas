package veiculos;

public class Carro extends Veiculo {
	private int numPortas;
	
	public Carro(String modelo, int ano, 
			float precoTabelaFipe, String placa, int numPortas) {
		super("Carro", modelo, ano, precoTabelaFipe, placa);
		setNumPortas(numPortas);
	}
	
	@Override
	public float calculaIpva() {
		if(2019 - this.getAno() > 20) {
			return 0;
		} else {
			return (float)(0.03*this.getPrecoTabelaFipe());
		}
	}
	
	public void setNumPortas(int numPortas) {
		this.numPortas = numPortas;
	}
	
	public int getNumPortas() {
		return this.numPortas;
	}
	
	@Override
	public String toString() {
		return super.toString() +
				"\n Numero de portas: "+((Integer)getNumPortas()).toString()+
				"\n IPVA: "+((Float)calculaIpva()).toString();
	}
}
