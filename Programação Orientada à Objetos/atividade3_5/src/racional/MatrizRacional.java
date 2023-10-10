package racional;

public class MatrizRacional {
	private int N;
	private int M;
	public NumeroRacional[][] matriz;
	
	public MatrizRacional() {
		this.N = 3;
		this.M = 3;
		this.matriz = new NumeroRacional[this.N][this.M];
		for(int i = 0; i < this.N; i++) {
			for(int j = 0; j < this.M; j++) {
				this.matriz[i][j] = new NumeroRacional();
			}
		}
	}
	
	public MatrizRacional(int n, int m) {
		this.N = n;
		this.M = m;
		this.matriz = new NumeroRacional[n][m];
		for(int i = 0; i < this.N; i++) {
			for(int j = 0; j < this.M; j++) {
				this.matriz[i][j] = new NumeroRacional(0, 1);
			}
		}
	}
	
	public void Soma(MatrizRacional A) {
		int[] A_dim = A.getDim();
		int[] This_dim = this.getDim();
		
		if(This_dim[0] != A_dim[0] || This_dim[1] != A_dim[1]) {
			System.out.println("Dimensões incompatíveis.");
			return;
		}
		
		for (int i = 0; i < A_dim[0]; i++) {
			for (int j = 0; j < A_dim[1]; j++) {
				this.matriz[i][j].Soma(A.matriz[i][j]);
			}
		}
	}
	
	public int[] getDim() {
		int[] dimensao = new int[2];
		dimensao[0] = this.N;
		dimensao[1] = this.M;
		return dimensao;
	}
	
	public void Imprime() {
		for(int i = 0; i < this.N; i++) {
			for(int j = 0; j < this.M; j++) {
				System.out.print(this.matriz[i][j].toString()+" ");
			}
			System.out.printf("\n");
		}
	}
	
}
