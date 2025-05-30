package modelo;

import java.util.Date;

public class Locacao {

    private int id; // Adicionado ID para a locação
    private int idCliente;
    private int idVeiculo;
    private String nomeCliente;
    private String marcaVeiculo;
    private String modeloVeiculo;
    private Date dataQuandoAlugado;
    private Date terminoAlugado;
    private double valorTotal;
    private double valorDiaria;

    public Locacao() {
    }

    // Construtor completo com ID
    public Locacao(int id, int idCliente, int idVeiculo, String nomeCliente, String marcaVeiculo, String modeloVeiculo,
                   Date dataQuandoAlugado, Date terminoAlugado, double valorTotal, double valorDiaria) {
        this.id = id;
        this.idCliente = idCliente;
        this.idVeiculo = idVeiculo;
        this.nomeCliente = nomeCliente;
        this.marcaVeiculo = marcaVeiculo;
        this.modeloVeiculo = modeloVeiculo;
        this.dataQuandoAlugado = dataQuandoAlugado;
        this.terminoAlugado = terminoAlugado;
        this.valorTotal = valorTotal;
        this.valorDiaria = valorDiaria;
    }

    // Construtor para novas locações (sem ID inicial, será gerado pelo BD)
    public Locacao(int idCliente, int idVeiculo, String nomeCliente, String marcaVeiculo, String modeloVeiculo,
                   Date dataQuandoAlugado, Date terminoAlugado, double valorTotal, double valorDiaria) {
        this.idCliente = idCliente;
        this.idVeiculo = idVeiculo;
        this.nomeCliente = nomeCliente;
        this.marcaVeiculo = marcaVeiculo;
        this.modeloVeiculo = modeloVeiculo;
        this.dataQuandoAlugado = dataQuandoAlugado;
        this.terminoAlugado = terminoAlugado;
        this.valorTotal = valorTotal;
        this.valorDiaria = valorDiaria;
    }

    // Novo getter e setter para ID
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Os outros getters e setters permanecem os mesmos
    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public int getIdVeiculo() {
        return idVeiculo;
    }

    public void setIdVeiculo(int idVeiculo) {
        this.idVeiculo = idVeiculo;
    }

    public String getNomeCliente() {
        return nomeCliente;
    }

    public void setNomeCliente(String nomeCliente) {
        this.nomeCliente = nomeCliente;
    }

    public String getMarcaVeiculo() {
        return marcaVeiculo;
    }

    public void setMarcaVeiculo(String marcaVeiculo) {
        this.marcaVeiculo = marcaVeiculo;
    }

    public String getModeloVeiculo() {
        return modeloVeiculo;
    }

    public void setModeloVeiculo(String modeloVeiculo) {
        this.modeloVeiculo = modeloVeiculo;
    }

    public Date getDataQuandoAlugado() {
        return dataQuandoAlugado;
    }

    public void setDataQuandoAlugado(Date dataQuandoAlugado) {
        this.dataQuandoAlugado = dataQuandoAlugado;
    }

    public Date getTerminoAlugado() {
        return terminoAlugado;
    }

    public void setTerminoAlugado(Date terminoAlugado) {
        this.terminoAlugado = terminoAlugado;
    }

    public double getValorTotal() {
        return valorTotal;
    }

    public void setValorTotal(double valorTotal) {
        this.valorTotal = valorTotal;
    }

    public double getValorDiaria() {
        return valorDiaria;
    }

    public void setValorDiaria(double valorDiaria) {
        this.valorDiaria = valorDiaria;
    }
}