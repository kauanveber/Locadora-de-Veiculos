package modelo;

import java.util.List;

public class LocadoraControler {

    private LocadoraDao locacaoDao;
    private VeiculoControler veiculoControler; // Este atributo é privado

    public LocadoraControler(LocadoraDao locacaoDao, VeiculoControler veiculoControler) {
        this.locacaoDao = locacaoDao;
        this.veiculoControler = veiculoControler;
    }

    // Adicione este método GETTER:
    public VeiculoControler getVeiculoControler() {
        return veiculoControler;
    }

    public List<Locacao> getAll() {
        return locacaoDao.getAll();
    }

    public Locacao getLocacaoById(int id) {
        return locacaoDao.getLocacaoById(id);
    }

    public boolean inserir(Locacao locacao) {
        boolean sucessoLocacao = locacaoDao.insert(locacao);
        if (sucessoLocacao) {
            return veiculoControler.atualizarSituacaoVeiculo(locacao.getIdVeiculo(), "Alugado");
        }
        return false;
    }

    public boolean finalizarLocacao(int idLocacao, int idVeiculo) {
        boolean sucessoFinalizacao = locacaoDao.finalizarLocacao(idLocacao);
        if (sucessoFinalizacao) {
            return veiculoControler.atualizarSituacaoVeiculo(idVeiculo, "Disponivel");
        }
        return false;
    }

    public boolean editarLocacao(Locacao locacao) {
        return locacaoDao.editarLocacao(locacao);
    }

    public boolean deletarLocacao(int idLocacao) {
        return locacaoDao.deletarLocacao(idLocacao);
    }
}