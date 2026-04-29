package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.Utente;
import dao.UtenteDAO;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Prendo dati dal form
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        

        // 2. Cerco utente nel DB
        UtenteDAO dao = new UtenteDAO();
        Utente utente = dao.trovaPerEmail(email);

        // 3. Controllo login
        if (utente != null && password.equals(utente.getPassword())) {
        	
        	//System.out.println(utente.toString());

            // 4. Creo sessione
            HttpSession session = request.getSession();
            session.setAttribute("utente", utente);

            // 5. Redirect in base al ruolo
            String ruolo = utente.getRuolo().toLowerCase();
            
            

            if (ruolo.equals("amministratore")) {
                response.sendRedirect("view/role/edit.jsp");
            } 
            else if (ruolo.equals("docente")) {
                response.sendRedirect("view/role/docente.jsp");
            } 
            else if (ruolo.equals("studente")) {
                response.sendRedirect("view/role/studente.html");
            } 
            else {
                response.sendRedirect("index.html");
            }

        } else {
            // login fallito
        	response.sendRedirect("errore_credenziali.html");
        }
    }
}