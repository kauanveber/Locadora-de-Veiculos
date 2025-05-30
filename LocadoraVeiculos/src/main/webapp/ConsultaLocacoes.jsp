<%@page import="modelo.Veiculo"%>
<%@ page import="modelo.LocadoraControler" %>
<%@ page import="modelo.LocadoraDao" %>
<%@ page import="modelo.Locacao" %>
<%@ page import="modelo.VeiculoControler" %>
<%@ page import="modelo.VeiculoDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Consulta de Locações</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body, html {
            height: 100%;
            font-family: 'Montserrat', sans-serif;
            color: white;
            overflow-x: hidden;
            background: url('https://images.unsplash.com/photo-1602416015694-8c9f9d53a0c3?auto=format&fit=crop&w=1950&q=80') no-repeat center center/cover;
            position: relative;
            padding-top: 80px;
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
            top: 0; width: 100%;
            padding: 20px 40px;
            display: flex; justify-content: center; gap: 30px;
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
       
        thead th:nth-child(9),
        tbody td:nth-child(9) {
            text-align: center;
        }
        tbody td {
            padding: 15px;
            border-bottom: 1px solid #ffffff22;
            color: #fff;
        }
        tbody tr:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

       
        .action-icons a {
            display: inline-block; 
            margin: 0 3px; 
            text-decoration: none; 
        }
        .action-icons a i.fa-solid {
            font-size: 1.2rem; 
            transition: color 0.3s ease; 
        }

        
        .action-icons a i.fa-pencil {
            color: #ffc300;
        }
        .action-icons a:hover i.fa-pencil {
            color: #fff;
        }

       
        .action-icons a i.fa-trash-can {
            color: #dc3545; 
        }
        .action-icons a:hover i.fa-trash-can {
            color: #ff6b6b; 
        }

       
        .action-icons a i.fa-check {
            color: #28a745; 
        }
        .action-icons a:hover i.fa-check {
            color: #218838; 
        }
        

        .message {
            text-align: center;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: bold;
        }
        .message.success {
            background-color: rgba(60, 118, 61, 0.8);
            color: #dff0d8;
            border: 1px solid rgba(52, 106, 53, 0.8);
        }
        .message.error {
            background-color: rgba(169, 68, 66, 0.8);
            color: #f2dede;
            border: 1px solid rgba(153, 61, 59, 0.8);
        }
        @media (max-width: 768px) {
            nav {
                flex-direction: column;
                align-items: center;
                padding: 15px 20px;
                gap: 10px;
            }
            .container { padding: 20px; }
            h1 { font-size: 2rem; }
            table, thead, tbody, th, td, tr { font-size: 12px; }
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
        <h1>Locações Ativas</h1>
        <%
            String msg = request.getParameter("msg");
            String type = request.getParameter("type");
            if (msg != null && !msg.isEmpty()) {
        %>
            <div class="message <%= type %>">
                <%= msg %>
            </div>
        <%
            }
        %>
        <table>
            <thead>
                <tr>
                    <th>ID Locação</th>
                    <th>Cliente</th>
                    <th>Veículo</th>
                    <th>Placa</th>
                    <th>Data Início</th>
                    <th>Data Fim</th>
                    <th>Valor Diária</th>
                    <th>Valor Total</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <%
                   
                    LocadoraControler locadoraControler = new LocadoraControler(new LocadoraDao(), new VeiculoControler(new VeiculoDao()));
                    List<Locacao> listaLocacoes = locadoraControler.getAll();
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

                    if (listaLocacoes.isEmpty()) {
                %>
                    <tr>
                        <td colspan="9" style="text-align: center; color: #ccc;">Nenhuma locação ativa encontrada.</td>
                    </tr>
                <%
                    } else {
                        for (Locacao loc : listaLocacoes) {
                %>
                    <tr>
                        <td><%= loc.getId() %></td>
                        <td><%= loc.getNomeCliente() %></td>
                        <td><%= loc.getMarcaVeiculo() %> <%= loc.getModeloVeiculo() %></td>
                        <td>
                            <%
                               
                                Veiculo veicTemp = locadoraControler.getVeiculoControler().getVeiculoById(loc.getIdVeiculo());
                                if (veicTemp != null) {
                                    out.print(veicTemp.getPlaca());
                                } else {
                                    out.print("N/A");
                                }
                            %>
                        </td>
                        <td><%= sdf.format(loc.getDataQuandoAlugado()) %></td>
                        <td><%= sdf.format(loc.getTerminoAlugado()) %></td>
                        <td>R$ <%= String.format("%.2f", loc.getValorDiaria()) %></td>
                        <td>R$ <%= String.format("%.2f", loc.getValorTotal()) %></td>
                        <td class="action-icons">
                            <a href="FinalizarLocacao.jsp?idLocacao=<%= loc.getId() %>&idVeiculo=<%= loc.getIdVeiculo() %>" title="Finalizar Locação"
                               onclick="return confirm('Tem certeza que deseja finalizar esta locação e liberar o veículo?');">
                                <i class="fa-solid fa-check"></i>
                            </a>
                            <a href="DeletarLocacao.jsp?idLocacao=<%= loc.getId() %>&idVeiculo=<%= loc.getIdVeiculo() %>" title="Deletar Locação"
                               onclick="return confirm('Tem certeza que deseja deletar esta locação? (Esta ação não libera o veículo automaticamente)');">
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