package conversaotemp;

public class ConversorTemp implements ConversaoDeTemperatura {
	

	@Override
	public double CparaF(double C) {
		return (9.0/5.0)*C + 32;
	}
	
	@Override
	public double CparaK(double C) {
		return C + 273.15;
	}
	
	@Override
	public double FparaC(double F) {
		return (5.0/9.0)*(F - 32);
	}

	@Override
	public double KparaC(double K) {
		return K - 273.15;
	}

	@Override
	public double FparaK(double F) {
		return (5.0/9.0)*(F + 459.67);
	}

	@Override
	public double KparaF(double K) {
		return (9.0/5.0)*K - 459.67;
	}

}
