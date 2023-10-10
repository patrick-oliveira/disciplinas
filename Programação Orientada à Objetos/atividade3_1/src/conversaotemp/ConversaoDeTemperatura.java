package conversaotemp;

public class ConversaoDeTemperatura {
	public static double CparaF(double C) {
		return (9.0/5.0)*C + 32;
	}
	
	public static double CparaK(double C) {
		return C + 273.15;
	}
	
	public static double FparaC(double F) {
		return (5.0/9.0)*(F - 32);
	}
	
	public static double KparaC(double K) {
		return K - 273.15;
	}
	
	public static double FparaK(double F) {
		return (5.0/9.0)*(F + 459.67);
	}
	
	public static double KparaF(double K) {
		return (9.0/5.0)*K - 459.67;
	}
}
