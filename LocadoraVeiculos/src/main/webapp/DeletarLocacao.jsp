<%@ page import="modelo.LocadoraControler" %>
<%@ page import="modelo.LocadoraDao" %>
<%@ page import="modelo.VeiculoControler" %>
<%@ page import="modelo.VeiculoDao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String idLocacaoStr = request.getParameter("idLocacao");

    String mensagem = "";
    String tipoMensagem = "";

    if (idLocacaoStr != null && !idLocacaoStr.isEmpty()) {
        try {
            int idLocacao = Integer.parseInt(idLocacaoStr);
            
            
            LocadoraControler locadoraControler = new LocadoraControler(new LocadoraDao(), new VeiculoControler(new VeiculoDao()));
            
            if (locadoraControler.deletarLocacao(idLocacao)) {
                mensagem = "Locação deletada com sucesso!";
                tipoMensagem = "success";
            } else {
                mensagem = "Não foi possível deletar a locação.";
                tipoMensagem = "error";
            }
        } catch (NumberFormatException e) {
            mensagem = "Erro: ID da locação inválido.";
            tipoMensagem = "error";
            System.err.println("Erro DeletarLocacao (NumberFormatException): " + e.getMessage());
        } catch (RuntimeException e) {
            mensagem = "Erro ao deletar locação: " + e.getMessage();
            tipoMensagem = "error";
            e.printStackTrace(); 
        }
    } else {
        mensagem = "Nenhum ID de locação fornecido para deletar.";
        tipoMensagem = "error";
    }

    response.sendRedirect("ConsultaLocacoes.jsp?msg=" + java.net.URLEncoder.encode(mensagem, "UTF-8") + "&type=" + tipoMensagem);
%>