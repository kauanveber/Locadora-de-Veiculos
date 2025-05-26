package modelo;

import java.util.List;

public class ClienteControler {
	
	private ClienteDAO clienteDao;

	public ClienteControler(ClienteDAO clienteDao) {
		this.clienteDao = clienteDao;
	}

	public List<Cliente> getAll() {
		return clienteDao.getAll();
	}

	public boolean inserir(Cliente cliente) {
		return ClienteDAO.insert(cliente);
	}
}
