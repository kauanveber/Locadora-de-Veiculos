package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import sql.conexao; // Certifique-se de que a classe 'conexao' existe e funciona

public class VeiculoDao {

    public boolean insert(Veiculo veiculo) { // Não precisa ser static
        String sql = "INSERT INTO veiculo (placa, modelo, marca, cor, anoFab, precoDiaria, situacao) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = conexao.getConexao();
             PreparedStatement stm = con.prepareStatement(sql)) {
            stm.setString(1, veiculo.getPlaca());
            stm.setString(2, veiculo.getModelo());
            stm.setString(3, veiculo.getMarca());
            stm.setString(4, veiculo.getCor());
            stm.setInt(5, veiculo.getAnoFab());
            stm.setDouble(6, veiculo.getPrecoDiaria()); // Adicionado precoDiaria
            stm.setString(7, veiculo.getSituacao()); // Adicionado situacao
            stm.execute();
            return true;
        } catch (SQLException e) {
            System.err.println("Erro ao inserir veículo: " + e.getMessage());
            throw new RuntimeException("Erro ao inserir veículo no banco de dados.", e); // Lança a exceção original
        }
    }

    public List<Veiculo> getAll() { // Não precisa ser static
        List<Veiculo> veiculos = new ArrayList<>();
        String sql = "SELECT id, placa, modelo, marca, cor, anoFab, precoDiaria, situacao FROM veiculo";
        try (Connection con = conexao.getConexao();
             PreparedStatement stm = con.prepareStatement(sql);
             ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                veiculos.add(new Veiculo(
                    rs.getInt("id"),
                    rs.getString("placa"),
                    rs.getString("modelo"),
                    rs.getString("marca"),
                    rs.getString("cor"),
                    rs.getInt("anoFab"),
                    rs.getDouble("precoDiaria"),
                    rs.getString("situacao")
                ));
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar todos os veículos: " + e.getMessage());
            throw new RuntimeException("Erro ao buscar veículos no banco de dados.", e);
        }
        return veiculos;
    }

    public Veiculo getVeiculoById(int id) { // Não precisa ser static
        Veiculo veiculo = null;
        String sql = "SELECT id, placa, modelo, marca, cor, anoFab, precoDiaria, situacao FROM veiculo WHERE id = ?";
        try (Connection con = conexao.getConexao();
             PreparedStatement stm = con.prepareStatement(sql)) {
            stm.setInt(1, id);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    veiculo = new Veiculo(
                        rs.getInt("id"),
                        rs.getString("placa"),
                        rs.getString("modelo"),
                        rs.getString("marca"),
                        rs.getString("cor"),
                        rs.getInt("anoFab"),
                        rs.getDouble("precoDiaria"),
                        rs.getString("situacao") // Correção aqui
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar veículo por ID: " + e.getMessage());
            throw new RuntimeException("Erro ao buscar veículo no banco de dados.", e);
        }
        return veiculo;
    }

    public boolean editarVeiculo(Veiculo v) { // Não precisa ser static, ID vindo do objeto Veiculo
        String sql = "UPDATE veiculo SET placa=?, modelo=?, marca=?, cor=?, anoFab=?, precoDiaria=?, situacao=? WHERE id=?";
        try (Connection con = conexao.getConexao();
             PreparedStatement stm = con.prepareStatement(sql)) {
            stm.setString(1, v.getPlaca());
            stm.setString(2, v.getModelo());
            stm.setString(3, v.getMarca());
            stm.setString(4, v.getCor());
            stm.setInt(5, v.getAnoFab());
            stm.setDouble(6, v.getPrecoDiaria());
            stm.setString(7, v.getSituacao()); // Adicionado atualização da situação
            stm.setInt(8, v.getId()); // Pega o ID do objeto Veiculo
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0; // Retorna true se alguma linha foi atualizada
        } catch (SQLException e) {
            System.err.println("Erro ao editar veículo: " + e.getMessage());
            throw new RuntimeException("Erro ao editar veículo no banco de dados.", e);
        }
    }

    public boolean atualizarSituacaoVeiculo(int id, String novaSituacao) { // Novo método para atualizar situação
        String sql = "UPDATE veiculo SET situacao=? WHERE id=?";
        try (Connection con = conexao.getConexao();
             PreparedStatement stm = con.prepareStatement(sql)) {
            stm.setString(1, novaSituacao);
            stm.setInt(2, id);
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Erro ao atualizar situação do veículo: " + e.getMessage());
            throw new RuntimeException("Erro ao atualizar situação do veículo no banco de dados.", e);
        }
    }

    public boolean deletarVeiculo(int id) { // Não precisa ser static
        String sql = "DELETE FROM veiculo WHERE id = ?";
        try (Connection con = conexao.getConexao();
             PreparedStatement stm = con.prepareStatement(sql)) {
            stm.setInt(1, id);
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0; // Retorna true se alguma linha foi deletada
        } catch (SQLException e) {
            System.err.println("Erro ao deletar veículo: " + e.getMessage());
            throw new RuntimeException("Erro ao deletar veículo no banco de dados.", e);
        }
    }

    public List<Veiculo> getAllDisponiveis() { // Não precisa ser static
        List<Veiculo> lista = new ArrayList<>();
        String sql = "SELECT id, placa, modelo, marca, cor, anoFab, precoDiaria, situacao FROM veiculo WHERE situacao = 'Disponivel'"; // Corrigido para 'situacao'
        try (Connection con = conexao.getConexao();
             PreparedStatement stm = con.prepareStatement(sql);
             ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                lista.add(new Veiculo(
                    rs.getInt("id"),
                    rs.getString("placa"),
                    rs.getString("modelo"),
                    rs.getString("marca"),
                    rs.getString("cor"),
                    rs.getInt("anoFab"),
                    rs.getDouble("precoDiaria"),
                    rs.getString("situacao")
                ));
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar veículos disponíveis: " + e.getMessage());
            throw new RuntimeException("Erro ao buscar veículos disponíveis no banco de dados.", e);
        }
        return lista;
    }
}