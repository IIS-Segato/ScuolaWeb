package controller;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebFilter("/*")
public class AuthFilter implements Filter {
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,FilterChain chain)throws IOException,ServletException{
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		String path = req.getServletPath();
		
		//permette sempre il caricamento della pagina di login e le risorse statiche
		
		boolean isPublic = path.equals("/Login")|| path.startsWith("/css/")
                || path.startsWith("/js/")
                || path.startsWith("/images/")
                || path.equals("/index.html");
		
		if (isPublic) {
			chain.doFilter(request, response);
			return;
		}
		
		HttpSession session = req.getSession(false);
		Utente utente = (session != null) ? (Utente) session.getAttribute("utente"): null;
		
		if (utente == null) {
			resp.sendRedirect(req.getContextPath()+ "/Login");
			return;
		}
		chain.doFilter(request, response);
	}
	@Override
	public void destroy() {}
}