package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {
    
  
public static boolean insert(Cliente cliente) {
	try {
		Connection con = sql.conexao.getConexao();
		String sql = "insert into cliente(nome, email, fone)" + "values(?,?, ?)";
		PreparedStatement stm = con.prepareStatement(sql);
		stm.setString(1, cliente.getNome());
		stm.setString(2, cliente.getEmail());
		stm.setString(3, cliente.getFone());
		stm.execute();

	} catch (Exception e) {
		throw new RuntimeException(e.getMessage());
		
	}
	return true;
}

public static List<Cliente> getAll() {
	List<Cliente> clientes = new ArrayList<Cliente>();
	try {
		Connection con = sql.conexao.getConexao();

		String sql = "select * from cliente";
		PreparedStatement stm = con.prepareStatement(sql);
		ResultSet rs = stm.executeQuery();
		while (rs.next()) {
			clientes.add(new Cliente(rs.getInt("id"), rs.getString("nome"), rs.getString("email"),
					rs.getString("fone")));
		}
	} catch (Exception e) {
		throw new RuntimeException(e.getMessage());
	}
	return clientes;
}
}