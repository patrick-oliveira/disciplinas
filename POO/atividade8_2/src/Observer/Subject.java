package Observer;

import java.util.ArrayList;
import java.util.List;

import jogo.Penalty;

public abstract class Subject {
	private List<Ouvinte> ouvintes = new ArrayList<Ouvinte>();
	
	public void attach(Ouvinte obs) {
		ouvintes.add(obs);
	}
	public void detach(Ouvinte obs) {
		ouvintes.remove(obs);
	}
	public void notify(Penalty jogo, boolean resultado) {
		for(Object obj : ouvintes) {
			Ouvinte obs = (Ouvinte) obj;
			obs.update(jogo, resultado);;
		}
	}
	
}
