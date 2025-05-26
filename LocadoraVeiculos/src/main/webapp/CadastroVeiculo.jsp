<%@page import="modelo.VeiculoControler"%>
<%@page import="modelo.VeiculoDao"%>
<%@page import="modelo.Veiculo"%>
<%@ page import="modelo.Cliente" %>
<%@ page import="modelo.ClienteDAO" %>
<%@ page import="modelo.ClienteControler" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Cliente</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 500px;
            text-align: center;
        }
        a {
            text-decoration: none;
            color: #007BFF;
        }
    </style>
</head>
<body>
    <div class="container">
      <%
    String placa = request.getParameter("placa");
    String marca = request.getParameter("marca");
    String modelo = request.getParameter("modelo");
    String cor = request.getParameter("cor");
    String anoFab = request.getParameter("ano");

    if (placa != null && !placa.trim().isEmpty() &&
        marca != null && !marca.trim().isEmpty() &&
        modelo != null && !modelo.trim().isEmpty() &&
        cor != null && !cor.trim().isEmpty() &&
        anoFab != null && !anoFab.trim().isEmpty()) {

        
        Veiculo veiculo = new Veiculo(placa, modelo, marca, cor, anoFab);

        VeiculoDao veiDao = new VeiculoDao();
        VeiculoControler veiController = new VeiculoControler(veiDao);

        boolean sucesso = veiController.inserir(veiculo);


                if (sucesso) {
        %>
                    <h2>veiculo cadastrado com sucesso!</h2>
        <%
                } else {
        %>
                    <h2>Erro ao cadastrar veiculo.</h2>
        <%
                }
            } else {
        %>
                <h2>Preencha todos os campos.</h2>
        <%
            }
        %>
        <p><a href="index.html">Voltar ao início</a></p>
        <p><a href="ConsultaVeiculos.jsp">Ver lista de Veiculos</a></p>
    </div>
</body>
</html>
