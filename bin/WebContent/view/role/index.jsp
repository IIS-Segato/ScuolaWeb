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
					<%for(Role role:roles) {%>
						<tr>
							<td><%=role.getRole_name() %></td>
							<td><%=role.getDescription() %></td>
							<td>
								 <a href="Role?action=DELETE&id=<%=role.getId() %>">CANCELLA
								<!--	<button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#exampleModal">
										<i class="bi bi-trash3-fill"></i>
									</button> -->
								</a>
								<a href="Role?action=EDIT&id=<%=role.getId() %>">EDIT
									<!-- <button type="button" class="btn btn-secondary">
										<i class="bi bi-pen-fill"></i>
									</button> -->
								</a>
							</td>
						</tr>
						
					<%} %>
				</tbody>
		</table>
</body>
</html>