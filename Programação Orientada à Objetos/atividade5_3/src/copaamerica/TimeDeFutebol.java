package copaamerica;

public class TimeDeFutebol {
	Jogador[] time;
	int numero_jogadores = 0;
	
	public TimeDeFutebol() {
		time = new Jogador[11];
	}
	
	public void adicionaJogador(Jogador novo_jogador) {
		if(numero_jogadores < 11) {
			time[numero_jogadores] = novo_jogador;
			numero_jogadores++;
			ordenaTime();
		}
	}
	
	public void substituiJogador(int numero_novo_jogador, int numero_substituir) {
		int i;
		for(i = 0; time[i] != null && time[i].numero != numero_substituir 
								   && i < 11; i++);
		
		if(i < 11) {
			time[i].numero = numero_novo_jogador;
			ordenaTime();
		} else {
			System.out.println("Jogador camisa "+numero_substituir+" não existe.");
		}
		
		
	}
	
	public void ordenaTime() {
		if(numero_jogadores > 1) {
			for(int i = 1; i < numero_jogadores; i++) {
				Jogador atual = time[i];
				int j = i - 1;
				while(j >= 0 && time[j].numero > atual.numero) {
					time[j+1] = time[j];
					j--;
				}
				time[j+1] = atual;
			}
		}
	}
	
	public String[] escalacao() {
		String[] escalacao = new String[numero_jogadores];
		for(int i = 0; i < numero_jogadores; i++)
			escalacao[i] = time[i].toString();
		
		return escalacao;
	}
	
	public boolean VerificaTime() {
		if(numero_jogadores < 11) {
			return false;
		} else {
			int numero_goleiros = 0;
			for(int i = 0; i < 11; i++) {
				if(time[i].posicao.equals("goleiro")) {
					numero_goleiros++;
				}
			}
			if(numero_goleiros > 1)
				return false;
		}
		return true;
	}
}
