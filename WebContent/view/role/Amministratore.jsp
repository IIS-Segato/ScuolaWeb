<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="model.*" %>
<%@ page import="dao.AmministratoreDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 

	int aid = (int) request.getAttribute("aid"); 

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<a href="Role?action=INSERT">INSERT</a>
	<br/>
  	<table class="table" >
  		<thead>
    		<tr>
					<th scope="col">role_name</th>
					<th scope="col">description</th>
				</tr>
			</thead>
				<tbody>
					
				</tbody>
		</table>
</body>
</html>