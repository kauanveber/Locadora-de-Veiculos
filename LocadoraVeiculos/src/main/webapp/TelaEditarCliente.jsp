<%@page import="modelo.ClienteDAO"%>
<%@page import="modelo.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Editar Cliente</title>
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
      overflow-x: hidden;
    }

    body {
      color: white;
      background: url('https://images.unsplash.com/photo-1605559424843-1f3e8cfe3f89?auto=format&fit=crop&w=1950&q=80') no-repeat center center/cover fixed;
      position: relative;
    }

    body::before {
      content: "";
      position: fixed;
      top: 0; left: 0; right: 0; bottom: 0;
      background-color: rgba(0, 0, 0, 0.65);
      z-index: 1;
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
      z-index: 2;
    }

    nav a {
      color: white;
      text-decoration: none;
      font-weight: 600;
      letter-spacing: 1.2px;
      font-size: 14px;
      padding: 6px 12px;
      border-radius: 4px;
      transition: background-color 0.3s ease, color 0.3s ease;
    }

    nav a:hover {
      background-color: #ffc300;
      color: #000;
      box-shadow: 0 2px 8px #ffc300aa;
      transform: scale(1.05);
    }

    .container {
      position: relative;
      z-index: 10;
      margin: 100px auto 0;
      background-color: rgba(255, 255, 255, 0.95);
      color: #003566;
      padding: 40px 30px;
      border-radius: 12px;
      box-shadow: 0 8px 20px rgba(0,0,0,0.2);
      max-width: 420px;
      font-weight: 600;
    }

    h1 {
      text-align: center;
      margin-bottom: 25px;
      font-weight: 700;
      font-size: 2.8rem;
      letter-spacing: 3px;
    }

    form label {
      display: block;
      margin-top: 15px;
      font-weight: 700;
      color: #003566;
    }

    form input[type="text"],
    form input[type="email"],
    form input[type="tel"] {
      width: 100%;
      padding: 12px 15px;
      margin-top: 8px;
      border: 1px solid #ccc;
      border-radius: 8px;
      background-color: #f9f9f9;
      font-weight: 400;
      font-size: 1rem;
      transition: border-color 0.3s ease;
    }

    form input[type="text"]:focus,
    form input[type="email"]:focus,
    form input[type="tel"]:focus {
      border-color: #ffc300;
      outline: none;
      box-shadow: 0 0 8px #ffc300aa;
      background-color: #fff;
    }

    form input[type="submit"] {
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
      transition: background-color 0.3s ease, transform 0.3s ease;
      box-shadow: 0 4px 10px #ffc300bb;
    }

    form input[type="submit"]:hover {
      background-color: #e6ac00;
      transform: scale(1.05);
      box-shadow: 0 6px 14px #e6ac00cc;
    }

    
    @media (max-width: 480px) {
      .container {
        padding: 30px 20px;
        margin-top: 80px;
        width: 90%;
      }

      h1 {
        font-size: 2rem;
      }
    }
  </style>
</head>
<body>
  <nav>
    <a href="index.html">Home</a>
    <a href="cadastro.html">Cadastro</a>
    <a href="consulta.jsp">Consulta</a>
  </nav>

  <div class="container">
    <h1>Editar Cliente</h1>
    <%
        Cliente cliente = null;
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                cliente = ClienteDAO.getClienteById(id); 
            } catch (NumberFormatException e) {
                out.println("<p style='color: red;'>Erro: ID de cliente inválido.</p>");
                System.err.println("Erro TelaEditarCliente.jsp: ID inválido: " + e.getMessage());
            } catch (RuntimeException e) {
                out.println("<p style='color: red;'>Erro ao carregar cliente: " + e.getMessage() + "</p>");
                System.err.println("Erro TelaEditarCliente.jsp (DAO): " + e.getMessage());
            }
        }

        if (cliente != null) {
    %>
    <form action="EditarCliente.jsp" method="post">
      <input type="hidden" name="id" value="<%= cliente.getId() %>" />

      <label for="nome">Nome:</label>
      <input type="text" name="nome" id="nome" value="<%= cliente.getNome() %>" required />

      <label for="cpf">CPF:</label>
      <input type="text" name="cpf" id="cpf" value="<%= cliente.getCpf() %>" required pattern="\d{3}\.\d{3}\.\d{3}-\d{2}" placeholder="Ex: 123.456.789-00" title="Formato: 123.456.789-00" />

      <label for="email">Email:</label>
      <input type="email" name="email" id="email" value="<%= cliente.getEmail() %>" required />

      <label for="telefone">Telefone:</label>
      <input type="tel" name="telefone" id="telefone" value="<%= cliente.getTelefone() %>" required pattern="\(\d{2}\)\d{4,5}-\d{4}" placeholder="Ex: (47)9999-8888" title="Formato: (XX)XXXXX-XXXX ou (XX)XXXX-XXXX" />

      <label for="endereco">Endereço:</label>
      <input type="text" name="endereco" id="endereco" value="<%= cliente.getEndereco() %>" required />

      <input type="submit" value="Salvar Alterações" />
    </form>
    <%
        } else if (idParam != null && !idParam.isEmpty()) { 
            out.println("<p style='color: red;'>Cliente com ID " + idParam + " não encontrado.</p>");
        } else { 
            out.println("<p style='color: red;'>Nenhum ID de cliente fornecido para edição.</p>");
        }
    %>
  </div>
</body>
</html>