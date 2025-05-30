<%@ page import="modelo.Cliente" %>
<%@ page import="modelo.ClienteDAO" %>
<%@ page import="modelo.ClienteControler" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Deletar Cliente</title>
    <style>
       
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container-feedback {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 500px;
            text-align: center;
        }
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-weight: bold;
            font-size: 1.1em;
        }
        .message.success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        a {
            text-decoration: none;
            color: #007BFF;
            margin: 0 10px;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container-feedback">
        <%
            String idParam = request.getParameter("id");
            String mensagem = "";
            String tipoMensagem = "";

            if (idParam != null && !idParam.isEmpty()) {
                try {
                    int id = Integer.parseInt(idParam);
                    boolean sucesso = ClienteDAO.deletarCliente(id); 

                    if (sucesso) {
                        mensagem = "Cliente deletado com sucesso!";
                        tipoMensagem = "success";
                    } else {
                        mensagem = "Erro ao deletar cliente. Cliente não encontrado ou outro problema.";
                        tipoMensagem = "error";
                    }
                } catch (NumberFormatException e) {
                    mensagem = "ID do cliente inválido.";
                    tipoMensagem = "error";
                    System.err.println("ERRO NO DELETAR JSP (ID inválido): " + e.getMessage());
                } catch (RuntimeException e) {
                    mensagem = "Erro ao deletar cliente: " + e.getMessage();
                    tipoMensagem = "error";
                    System.err.println("ERRO NO DELETAR JSP (DAO): " + e.getMessage());
                }
            } else {
                mensagem = "ID do cliente não fornecido.";
                tipoMensagem = "error";
            }
        %>
        <div class="message <%= tipoMensagem %>">
            <%= mensagem %>
        </div>
        <p><a href="index.html">Voltar ao Início</a></p>
        <p><a href="consulta.jsp">Ver Lista de Clientes</a></p>
    </div>
</body>
</html>