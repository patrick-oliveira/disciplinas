package racional;

import java.util.concurrent.ThreadLocalRandom;

public class NumeroAleatorio {
	public static int getAleatorio() {
		return ThreadLocalRandom.current().nextInt(1, 10 + 1);
	}
}
