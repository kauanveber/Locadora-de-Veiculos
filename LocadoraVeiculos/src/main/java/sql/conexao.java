package sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class conexao {
    
	public static Connection getConexao() throws SQLException {
		String url = "jdbc:mysql://localhost:3306/mydb";
		String usuario = "root";
		String senha = "root";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return DriverManager.getConnection(url, usuario, senha);
	}
}