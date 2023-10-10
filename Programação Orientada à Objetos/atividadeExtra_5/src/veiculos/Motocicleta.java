package veiculos;

public class Motocicleta extends Veiculo{
	private int cilindradas;
	
	public Motocicleta(String modelo, int ano, 
			float precoTabelaFipe, String placa, int cilindradas) {
		super("Motocicleta", modelo, ano, precoTabelaFipe, placa);
		setCilindradas(cilindradas);
	}
	
	@Override
	public float calculaIpva() {
		if(2019 - this.getAno() > 20) {
			return 0;
		} else {
			return (float)(0.02f*this.getPrecoTabelaFipe());
		}
	}
	
	public void setCilindradas(int cilindradas) {
		this.cilindradas = cilindradas;
	}
	
	public int getCilindradas() {
		return this.cilindradas;
	}
	
	@Override
	public String toString() {
		return super.toString() +
				"\nCilindradas: "+((Integer)getCilindradas()).toString()+
				"\nIPVA: "+((Float)calculaIpva()).toString();
	}
}
