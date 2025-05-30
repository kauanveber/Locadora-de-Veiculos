<%@page import="modelo.VeiculoControler"%> <%-- Importa o controlador de Veículo --%>
<%@page import="modelo.VeiculoDao"%>    <%-- Importa a DAO de Veículo --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
 
    String idStr = request.getParameter("id");

    
    String mensagem = "";
    String tipoMensagem = ""; 

    
    if (idStr != null && !idStr.isEmpty()) {
        try {
           
            int id = Integer.parseInt(idStr);
            
           
            VeiculoControler vc = new VeiculoControler(new VeiculoDao());
            
           
            if (vc.deletarVeiculo(id)) {
                mensagem = "Veículo deletado com sucesso!";
                tipoMensagem = "success";
            } else {
                mensagem = "Não foi possível deletar o veículo. O ID pode não existir.";
                tipoMensagem = "error";
            }
        } catch (NumberFormatException e) {
            
            mensagem = "Erro: ID de veículo inválido.";
            tipoMensagem = "error";
            System.err.println("Erro ao deletar veículo (NumberFormatException): " + e.getMessage()); 
        } catch (RuntimeException e) {
            
            mensagem = "Erro ao deletar veículo: " + e.getMessage();
            tipoMensagem = "error";
            System.err.println("Erro ao deletar veículo (RuntimeException na DAO): " + e.getMessage()); 
        }
    } else {
       
        mensagem = "Nenhum ID de veículo fornecido para deleção.";
        tipoMensagem = "error";
    }

   
    response.sendRedirect("ConsultaVeiculos.jsp?msg=" + java.net.URLEncoder.encode(mensagem, "UTF-8") + "&type=" + tipoMensagem);
%>