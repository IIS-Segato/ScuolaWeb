<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="model.*" %>
<%@ page import="dao.RoleDao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	List<Role> roles = (ArrayList<Role>) request.getAttribute("roles");
%>
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8"/>
  <title>Ruoli</title>
  <style>
  	/* Stile del foglio e degli elementi*/
    body { font-family: sans-serif; max-width: 600px; margin: 60px auto; padding: 0 16px; }
    h1 { font-size: 20px; margin-bottom: 20px; }
    a.btn-insert { padding: 8px 16px; background: #2d5be3; color: #fff; border-radius: 4px; text-decoration: none; font-size: 14px; }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    th, td { text-align: left; padding: 10px 12px; border-bottom: 1px solid #eee; font-size: 14px; }
    th { font-size: 12px; font-weight: bold; color: #888; text-transform: uppercase; }
    a.edit   { color: #2d5be3; text-decoration: none; margin-right: 12px; }
    a.delete { color: #c0392b; text-decoration: none; }
    a.edit:hover, a.delete:hover { text-decoration: underline; }
  </style>
</head>
<body>
  <h1>Ruoli</h1>
  <a href="Role?action=INSERT" class="btn-insert">+ Nuovo</a>

  <table>
    <thead>
      <tr>
        <th>Nome</th>
        <th>Descrizione</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
    <!-- Ciclo su tutti i ruoli -->
      <%for(Role role : roles) {%>
      <tr>
        <td><%=role.getRole_name()%></td>
        <td><%=role.getDescription()%></td>
        <td>
          <a href="Role?action=EDIT&id=<%=role.getId()%>"   class="edit">Modifica</a>
          <a href="Role?action=DELETE&id=<%=role.getId()%>" class="delete">Elimina</a>
        </td>
      </tr>
      <%}%>
    </tbody>
  </table>
</body>
</html>
