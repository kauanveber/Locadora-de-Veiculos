package modelo;

public class Veiculo {
    private int id;
    private String placa;
    private String modelo;
    private String marca;
    private String cor;
    private int anoFab;
    private double precoDiaria;
    private String situacao; // Ex: "Disponivel", "Alugado", "Manutencao"

    public Veiculo() {
        this.situacao = "Disponivel"; // Define a situação padrão ao criar um veículo
    }

    public Veiculo(int id, String placa, String modelo, String marca, String cor, int anoFab, double precoDiaria, String situacao) {
        this.id = id;
        this.placa = placa;
        this.modelo = modelo;
        this.marca = marca;
        this.cor = cor;
        this.anoFab = anoFab;
        this.precoDiaria = precoDiaria;
        this.situacao = situacao;
    }

    public Veiculo(String placa, String modelo, String marca, String cor, int anoFab, double precoDiaria) {
        this.placa = placa;
        this.modelo = modelo;
        this.marca = marca;
        this.cor = cor;
        this.anoFab = anoFab;
        this.precoDiaria = precoDiaria;
        this.situacao = "Disponivel"; // Situação padrão ao cadastrar um novo veículo
    }
    
    // Getters e Setters (já estão corretos e completos)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getCor() {
        return cor;
    }

    public void setCor(String cor) {
        this.cor = cor;
    }

    public int getAnoFab() {
        return anoFab;
    }

    public void setAnoFab(int anoFab) {
        this.anoFab = anoFab;
    }

    public double getPrecoDiaria() {
        return precoDiaria;
    }

    public void setPrecoDiaria(double precoDiaria) {
        this.precoDiaria = precoDiaria;
    }

    public String getSituacao() {
        return situacao;
    }

    public void setSituacao(String situacao) {
        this.situacao = situacao;
    }
}