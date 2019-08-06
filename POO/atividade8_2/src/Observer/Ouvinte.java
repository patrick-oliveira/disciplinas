package Observer;

import jogo.Penalty;

public interface Ouvinte {
	
	void update(Penalty jogo, boolean resultado);
	
}
