package modelo;

public class Veiculo {
	private int id;
	private String placa;
	private String modelo;
	private String marca;
	private String cor;
	private String anoFab;
	
	public Veiculo() {
	
	}

	public Veiculo(String placa, String modelo, String marca, String cor, String anoFab) {
		
		this.placa = placa;
		this.modelo = modelo;
		this.marca = marca;
		this.cor = cor;
		this.anoFab = anoFab;
	}

	public Veiculo(int id, String placa, String modelo, String marca, String cor, String anoFab) {
		super();
		this.id = id;
		this.placa = placa;
		this.modelo = modelo;
		this.marca = marca;
		this.cor = cor;
		this.anoFab = anoFab;
	}

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

	public String getAnoFab() {
		return anoFab;
	}

	public void setAnoFab(String anoFab) {
		this.anoFab = anoFab;
	}
	
	
	
	
	
	
	
	
	
	
	
}
