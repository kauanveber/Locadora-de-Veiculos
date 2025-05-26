package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class VeiculoDao {
    
  
public static boolean insert(Veiculo veiculo) {
	try {
		Connection con = sql.conexao.getConexao();
		String sql = "insert into veiculo(placa, modelo, marca,cor,anoFab)" + "values(?,?, ?,?,?)";
		PreparedStatement stm = con.prepareStatement(sql);
		stm.setString(1, veiculo.getPlaca());
		stm.setString(2, veiculo.getModelo());
		stm.setString(3, veiculo.getMarca());
		stm.setString(4, veiculo.getCor());
		stm.setString(5, veiculo.getAnoFab());
		stm.execute();

	} catch (Exception e) {
		throw new RuntimeException(e.getMessage());
		
	}
	return true;
}

public static List<Veiculo> getAll() {
	List<Veiculo> veiculo = new ArrayList<Veiculo>();
	try {
		Connection con = sql.conexao.getConexao();

		String sql = "select * from veiculo";
		PreparedStatement stm = con.prepareStatement(sql);
		ResultSet rs = stm.executeQuery();
		while (rs.next()) {
			veiculo.add(new Veiculo(rs.getInt("id"), rs.getString("placa"), rs.getString("modelo"),
					rs.getString("marca"),rs.getString("cor"),rs.getString("anoFab")));
		}
	} catch (Exception e) {
		throw new RuntimeException(e.getMessage());
	}
	return veiculo;
}
}