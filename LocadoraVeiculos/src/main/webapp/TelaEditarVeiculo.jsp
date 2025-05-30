<%@page import="modelo.Veiculo"%>
<%@page import="modelo.VeiculoDao"%>
<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String idStr = request.getParameter("id");
    int id = 0;
    Veiculo veiculo = null;
    VeiculoDao veiculoDao = new VeiculoDao();
    if (idStr != null) {
        try {
            id = Integer.parseInt(idStr);
            veiculo = veiculoDao.getVeiculoById(id);
        } catch (NumberFormatException e) {
            veiculo = null;
        }
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <title>Editar Veículo</title>
    <style>
      @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@600;700&display=swap');
      
      body {
        font-family: 'Montserrat', sans-serif;
        background: url('https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=1950&q=80') no-repeat center center/cover fixed;
        color: white;
        padding: 100px 0 0 0;
        margin: 0;
      }
      body::before {
        content: "";
        position: fixed;
        top: 0; left: 0; right: 0; bottom: 0;
        background-color: rgba(0, 0, 0, 0.65);
        z-index: 0;
      }
      nav {
        position: fixed;
        top: 0;
        width: 100%;
        padding: 20px 40px;
        display: flex;
        justify-content: center;
        gap: 40px;
        background: transparent;
        z-index: 10;
      }
      nav a {
        color: white;
        text-decoration: none;
        font-weight: 600;
        font-size: 14px;
        padding: 6px 12px;
        border-radius: 4px;
        transition: background-color 0.3s ease;
      }
      nav a:hover {
        background-color: #ffc300;
        color: #000;
      }
      .container {
        position: relative;
        z-index: 5;
        max-width: 420px;
        background-color: rgba(255, 255, 255, 0.95);
        color: #003566;
        padding: 40px 30px;
        border-radius: 12px;
        margin: auto;
        font-weight: 600;
        box-shadow: 0 8px 20px rgba(0,0,0,0.2);
      }
      h1 {
        text-align: center;
        margin-bottom: 25px;
        font-weight: 700;
        font-size: 2.8rem;
        letter-spacing: 3px;
        color: #003566;
      }
      label {
        display: block;
        margin-top: 15px;
        font-weight: 700;
        color: #003566;
      }
      input[type="text"] {
        width: 100%;
        padding: 12px 15px;
        margin-top: 8px;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-weight: 400;
        font-size: 1rem;
        background-color: #f9f9f9;
      }
      input[type="submit"] {
        width: 100%;
        padding: 14px;
        margin-top: 30px;
        background-color: #ffc300;
        border: none;
        color: #003566;
        font-weight: 700;
        font-size: 1.1rem;
        border-radius: 8px;
        cursor: pointer;
        box-shadow: 0 4px 10px #ffc300bb;
        transition: background-color 0.3s ease;
      }
      input[type="submit"]:hover {
        background-color: #e6ac00;
      }
      .error-msg {
        color: red;
        text-align: center;
        font-weight: 700;
        margin-top: 20px;
      }
      .back-link {
        text-align: center;
        margin-top: 20px;
      }
      .back-link a {
        color: #ffc300;
        font-weight: 600;
        text-decoration: none;
        transition: color 0.3s ease;
      }
      .back-link a:hover {
        color: #e6ac00;
      }
    </style>
</head>
<body>
<nav>
  <a href="index.html">Home</a>
  <a href="cadastro.html">Cadastro de Veículo</a>
  <a href="ConsultaVeiculos.jsp">Consulta de Veículos</a>
</nav>

<div class="container">
  <h1>Editar Veículo</h1>
  <%
    if (veiculo != null) {
  %>
  <form action="EditarVeiculo.jsp" method="post">
    <input type="hidden" name="id" value="<%= veiculo.getId() %>"/>
    
    <label for="placa">Placa:</label>
    <input type="text" name="placa" id="placa" value="<%= veiculo.getPlaca() %>" required/>
    
    <label for="marca">Marca:</label>
    <input type="text" name="marca" id="marca" value="<%= veiculo.getMarca() %>" required/>
    
    <label for="modelo">Modelo:</label>
    <input type="text" name="modelo" id="modelo" value="<%= veiculo.getModelo() %>" required/>
    
    <label for="cor">Cor:</label>
    <input type="text" name="cor" id="cor" value="<%= veiculo.getCor() %>" required/>
    
    <label for="ano">Ano de Fabricação:</label>
    <input
      type="text"
      name="ano"
      id="ano"
      value="<%= veiculo.getAnoFab() %>"
      required
      pattern="\d{4}"
      maxlength="4"
      title="Digite um ano com 4 dígitos (ex: 2024)"
    />
    
    <input type="submit" value="Salvar Alterações" />
  </form>
  <%
    } else {
  %>
    <p class="error-msg">Veículo não encontrado.</p>
  <%
    }
  %>

  <div class="back-link">
    <a href="ConsultaVeiculos.jsp">Voltar para Consulta</a>
  </div>
</div>
</body>
</html>
