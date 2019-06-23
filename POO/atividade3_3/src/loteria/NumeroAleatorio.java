package loteria;

import java.util.concurrent.ThreadLocalRandom;

public class NumeroAleatorio {
	public static int getAleatorio() {
		return ThreadLocalRandom.current().nextInt(0, 100 + 1);
	}
}
