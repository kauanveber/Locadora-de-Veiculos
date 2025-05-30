<%@page import="modelo.Cliente"%>
<%@page import="modelo.ClienteDAO"%>
<%@page import="modelo.ClienteControler"%> 
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>Consulta de Clientes</title>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

<style>

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body, html {
	height: 100%;
	font-family: 'Montserrat', sans-serif;
	color: white;
	overflow-x: hidden;
	background:
		url('https://images.unsplash.com/photo-1602416015694-8c9f9d53a0c3?auto=format&fit=crop&w=1950&q=80')
		no-repeat center center/cover;
	position: relative;
	padding-top: 80px;
}

body::before {
	content: "";
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: rgba(0, 0, 0, 0.7);
	z-index: 0;
}

nav {
	position: fixed;
	top: 0;
	width: 100%;
	padding: 20px 40px;
	display: flex;
	justify-content: center;
	gap: 30px;
	background: transparent;
	z-index: 10;
	flex-wrap: wrap;
}

nav a {
	color: white;
	text-decoration: none;
	font-weight: 600;
	letter-spacing: 1.2px;
	font-size: 14px;
	transition: all 0.3s ease;
	padding: 6px 12px;
	border-radius: 4px;
}

nav a:hover {
	background-color: #ffc300;
	color: #000;
	box-shadow: 0 2px 8px #ffc300aa;
	transform: scale(1.05);
}

.container {
	position: relative;
	z-index: 5;
	max-width: 1000px;
	margin: 0 auto;
	padding: 40px;
	background-color: rgba(255, 255, 255, 0.1);
	border-radius: 10px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
	backdrop-filter: blur(8px);
}

h1 {
	font-size: 2.8rem;
	text-align: center;
	color: #ffc300;
	margin-bottom: 30px;
	text-shadow: 0 2px 10px rgba(0, 0, 0, 0.6);
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
	background-color: rgba(255, 255, 255, 0.15);
	border-radius: 8px;
	overflow: hidden;
}

thead th {
	background-color: #000000aa;
	color: #fff;
	padding: 15px;
	text-align: left;
}

tbody td {
	padding: 15px;
	border-bottom: 1px solid #ffffff22;
	color: #fff;
}

tbody tr:hover {
	background-color: rgba(255, 255, 255, 0.1);
}

a i.fa-pencil {
	color: #ffc300;
	font-size: 1.2rem;
	transition: color 0.3s ease;
}

a:hover i.fa-pencil {
	color: #fff;
}

/* Ícone da lixeira para deletar */
a i.fa-trash-can {
	color: #dc3545;
	font-size: 1.2rem;
	transition: color 0.3s ease;
	margin-left: 6px;
}

a:hover i.fa-trash-can {
	color: #ff6b6b;
}

@media (max-width: 768px) {
	nav {
		flex-direction: column;
		align-items: center;
		padding: 15px 20px;
		gap: 10px;
	}
	.container {
		padding: 20px;
	}
	h1 {
		font-size: 2rem;
	}
	table, thead, tbody, th, td, tr {
		font-size: 14px;
	}
}
</style>
</head>
<body>
	<nav>
		<a href="index.html">Home</a>
		<a href="cadastro.html">Cadastro de Clientes</a>
		<a href="ConsultaClientes.jsp">Consulta de Clientes</a>
		<a href="CadastroVeiculo.html">Cadastro de Veículos</a>
		<a href="ConsultaVeiculos.jsp">Consulta de Veículos</a>
	</nav>

	<div class="container">
		<h1>Consulta de Clientes</h1>
		<table>
			<thead>
				<tr>
					<th>ID</th>
					<th>Nome</th>
					<th>CPF</th>       
					<th>Email</th>
					<th>Telefone</th> 
					<th>Endereço</th>  
					<th>Editar</th>
					<th>Deletar</th>
				</tr>
			</thead>
			<tbody>
				<%
				
				ClienteDAO clienteDao = new ClienteDAO();
				ClienteControler clienteControler = new ClienteControler(clienteDao);
				List<Cliente> listaClientes = clienteControler.getAll(); 

				if (listaClientes.isEmpty()) {
				%>
					<tr>
						<td colspan="8" style="text-align: center; color: #ccc;">Nenhum cliente cadastrado.</td>
					</tr>
				<%
				} else {
					for (Cliente c : listaClientes) {
				%>
					<tr>
						<td><%= c.getId() %></td>
						<td><%= c.getNome() %></td>
						<td><%= c.getCpf() %></td>      
						<td><%= c.getEmail() %></td>
						<td><%= c.getTelefone() %></td>  
						<td><%= c.getEndereco() %></td>  
						<td>
							<a href="./TelaEditarCliente.jsp?id=<%= c.getId() %>" title="Editar">
								<i class="fa-solid fa-pencil"></i>
							</a>
						</td>
						<td>
							<a href="./DeletarCliente.jsp?id=<%= c.getId() %>" title="Deletar" onclick="return confirm('Tem certeza que deseja deletar este cliente?');">
								<i class="fa-solid fa-trash-can"></i>
							</a>
						</td>
					</tr>
				<%
					}
				}
				%>
			</tbody>
		</table>
	</div>
</body>
</html>