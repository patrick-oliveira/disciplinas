package veiculos;

public abstract class Veiculo implements Pagamento {
	private String tipo;
	private String modelo;
	private int ano;
	private float precoTabelaFipe;
	private String placa;
	
	public Veiculo(String tipo, String modelo, int ano, float precoTabelaFipe, String placa) {
		setTipo(tipo);
		setModelo(modelo);
		setAno(ano);
		setPrecoTabelaFipe(precoTabelaFipe);
		setPlaca(placa);
	}
	
	public void trocarPlaca(String placa) {
		this.placa = placa;
	}
	
	@Override
	public float calculaIpva() {
		return 0;
	}
	
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public void setModelo(String modelo) {
		this.modelo = modelo;
	}
	public void setAno(int ano) {
		this.ano = ano;
	}
	public void setPrecoTabelaFipe(float precoTabela) {
		this.precoTabelaFipe = precoTabela;
	}
	public void setPlaca(String placa) {
		this.placa = placa;
	}
	
	public String getTipo() {
		return this.tipo;
	}
	public String getModelo() {
		return this.modelo;
	}
	public int getAno() {
		return this.ano;
	}
	public float getPrecoTabelaFipe() {
		return this.precoTabelaFipe;
	}
	public String getPlaca() {
		return this.placa;
	}
	
	@Override
	public String toString() {
		return "Tipo: "+getTipo()+
				"\nModelo: "+getModelo()+
				"\nAno: "+((Integer)getAno()).toString()+
				"\nPreco: "+((Float)getPrecoTabelaFipe()).toString()+
				"\nPlaca: "+getPlaca();
	}
	
}
