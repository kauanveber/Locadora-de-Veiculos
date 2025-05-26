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
            String nome = request.getParameter("nome");
            String email = request.getParameter("email");
            String fone = request.getParameter("fone");

            if (nome != null && email != null && fone != null) {
                Cliente cliente = new Cliente();
                cliente.setNome(nome);
                cliente.setEmail(email);
                cliente.setFone(fone);

                ClienteDAO clidao = new ClienteDAO();
                ClienteControler cliControler = new ClienteControler(clidao);

                boolean sucesso = cliControler.inserir(cliente);

                if (sucesso) {
        %>
                    <h2>Cliente cadastrado com sucesso!</h2>
        <%
                } else {
        %>
                    <h2>Erro ao cadastrar cliente.</h2>
        <%
                }
            } else {
        %>
                <h2>Preencha todos os campos.</h2>
        <%
            }
        %>
        <p><a href="index.html">Voltar ao início</a></p>
        <p><a href="consulta.jsp">Ver lista de clientes</a></p>
    </div>
</body>
</html>
