import racional.*;

public class Principal {

	public static void main(String[] args) {
		NumeroRacional x = new NumeroRacional();
		NumeroRacional y = new NumeroRacional(NumeroAleatorio.getAleatorio(), NumeroAleatorio.getAleatorio());
		
		System.out.println("x = "+x.toString());
		System.out.println("y = "+y.toString());
		
		x.Soma(y);
		System.out.println("x + y = "+x.toString());
		
	}

}
