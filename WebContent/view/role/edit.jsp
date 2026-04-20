<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="model.*" %>
<%@ page import="utils.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<% Role role = (Role) request.getAttribute("role");   
String id = "0";
if(request.getAttribute("id") != null){
	id=Integer.toString((Integer)request.getAttribute("id"));
}

%>    
<!DOCTYPE html>
<html>
  <head>
    <title>Edit Role</title>
  </head>
  <body class="p-5">
    <a href="Role"
      ><button type="button" class="btn btn-warning mr-3">
        TORNA ALLA LISTA
      </button></a
    >
    <h1 class="fw-bold mt-3">
      <span class="text-primary">MODIFICA</span> RUOLO
    </h1>

    <form action="Role" method="post">
      <input type="hidden" name="id" value="<%=id%>">
      <input type="hidden" name="action" value="<%=request.getAttribute("action")%>">
      <div class="mb-3">
        <label for="username" class="form-label fw-bold">Nome:</label>
        <input
          type="text"
          class="form-control"
          name="role_name"
          value="<%=role.getRole_name() != null ? role.getRole_name() : StringUtils.STRING_EMPTY  %>"
          required="required"
        />
      </div>
      <div class="mb-3">
        <label for="first_name" class="form-label fw-bold">Descrizione:</label>
        <input
          type="text"
          class="form-control"
          name="description"
          value="<%=role.getDescription() != null ? role.getDescription() : StringUtils.STRING_EMPTY  %>"
          required="required"
        />
      </div>
      <button type="reset" class="btn btn-warning">svuota i campi</button>
      <button type="submit" class="btn btn-success">salva</button>
    </form>
  </body>
</html>

