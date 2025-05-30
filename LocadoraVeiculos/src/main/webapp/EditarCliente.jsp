<%@ page import="modelo.Cliente" %>
<%@ page import="modelo.ClienteDAO" %>
<%@ page import="modelo.ClienteControler" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Atualizar Cliente</title>
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
            String nome = request.getParameter("nome");
            String cpf = request.getParameter("cpf");       
            String email = request.getParameter("email");
            String telefone = request.getParameter("telefone"); 
            String endereco = request.getParameter("endereco"); 
            String idParam = request.getParameter("id");    

            String mensagem = "";
            String tipoMensagem = "";
            int id = -1;

            try {
                id = Integer.parseInt(idParam);
            } catch (NumberFormatException e) {
                mensagem = "ID do cliente inválido para edição.";
                tipoMensagem = "error";
            }

            if (id != -1 && 
                nome != null && !nome.isEmpty() &&
                cpf != null && !cpf.isEmpty() &&
                email != null && !email.isEmpty() &&
                telefone != null && !telefone.isEmpty() &&
                endereco != null && !endereco.isEmpty()) {
                
                try {
                   
                    Cliente c = new Cliente(nome, cpf, email, telefone, endereco);

                    boolean sucesso = ClienteDAO.editarCliente(c, id); 

                    if (sucesso) {
                        mensagem = "Cliente editado com sucesso!";
                        tipoMensagem = "success";
                    } else {
                        mensagem = "Erro ao editar cliente. Cliente não encontrado ou outro problema.";
                        tipoMensagem = "error";
                    }
                } catch (RuntimeException e) {
                    mensagem = "Erro ao editar cliente: " + e.getMessage();
                    tipoMensagem = "error";
                    System.err.println("ERRO NA EDIÇÃO JSP (DAO): " + e.getMessage());
                } catch (Exception e) {
                    mensagem = "Ocorreu um erro inesperado na edição: " + e.getMessage();
                    tipoMensagem = "error";
                    System.err.println("ERRO INESPERADO NA EDIÇÃO JSP: " + e.getMessage());
                }

            } else if (id != -1) { 
                mensagem = "Preencha todos os campos para editar.";
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