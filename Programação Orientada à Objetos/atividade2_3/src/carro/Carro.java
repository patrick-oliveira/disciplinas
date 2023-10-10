package carro;

public class Carro {
	private String modelo;
	private String tipo_combustivel;
	private double qtde_combustivel = 0;
	private double consumo;
	
	
	public void criaCarro(String modelo, String tipo, double qtde, double consumo) {
		if(!modelo.isBlank() && !tipo.isBlank() && consumo > 0 && qtde > 0) {
			this.modelo = modelo;
			this.tipo_combustivel = tipo;
			this.qtde_combustivel = qtde;
			this.consumo = consumo;
		} else {
			System.out.println("Dados inválidos.");
		}
	}
	
	public String getModelo() {
		return this.modelo;
	}
	public String getTipoCombustivel() {
		return this.tipo_combustivel;
	}
	public double getQtdeCombustivel() {
		return this.qtde_combustivel;
	}
	public double getConsumo() {
		return this.consumo;
	}
	
	public void setModelo(String modelo) {
		if (modelo != null && !modelo.isEmpty()) {
			this.modelo = modelo;
		} else {
			System.out.println("O modelo não pode ser vazio.");
		}
	}
	public void setTipoCombustivel(String tipo) {
		if (tipo != null && !tipo.isEmpty()) {
			this.tipo_combustivel = tipo;
		} else {
			System.out.println("O tipo de combustível não pode ser vazio.");
		}
	}
	public void abastecer(double qtde) {
		this.qtde_combustivel += qtde;
	}
	public void setConsumo(double consumo) {
		this.consumo = consumo;
	}
	
	public double combustivelNecessario(double distancia) {
		return distancia/this.consumo;
	}
	
	public void simulaViagem(double distancia) {
		double comb_necessario = combustivelNecessario(distancia);
		
		if(this.qtde_combustivel - comb_necessario < 0) {
			double max = this.consumo*this.qtde_combustivel;
			double dif = comb_necessario - this.qtde_combustivel;
			System.out.println("O combustível do tanque não é suficiente.");
			System.out.println("A maior distância possível de se percorrer é "+max+"km.");
			System.out.println("É necessário abastacer mais "+dif+"l de combustível.");
		} else {
			this.qtde_combustivel -= comb_necessario;
			System.out.println("Após percorrer "+distancia+"km, resta "+this.qtde_combustivel
					+"l de combustível.");
		}
	}
	
}
