<%@ page import="modelo.LocadoraControler" %>
<%@ page import="modelo.LocadoraDao" %>
<%@ page import="modelo.VeiculoControler" %>
<%@ page import="modelo.VeiculoDao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String idLocacaoStr = request.getParameter("idLocacao");
    String idVeiculoStr = request.getParameter("idVeiculo"); 

    String mensagem = "";
    String tipoMensagem = "";

    if (idLocacaoStr != null && !idLocacaoStr.isEmpty() && idVeiculoStr != null && !idVeiculoStr.isEmpty()) {
        try {
            int idLocacao = Integer.parseInt(idLocacaoStr);
            int idVeiculo = Integer.parseInt(idVeiculoStr);

            LocadoraControler locadoraControler = new LocadoraControler(new LocadoraDao(), new VeiculoControler(new VeiculoDao()));
            
            if (locadoraControler.finalizarLocacao(idLocacao, idVeiculo)) { 
                mensagem = "Locação finalizada e veículo liberado com sucesso!";
                tipoMensagem = "success";
            } else {
                mensagem = "Não foi possível finalizar a locação.";
                tipoMensagem = "error";
            }
        } catch (NumberFormatException e) {
            mensagem = "Erro: ID da locação ou do veículo inválido.";
            tipoMensagem = "error";
            System.err.println("Erro FinalizarLocacao (NumberFormatException): " + e.getMessage());
        } catch (RuntimeException e) {
            mensagem = "Erro ao finalizar locação: " + e.getMessage();
            tipoMensagem = "error";
            e.printStackTrace(); 
        }
    } else {
        mensagem = "IDs de locação ou veículo não fornecidos para finalizar.";
        tipoMensagem = "error";
    }

    response.sendRedirect("ConsultaLocacoes.jsp?msg=" + java.net.URLEncoder.encode(mensagem, "UTF-8") + "&type=" + tipoMensagem);
%>