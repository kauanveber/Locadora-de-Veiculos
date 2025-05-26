<%@page import="modelo.Veiculo"%>
<%@page import="modelo.VeiculoDao"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Consulta de Veículos</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap');

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    html, body {
      height: 100%;
      font-family: 'Montserrat', sans-serif;
      color: white;
      background: url('https://images.unsplash.com/photo-1602416015694-8c9f9d53a0c3?auto=format&fit=crop&w=1950&q=80') no-repeat center center/cover;
      position: relative;
    }

    body::before {
      content: "";
      position: fixed;
      top: 0; left: 0; right: 0; bottom: 0;
      background-color: rgba(0, 0, 0, 0.7);
      z-index: 0;
    }

    nav {
      position: fixed;
      top: 0;
      width: 100%;
      padding: 20px 40px;
      display: flex;
      justify-content: flex-end;
      gap: 30px;
      background: transparent;
      z-index: 10;
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
      margin: 140px auto 40px;
      background: rgba(255, 255, 255, 0.05);
      backdrop-filter: blur(12px);
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.6);
      color: white;
    }

    h1 {
      font-size: 2.5rem;
      text-align: center;
      margin-bottom: 30px;
      text-transform: uppercase;
      letter-spacing: 4px;
      color: #ffc300;
      text-shadow: 0 3px 10px rgba(0, 0, 0, 0.7);
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }

    thead th {
      background-color: rgba(255, 255, 255, 0.1);
      color: #ffc300;
      padding: 12px;
      text-transform: uppercase;
      font-size: 13px;
      letter-spacing: 1px;
    }

    tbody td {
      padding: 14px;
      border-bottom: 1px solid rgba(255, 255, 255, 0.2);
      text-align: center;
      color: white;
    }

    tr:hover {
      background-color: rgba(255, 255, 255, 0.1);
    }

    @media (max-width: 768px) {
      nav {
        padding: 15px 20px;
        gap: 15px;
      }

      nav a {
        font-size: 12px;
        padding: 5px 10px;
      }

      h1 {
        font-size: 1.8rem;
      }

      table th, table td {
        font-size: 12px;
        padding: 8px;
      }
    }
  </style>
</head>
<body>
  <nav>
    <a href="index.html">Home</a>
    <a href="cadastro.html">Cadastro de Clientes</a>
    <a href="consulta.jsp">Consulta de Clientes</a>
    <a href="CadastroVeiculo.html">Cadastro de Veículos</a>
    <a href="ConsultaVeiculos.jsp">Consulta de Veículos</a>
  </nav>

  <div class="container">
    <h1>Consulta de Veículos</h1>
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Placa</th>
          <th>Marca</th>
          <th>Modelo</th>
          <th>Cor</th>
          <th>Ano de Fabricação</th>
        </tr>
      </thead>
      <tbody>
        <%
          List<Veiculo> listaVeiculo = VeiculoDao.getAll();

          for (Veiculo v : listaVeiculo) {
        %>
        <tr>
          <td><%= v.getId() %></td>
          <td><%= v.getPlaca() %></td>
          <td><%= v.getMarca() %></td>
          <td><%= v.getModelo() %></td>
          <td><%= v.getCor() %></td>
          <td><%= v.getAnoFab() %></td>
        </tr>
        <%
          }
        %>
      </tbody>
    </table>
  </div>
</body>
</html>
