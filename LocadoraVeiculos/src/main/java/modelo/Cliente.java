package modelo;

public class Cliente {
    private int id;
    private String nome;
    private String cpf; 
    private String email;
    private String telefone; 
    private String endereco; 

    
    public Cliente() {
    }

   
    public Cliente(int id, String nome, String cpf, String email, String telefone, String endereco) {
        this.id = id;
        this.nome = nome;
        this.cpf = cpf;
        this.email = email;
        this.telefone = telefone;
        this.endereco = endereco;
    }

    
    public Cliente(String nome, String cpf, String email, String telefone, String endereco) {
        this.nome = nome;
        this.cpf = cpf;
        this.email = email;
        this.telefone = telefone;
        this.endereco = endereco;
    }

    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCpf() { 
        return cpf;
    }

    public void setCpf(String cpf) { 
        this.cpf = cpf;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefone() { 
        return telefone;
    }

    public void setTelefone(String telefone) { 
        this.telefone = telefone;
    }

    public String getEndereco() { 
        return endereco;
    }

    public void setEndereco(String endereco) { 
        this.endereco = endereco;
    }

    @Override
    public String toString() {
        return "Cliente{" +
               "id=" + id +
               ", nome='" + nome + '\'' +
               ", cpf='" + cpf + '\'' +
               ", email='" + email + '\'' +
               ", telefone='" + telefone + '\'' +
               ", endereco='" + endereco + '\'' +
               '}';
    }
}