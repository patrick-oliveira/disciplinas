package strategy;

import java.util.Scanner;
import java.util.concurrent.ThreadLocalRandom;

public class ChuteAutomatico implements Chute {

	@Override
	public int chutar() {
		return ThreadLocalRandom.current().nextInt(1, 3 + 1);
	}
	
}
