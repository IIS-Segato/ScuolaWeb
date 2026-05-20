package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupera la sessione corrente, se esiste
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Invalida la sessione: rimuove tutti gli attributi associati
            session.invalidate();
        }
        
        // Reindirizza l'utente alla pagina di login con un messaggio opzionale
        response.sendRedirect(request.getContextPath() + "/index.html");
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}