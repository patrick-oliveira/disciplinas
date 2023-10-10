import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

import javax.swing.JOptionPane;

import arquivo.LeitorEscritorArquivo;
import excecoes.FuncionarioNaoCadastradoException;
import excecoes.LimiteAtingidoException;
import excecoes.NaoHaFuncionariosCadastradosException;
import funcionario.Funcionario;

public class Principal {
	private static final int MAX = 2;
	private static String arquivo = "funcionarios.txt";
	private static Funcionario[] funcionarios = new Funcionario[MAX];
	private static LeitorEscritorArquivo leituraEscrita = new LeitorEscritorArquivo(arquivo);
	private static int indiceAtual = -1;

	public static void main(String[] args) {

		// carrega dados do arquivo para o vetor de funcionarios
		carregaDados(arquivo);

		int opcao = 0;
		do {
			opcao = Integer.parseInt(JOptionPane.showInputDialog("Escolha uma opção:\n" + "1. Cadastrar funcionário\n"
					+ "2. Imprimir dados\n" + "3. Remover funcionário\n4. Sair"));
			switch (opcao) {
			case 1:
				try {
					cadastraFuncionario();
				} catch(LimiteAtingidoException e){
					e.printStackTrace();
				}
				break;
			case 2:
				try {
					imprimeDados();
				} catch(NaoHaFuncionariosCadastradosException e) {
					e.printStackTrace();
				}
				break;
			case 3:
				try {
					removeFuncionario();
				} catch(NaoHaFuncionariosCadastradosException e) {
					e.printStackTrace();
				} catch(FuncionarioNaoCadastradoException e) {
					e.printStackTrace();
				}
				break;
			case 4:
				System.out.println("Fim!");
				break;

			default:
				System.out.println("Opção inválida!");
				break;
			}

		} while (opcao != 4);

	}

	private static void carregaDados(String arquivo) {
		try {
			funcionarios = leituraEscrita.leDados();
		} catch (FileNotFoundException e) {
			System.out.println("Erro: Arquivo não encontrado! " + e.getMessage());
		} catch (IOException e) {
			System.out.println("Erro durante a leitura do arquivo!" + e.getMessage());
		}
		// acerta o indiceAtual de acordo com o número de elementos no vetor
		for (int i = 0; i < MAX && funcionarios[i] != null; i++) {
			indiceAtual++;
		}
	}

	private static void imprimeDados() throws NaoHaFuncionariosCadastradosException {
		if(indiceAtual > -1) {
			int i = 0;
			System.out.println("------------------------");
			while (i <= indiceAtual && funcionarios[i] != null) {
				System.out.println(funcionarios[i].toString());
				System.out.println("------------------------");
				i++;
			}
		} else {
			throw new NaoHaFuncionariosCadastradosException();
		}
	}

	private static void cadastraFuncionario() throws LimiteAtingidoException {
		if (indiceAtual + 1 < MAX) {
			try {
				int id = Integer.parseInt(JOptionPane.showInputDialog("Digite o código do funcionário: "));
				String nome = JOptionPane.showInputDialog("Digite o nome: ");
				float salario = Float.parseFloat(JOptionPane.showInputDialog("Digite o salário: "));
				Funcionario funcionario = new Funcionario(id, nome, salario);
				try {

					leituraEscrita.salva(funcionario);
					funcionarios[++indiceAtual] = funcionario;
			
				} catch (IOException e) {
					System.out.println("Erro no cadastro: " + e.getMessage());
				}
			} catch(NumberFormatException e) {
				e.printStackTrace();
				return;
			}
		} else {
			throw new LimiteAtingidoException();
		}
	}

	private static void removeFuncionario() throws NaoHaFuncionariosCadastradosException, FuncionarioNaoCadastradoException {
		if(indiceAtual > -1) {
			try {
				int Id = Integer.parseInt(JOptionPane.showInputDialog("Digite o código do funcionário: "));
				int indice = busca( Id );
				if(indice != -1) {
					if(indice < indiceAtual) {
						int i = indice;
						while(i < indiceAtual) {
							funcionarios[i] = funcionarios[i+1];
							i++;
						}
					}
					indiceAtual--;
					leituraEscrita.remove(funcionarios, indiceAtual);
				}  else {
					throw new FuncionarioNaoCadastradoException(Id);
				}
			} catch(NumberFormatException e) {
				e.printStackTrace();
				return;
			}
		} else {
			throw new NaoHaFuncionariosCadastradosException();
		}
	}
	
	// Dado o tamanho do programa, uma busca linear basta
	public static int busca(int id) {
		int i;
		for(i = 0; i <= indiceAtual; i++) {
			if(funcionarios[i].getId() == id)
				return i;
		}
		return -1;
	}

}
