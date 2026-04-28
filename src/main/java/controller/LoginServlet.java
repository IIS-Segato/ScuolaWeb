package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginServlet extends HttpServlet{
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws IOException, ServletException
	    {
	      response.setContentType("text/html");          // content type (MIME)
	      
	      PrintWriter output = response.getWriter();     // get writer
	      
	      String userId = request.getParameter("userId");
	      String pwd = request.getParameter("pwd");
	      
	    }
	
}