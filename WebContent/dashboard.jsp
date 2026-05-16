<%@ page import="model.User" %>

<%
    User user =
        (User) session.getAttribute("user");

    // PROTEZIONE PAGINA
    if(user == null){

        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Dashboard</title>

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

<style>

body{
    background:#f5f5f5;
}

.box{
    max-width:600px;
    margin:80px auto;
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0 0 10px rgba(0,0,0,0.1);
}

</style>

</head>

<body>

<div class="box">

    <h2 class="mb-4">
        Dashboard
    </h2>

    <h4>
        Benvenuto
        <%= user.getUsername() %>
    </h4>

    <hr>

    <p>
        ID ruolo:
        <strong>
            <%= user.getRoleId() %>
        </strong>
    </p>

    <a href="logout"
       class="btn btn-danger">

        Logout
    </a>

</div>

</body>
</html>