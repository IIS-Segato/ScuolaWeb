<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Logout: elimina la sessione corrente
    if (session != null) {
        session.invalidate();
    }

    // Reindirizza alla homepage
    response.sendRedirect("homepage.jsp");
%>