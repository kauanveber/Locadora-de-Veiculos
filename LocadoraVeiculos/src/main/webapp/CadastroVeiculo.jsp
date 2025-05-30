<%@page import="modelo.VeiculoControler"%>
<%@page import="modelo.VeiculoDao"%>
<%@page import="modelo.Veiculo"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String placa = request.getParameter("placa");
    String modelo = request.getParameter("modelo");
    String marca = request.getParameter("marca");
    String cor = request.getParameter("cor");
    String anoStr = request.getParameter("ano");
    String precoD = request.getParameter("precoDiaria");

    if (placa != null && modelo != null && marca != null && cor != null && anoStr != null && precoD != null) {
        try {
            int anoFab = Integer.parseInt(anoStr);
			Double precoDiaria = Double.parseDouble(precoD);
            Veiculo v = new Veiculo(placa, modelo, marca, cor, anoFab,precoDiaria);
            VeiculoControler vc = new VeiculoControler(new VeiculoDao());
            vc.inserir(v);

            response.sendRedirect("ConsultaVeiculos.jsp");
        } catch (NumberFormatException e) {
            out.println("<h3>Erro: Ano inválido.</h3>");
        }
    } else {
        out.println("<h3>Erro: Todos os campos são obrigatórios.</h3>");
    }
%>
