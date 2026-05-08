<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.*" %>
<%@ page import="dao.DocentiDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
	// prendo l'id del docente in sessione
	int did = (int) session.getAttribute("did");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DOCENTE</title>
</head>
<body>
	<h1><%= did %></h1>
</body>
</html>