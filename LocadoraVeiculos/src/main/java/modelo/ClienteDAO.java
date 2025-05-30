package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

    /**
     * Insere um novo cliente no banco de dados.
     *
     * @param cliente O objeto Cliente a ser inserido.
     * @return true se a inserção for bem-sucedida, false caso contrário.
     */
    public static boolean insert(Cliente cliente) {
        try {
            Connection con = sql.conexao.getConexao();
            // SQL atualizado para incluir 'cpf', 'email', 'telefone', 'endereco'
            String sql = "INSERT INTO cliente(nome, cpf, email, telefone, endereco) VALUES(?, ?, ?, ?, ?)";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, cliente.getNome());
            stm.setString(2, cliente.getCpf());       // Adicionado: CPF
            stm.setString(3, cliente.getEmail());
            stm.setString(4, cliente.getTelefone());  // Corrigido: getTelefone() em vez de getFone()
            stm.setString(5, cliente.getEndereco());  // Adicionado: Endereco
            stm.execute();
            return true; // Retorna true em caso de sucesso

        } catch (Exception e) {
            System.err.println("Erro ao inserir cliente: " + e.getMessage()); // Melhor para debug
            throw new RuntimeException("Erro ao inserir cliente: " + e.getMessage());
        }
    }

    /**
     * Retorna uma lista de todos os clientes no banco de dados.
     *
     * @return Uma lista de objetos Cliente.
     */
    public static List<Cliente> getAll() {
        List<Cliente> clientes = new ArrayList<>(); // Melhor prática para inicializar ArrayList
        try {
            Connection con = sql.conexao.getConexao();

            String sql = "SELECT id, nome, cpf, email, telefone, endereco FROM cliente"; // Selecionando todas as colunas
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                // Instanciando Cliente com todas as colunas (ID, nome, CPF, email, telefone, endereco)
                clientes.add(new Cliente(
                    rs.getInt("id"),
                    rs.getString("nome"),
                    rs.getString("cpf"),        // Adicionado: CPF
                    rs.getString("email"),
                    rs.getString("telefone"),   // Corrigido: lendo 'telefone'
                    rs.getString("endereco")    // Adicionado: Endereco
                ));
            }
        } catch (Exception e) {
            System.err.println("Erro ao obter todos os clientes: " + e.getMessage());
            throw new RuntimeException("Erro ao obter todos os clientes: " + e.getMessage());
        }
        return clientes;
    }

    /**
     * Retorna um cliente específico pelo seu ID.
     *
     * @param id O ID do cliente.
     * @return O objeto Cliente correspondente, ou um Cliente vazio se não encontrado.
     */
    public static Cliente getClienteById(int id) {
        Cliente cliente = null; // Inicializa como null para indicar que não foi encontrado
        try {
            Connection con = sql.conexao.getConexao();

            String sql = "SELECT id, nome, cpf, email, telefone, endereco FROM cliente WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                // Instanciando Cliente com todas as colunas encontradas
                cliente = new Cliente(
                    rs.getInt("id"),
                    rs.getString("nome"),
                    rs.getString("cpf"),        // Adicionado: CPF
                    rs.getString("email"),
                    rs.getString("telefone"),   // Corrigido: lendo 'telefone'
                    rs.getString("endereco")    // Adicionado: Endereco
                );
            }
        } catch (Exception e) {
            System.err.println("Erro ao obter cliente por ID: " + e.getMessage());
            throw new RuntimeException("Erro ao obter cliente por ID: " + e.getMessage());
        }
        return cliente; // Retorna o cliente encontrado ou null
    }

    /**
     * Atualiza os dados de um cliente existente.
     *
     * @param c O objeto Cliente com os dados atualizados.
     * @param id O ID do cliente a ser atualizado.
     * @return true se a atualização for bem-sucedida, false caso contrário.
     */
    public static boolean editarCliente(Cliente c, int id) {
        try {
            Connection con = sql.conexao.getConexao();

            // SQL atualizado para incluir 'cpf' e 'endereco' e usar 'telefone'
            String sql = "UPDATE cliente SET nome=?, cpf=?, email=?, telefone=?, endereco=? WHERE id=?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, c.getNome());
            stm.setString(2, c.getCpf());       // Adicionado: CPF
            stm.setString(3, c.getEmail());
            stm.setString(4, c.getTelefone());  // Corrigido: getTelefone()
            stm.setString(5, c.getEndereco());  // Adicionado: Endereco
            stm.setInt(6, id);                  // ID para a cláusula WHERE

            int linhasAfetadas = stm.executeUpdate();
            return linhasAfetadas > 0; // Retorna true se alguma linha foi afetada

        } catch (Exception e) {
            System.err.println("Erro ao editar cliente: " + e.getMessage());
            throw new RuntimeException("Erro ao editar cliente: " + e.getMessage());
        }
    }

    /**
     * Deleta um cliente do banco de dados pelo seu ID.
     *
     * @param id O ID do cliente a ser deletado.
     * @return true se a exclusão for bem-sucedida, false caso contrário.
     */
    public static boolean deletarCliente(int id) {
        try {
            Connection con = sql.conexao.getConexao();

            String sql = "DELETE FROM cliente WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);

            int linhasAfetadas = stm.executeUpdate();
            return linhasAfetadas > 0; // Retorna true se alguma linha foi afetada

        } catch (Exception e) {
            System.err.println("Erro ao deletar cliente: " + e.getMessage());
            throw new RuntimeException("Erro ao deletar cliente: " + e.getMessage());
        }
    }
}