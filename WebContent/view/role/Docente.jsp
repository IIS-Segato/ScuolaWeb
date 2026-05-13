<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.Docente" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
	Docente docente = (Docente) session.getAttribute("docente");
	String nome = docente.getNome();
	String cognome = docente.getCognome();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DOCENTE</title>
</head>
<body>
	<h1><%= nome %></h1>
	<h1><%= cognome %></h1>
</body>
</html>