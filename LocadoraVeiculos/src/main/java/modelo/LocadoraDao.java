package modelo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import sql.conexao; // Importa sua classe de conexão

public class LocadoraDao {

    public LocadoraDao() {
        // Construtor padrão
    }

    // O construtor com Connection con não é mais necessário se você obtém a conexão via 'conexao.getConexao()'
    // public LocadoraDao(Connection con) {
    //     this.con = con;
    // }

    public List<Locacao> getAll() {
        List<Locacao> lista = new ArrayList<>();
        String sql = "SELECT l.id, l.id_cliente, l.id_veiculo, c.nome AS nomeCliente, "
                   + "v.marca AS marcaVeiculo, v.modelo AS modeloVeiculo, "
                   + "l.data_inicio, l.data_fim, l.valor_diaria, l.valor_total "
                   + "FROM locacao l "
                   + "INNER JOIN cliente c ON l.id_cliente = c.id "
                   + "INNER JOIN veiculo v ON l.id_veiculo = v.id";

        try (Connection con = conexao.getConexao(); // Obter a conexão aqui
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Locacao loc = new Locacao();
                loc.setId(rs.getInt("id")); // Define o ID da locação
                loc.setIdCliente(rs.getInt("id_cliente"));
                loc.setIdVeiculo(rs.getInt("id_veiculo"));
                loc.setNomeCliente(rs.getString("nomeCliente"));
                loc.setMarcaVeiculo(rs.getString("marcaVeiculo"));
                loc.setModeloVeiculo(rs.getString("modeloVeiculo"));
                loc.setDataQuandoAlugado(rs.getDate("data_inicio"));
                loc.setTerminoAlugado(rs.getDate("data_fim"));
                loc.setValorDiaria(rs.getDouble("valor_diaria"));
                loc.setValorTotal(rs.getDouble("valor_total"));
                lista.add(loc);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar todas as locações: " + e.getMessage());
            throw new RuntimeException("Erro ao buscar locações no banco de dados.", e);
        }
        return lista;
    }

    public Locacao getLocacaoById(int id) {
        Locacao locacao = null;
        String sql = "SELECT l.id, l.id_cliente, l.id_veiculo, c.nome AS nomeCliente, "
                   + "v.marca AS marcaVeiculo, v.modelo AS modeloVeiculo, "
                   + "l.data_inicio, l.data_fim, l.valor_diaria, l.valor_total "
                   + "FROM locacao l "
                   + "INNER JOIN cliente c ON l.id_cliente = c.id "
                   + "INNER JOIN veiculo v ON l.id_veiculo = v.id "
                   + "WHERE l.id = ?";

        try (Connection con = conexao.getConexao();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    locacao = new Locacao();
                    locacao.setId(rs.getInt("id"));
                    locacao.setIdCliente(rs.getInt("id_cliente"));
                    locacao.setIdVeiculo(rs.getInt("id_veiculo"));
                    locacao.setNomeCliente(rs.getString("nomeCliente"));
                    locacao.setMarcaVeiculo(rs.getString("marcaVeiculo"));
                    locacao.setModeloVeiculo(rs.getString("modeloVeiculo"));
                    locacao.setDataQuandoAlugado(rs.getDate("data_inicio"));
                    locacao.setTerminoAlugado(rs.getDate("data_fim"));
                    locacao.setValorDiaria(rs.getDouble("valor_diaria"));
                    locacao.setValorTotal(rs.getDouble("valor_total"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar locação por ID: " + e.getMessage());
            throw new RuntimeException("Erro ao buscar locação por ID no banco de dados.", e);
        }
        return locacao;
    }

    public boolean insert(Locacao locacao) {
        String sql = "INSERT INTO locacao (id_cliente, id_veiculo, data_inicio, data_fim, valor_diaria, valor_total) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = conexao.getConexao();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) { // Retorna chaves geradas
            ps.setInt(1, locacao.getIdCliente());
            ps.setInt(2, locacao.getIdVeiculo());
            ps.setDate(3, new java.sql.Date(locacao.getDataQuandoAlugado().getTime()));
            ps.setDate(4, new java.sql.Date(locacao.getTerminoAlugado().getTime()));
            ps.setDouble(5, locacao.getValorDiaria());
            ps.setDouble(6, locacao.getValorTotal());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                // Se a inserção foi bem-sucedida, pega o ID gerado e define no objeto Locacao
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        locacao.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            System.err.println("Erro ao inserir locação: " + e.getMessage());
            throw new RuntimeException("Erro ao inserir locação no banco de dados.", e);
        }
    }

    public boolean editarLocacao(Locacao locacao) {
        String sql = "UPDATE locacao SET id_cliente=?, id_veiculo=?, data_inicio=?, data_fim=?, valor_diaria=?, valor_total=? WHERE id=?";
        try (Connection con = conexao.getConexao();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, locacao.getIdCliente());
            ps.setInt(2, locacao.getIdVeiculo());
            ps.setDate(3, new java.sql.Date(locacao.getDataQuandoAlugado().getTime()));
            ps.setDate(4, new java.sql.Date(locacao.getTerminoAlugado().getTime()));
            ps.setDouble(5, locacao.getValorDiaria());
            ps.setDouble(6, locacao.getValorTotal());
            ps.setInt(7, locacao.getId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Erro ao editar locação: " + e.getMessage());
            throw new RuntimeException("Erro ao editar locação no banco de dados.", e);
        }
    }

    public boolean deletarLocacao(int id) {
        String sql = "DELETE FROM locacao WHERE id = ?";
        try (Connection con = conexao.getConexao();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Erro ao deletar locação: " + e.getMessage());
            throw new RuntimeException("Erro ao deletar locação no banco de dados.", e);
        }
    }

    public boolean finalizarLocacao(int idLocacao) {
        // Nesta versão, apenas simula a finalização, removendo da tabela.
        // Em um sistema real, você poderia ter uma coluna 'status' na locação.
        // Ou, se a ideia é apenas liberar o veículo, a lógica está no Controller.
        return deletarLocacao(idLocacao); // Por enquanto, finaliza deletando
    }
}