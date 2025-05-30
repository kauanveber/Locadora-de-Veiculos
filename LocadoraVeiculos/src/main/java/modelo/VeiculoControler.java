package modelo;

import java.util.List;

public class VeiculoControler {

    private VeiculoDao veiculoDao; // Mudei para não ser estático

    public VeiculoControler(VeiculoDao veiculoDao) {
        this.veiculoDao = veiculoDao;
    }

    public List<Veiculo> getAll() {
        return veiculoDao.getAll(); // Chamar na instância, não estaticamente
    }

    public List<Veiculo> getAllDisponiveis() {
        return veiculoDao.getAllDisponiveis(); // Novo método para veículos disponíveis
    }

    public boolean inserir(Veiculo veiculo) {
        return veiculoDao.insert(veiculo); // Chamar na instância
    }

    public Veiculo getVeiculoById(int id) {
        return veiculoDao.getVeiculoById(id); // Novo método para buscar veículo por ID
    }

    public boolean editarVeiculo(Veiculo veiculo) { // Não precisa passar o ID separadamente se o objeto já o tem
        return veiculoDao.editarVeiculo(veiculo);
    }
    
    public boolean atualizarSituacaoVeiculo(int id, String novaSituacao) { // Novo método para atualizar situação
        return veiculoDao.atualizarSituacaoVeiculo(id, novaSituacao);
    }

    public boolean deletarVeiculo(int id) {
        return veiculoDao.deletarVeiculo(id); // Novo método para deletar
    }
}