<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Veiculo" %>
<%@ page import="modelo.Cliente" %>
<%@ page import="modelo.Locacao" %>
<%@ page import="modelo.LocadoraControler" %>
<%@ page import="modelo.VeiculoControler" %>
<%@ page import="modelo.LocadoraDao" %>
<%@ page import="modelo.VeiculoDao" %>
<%@ page import="modelo.ClienteDAO" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Locação</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet" />
    <style>
        
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center; 
            min-height: 100vh; 
        }
        nav {
            background-color: #333;
            padding: 10px;
            text-align: center;
            width: 100%; 
            box-shadow: 0 2px 5px rgba(0,0,0,0.2); 
        }
        nav a {
            color: #fff;
            margin: 0 15px;
            text-decoration: none;
            font-weight: bold;
        }
        nav a:hover {
            color: #ffc300;
        }
        .container {
            max-width: 500px; 
            margin: 50px auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px; 
        }
        label {
            display: block;
            margin: 15px 0 5px;
            font-weight: bold;
            color: #333; 
        }
        
        input[type="date"],
        select {
            width: 100%;
            padding: 10px;
            box-sizing: border-box; 
            border-radius: 4px;
            border: 1px solid #ccc;
            margin-bottom: 10px; 
        }
       
        input[type="submit"] {
            margin-top: 20px;
            width: 100%;
            padding: 10px; 
            background-color: #ffc300; 
            color: #333; 
            border: none;
            border-radius: 4px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #e6b800; 
        }
       
        .message {
            text-align: center;
            padding: 10px;
            margin-top: 20px;
            border-radius: 5px;
            font-weight: bold;
            width: 100%;
            box-sizing: border-box; 
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
    </style>
</head>
<body>
    <nav>
        <a href="index.html">Home</a>
        <a href="CadastroVeiculo.html">Cadastro de Veículo</a>
        <a href="ConsultaVeiculos.jsp">Consulta de Veículos</a>
        <a href="cadastro.html">Cadastro de Clientes</a>
        <a href="consulta.jsp">Consulta de Clientes</a>
        <a href="CadastroLocacao.jsp">Cadastro de Locação</a>
        <a href="ConsultaLocacoes.jsp">Consulta de Locações</a>
    </nav>

    <div class="container">
        <h1>Cadastro de Locação</h1>

        <%
            // Lógica de importação e processamento de dados JSP
            LocadoraDao locadoraDao = new LocadoraDao();
            VeiculoDao veiculoDao = new VeiculoDao();
            ClienteDAO clienteDao = new ClienteDAO();

            VeiculoControler veiculoControler = new VeiculoControler(veiculoDao);
            LocadoraControler locadoraControler = new LocadoraControler(locadoraDao, veiculoControler);

            List<Veiculo> veiculosDisponiveis = veiculoControler.getAllDisponiveis(); 
            List<Cliente> clientes = clienteDao.getAll();

            String mensagem = "";
            String tipoMensagem = ""; 

            if (request.getParameter("btnInserir") != null) {
                try {
                    int idCliente = Integer.parseInt(request.getParameter("idCliente"));
                    int idVeiculo = Integer.parseInt(request.getParameter("idVeiculo"));
                    
                    
                    String dataInicioStr = request.getParameter("dataInicio");
                    String dataFimStr = request.getParameter("dataFim");

                    if (dataInicioStr == null || dataInicioStr.isEmpty() || dataFimStr == null || dataFimStr.isEmpty()) {
                        throw new IllegalArgumentException("As datas de início e fim são obrigatórias.");
                    }

                    LocalDate dataInicio = LocalDate.parse(dataInicioStr);
                    LocalDate dataFim = LocalDate.parse(dataFimStr);

                    
                    if (dataFim.isBefore(dataInicio)) {
                        throw new IllegalArgumentException("A data de término não pode ser anterior à data de início.");
                    }
                    if (dataInicio.isBefore(LocalDate.now())) {
                        throw new IllegalArgumentException("A data de início não pode ser anterior à data atual.");
                    }


                    Cliente clienteSelecionado = clienteDao.getClienteById(idCliente);
                    Veiculo veiculoSelecionado = veiculoControler.getVeiculoById(idVeiculo);

                    if (clienteSelecionado != null && veiculoSelecionado != null) {
                        
                        if (!"Disponivel".equalsIgnoreCase(veiculoSelecionado.getSituacao())) {
                             throw new IllegalArgumentException("O veículo selecionado não está disponível para locação.");
                        }

                        long dias = ChronoUnit.DAYS.between(dataInicio, dataFim);
                       
                        if (dias == 0) dias = 1; 
                        else if (dias < 0) dias = 0; 

                        double valorTotal = dias * veiculoSelecionado.getPrecoDiaria();

                        Locacao novaLocacao = new Locacao();
                        novaLocacao.setIdCliente(idCliente);
                        novaLocacao.setNomeCliente(clienteSelecionado.getNome());
                        novaLocacao.setIdVeiculo(idVeiculo);
                        novaLocacao.setMarcaVeiculo(veiculoSelecionado.getMarca());
                        novaLocacao.setModeloVeiculo(veiculoSelecionado.getModelo());
                       
                        novaLocacao.setDataQuandoAlugado(java.sql.Date.valueOf(dataInicio));
                        novaLocacao.setTerminoAlugado(java.sql.Date.valueOf(dataFim));
                        novaLocacao.setValorDiaria(veiculoSelecionado.getPrecoDiaria());
                        novaLocacao.setValorTotal(valorTotal);

                        if (locadoraControler.inserir(novaLocacao)) {
                            mensagem = "Locação cadastrada com sucesso! Veículo atualizado para 'Alugado'.";
                            tipoMensagem = "success";
                           
                            veiculosDisponiveis = veiculoControler.getAllDisponiveis(); 
                        } else {
                            mensagem = "Erro ao cadastrar locação.";
                            tipoMensagem = "error";
                        }
                    } else {
                        mensagem = "Cliente ou veículo inválido. Por favor, verifique as seleções.";
                        tipoMensagem = "error";
                    }
                } catch (NumberFormatException e) {
                    mensagem = "Erro: IDs de cliente ou veículo inválidos.";
                    tipoMensagem = "error";
                } catch (IllegalArgumentException e) {
                    mensagem = "Erro na validação: " + e.getMessage();
                    tipoMensagem = "error";
                } catch (RuntimeException e) {
                    mensagem = "Erro no banco de dados ao cadastrar locação: " + e.getMessage();
                    tipoMensagem = "error";
                    e.printStackTrace(); 
                } catch (Exception e) {
                    mensagem = "Ocorreu um erro inesperado: " + e.getMessage();
                    tipoMensagem = "error";
                    e.printStackTrace(); 
                }
            }
        %>

        <% if (!mensagem.isEmpty()) { %>
            <div class="message <%= tipoMensagem %>">
                <%= mensagem %>
            </div>
        <% } %>

        <form method="post" action="CadastroLocacao.jsp">
            <label for="idCliente">Cliente:</label>
            <select id="idCliente" name="idCliente" required>
                <option value="">Selecione um cliente</option>
                <% for (Cliente c : clientes) { %>
                    <option value="<%= c.getId() %>"><%= c.getNome() %></option>
                <% } %>
            </select>

            <label for="idVeiculo">Veículo:</label>
            <select id="idVeiculo" name="idVeiculo" required>
                <option value="">Selecione um veículo</option>
                <% if (veiculosDisponiveis.isEmpty()) { %>
                    <option value="" disabled>Nenhum veículo disponível</option>
                <% } else { %>
                    <% for (Veiculo v : veiculosDisponiveis) { %>
                        <option value="<%= v.getId() %>">
                            <%= v.getMarca() %> <%= v.getModelo() %> (Placa: <%= v.getPlaca() %>) - R$ <%= String.format("%.2f", v.getPrecoDiaria()) %>
                        </option>
                    <% } %>
                <% } %>
            </select>

            <label for="dataInicio">Data início:</label>
            <input type="date" id="dataInicio" name="dataInicio" required><br>

            <label for="dataFim">Data fim:</label>
            <input type="date" id="dataFim" name="dataFim" required><br>

            <input type="submit" name="btnInserir" value="Cadastrar Locação">
        </form>
    </div>
</body>
</html>