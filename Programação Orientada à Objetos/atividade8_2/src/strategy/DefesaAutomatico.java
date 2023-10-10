package strategy;

import java.util.Scanner;
import java.util.concurrent.ThreadLocalRandom;

public class DefesaAutomatico implements Defesa{

	@Override
	public int defender() {
		return ThreadLocalRandom.current().nextInt(1, 3 + 1);
	}

}
