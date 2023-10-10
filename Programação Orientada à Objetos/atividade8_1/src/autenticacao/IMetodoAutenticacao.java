package autenticacao;

public interface IMetodoAutenticacao {

	// Retorna o nome do usuario autenticado (null significa que a autenticacao falhou)
	UsuarioAutenticado autenticar() throws UsuarioNaoAutenticadoException;

}