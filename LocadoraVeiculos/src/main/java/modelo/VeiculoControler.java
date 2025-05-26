package modelo;

import java.util.List;

public class VeiculoControler {
	
	private VeiculoDao veiculoDao;

	public VeiculoControler(VeiculoDao veiculodao) {
		this.veiculoDao = veiculodao;
	}

	public  List<Veiculo> getAll() {
		return VeiculoDao.getAll();
	}

	public boolean inserir(Veiculo veiculo) {
		return VeiculoDao.insert(veiculo);
	}
}
