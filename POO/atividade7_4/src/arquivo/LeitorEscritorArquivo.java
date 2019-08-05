package arquivo;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import funcionario.Funcionario;

public class LeitorEscritorArquivo {
	private String arquivo;
	private static int MAX = 100;

	public LeitorEscritorArquivo(String arquivo) {
		this.arquivo = arquivo;
	}

	public Funcionario[] leDados() throws FileNotFoundException, IOException {
		Funcionario[] funcs = new Funcionario[MAX]; 
		String linha;
		int quant = 0; 

		BufferedReader bufferLeitura = new BufferedReader(new FileReader(arquivo));
		try {

			linha = bufferLeitura.readLine();
			while (linha != null && quant < MAX) {
				// split divide a string (linhaLida) de acordo com o separador ";"
				// e obtem o codigo, nome e salario e os armazena no vetor campos:
				// campos[0] contera o codigo, campos[1] contera o nome, campos[2]
				// contera o salario
				String campos[] = linha.split(";");

				int id = Integer.parseInt(campos[0]);
				String nome = campos[1];
				double salario = Double.parseDouble(campos[2]);
				Funcionario f = new Funcionario(id, nome, salario);
				funcs[quant] = f;
				quant++;
				linha = bufferLeitura.readLine();
			}
			System.out.println("O arquivo foi lido e carregado para a memoria!");
		} finally {
			bufferLeitura.close();
		}
		return funcs;
	}

	public void salva(Funcionario funcionario) throws IOException {
		BufferedWriter bufferEscrita = new BufferedWriter(new FileWriter(arquivo, true));
		try {
			// escreve os atributos do funcionario separados por ";"
			bufferEscrita.write(funcionario.getId() + ";");
			bufferEscrita.write(funcionario.getNome() + ";");
			bufferEscrita.write(funcionario.getSalario() + "\r\n");
			System.out.println("Funcionário " + funcionario.getId() + " cadastrado!");
		} finally {
			bufferEscrita.close();
		}
	}

	public void remove(Funcionario[] funcionarios, int indiceAtual) {
		File file = new File(arquivo);
		file.delete();
		for(int i = 0; i <= indiceAtual; i++) {
			try {
				salvaGambiarra(funcionarios[i]);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}	
	}
	
	public void salvaGambiarra(Funcionario funcionario) throws IOException {
		BufferedWriter bufferEscrita = new BufferedWriter(new FileWriter(arquivo, true));
		try {
			// escreve os atributos do funcionario separados por ";"
			bufferEscrita.write(funcionario.getId() + ";");
			bufferEscrita.write(funcionario.getNome() + ";");
			bufferEscrita.write(funcionario.getSalario() + "\r\n");
			//System.out.println("Funcionário " + funcionario.getId() + " cadastrado!");
		} finally {
			bufferEscrita.close();
		}
	}

}
