import racional.*;

public class Principal {

	public static void main(String[] args) {
		NumeroRacional x = new NumeroRacional();
		NumeroRacional y = new NumeroRacional(NumeroAleatorio.getAleatorio(), NumeroAleatorio.getAleatorio());
		NumeroRacional z = new NumeroRacional(4, 8);
		
		System.out.println("x = "+x.toString());
		System.out.println("y = "+y.toString());
		System.out.println("z = "+z.toString());
		
		x.Soma(y);
		System.out.println("x + y = "+x.toString());
		y.Soma(z);
		System.out.println("y + z = "+y.toString());
		
	}

}
