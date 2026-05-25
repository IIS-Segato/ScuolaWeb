package filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthFilter implements Filter {

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;

		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();

		// Risorse sempre accessibili
		boolean isLoginPage = uri.equals(contextPath + "/Login");
		boolean isStatic = uri.contains("/css/") || uri.contains("/js/") || uri.contains("/img/")
				|| uri.endsWith(".css") || uri.endsWith(".js") || uri.endsWith(".ico");

		if (isLoginPage || isStatic) {
			chain.doFilter(req, res);
			return;
		}

		// Controlla la sessione
		HttpSession session = request.getSession(false);
		boolean loggedIn = (session != null && session.getAttribute("user") != null);

		if (!loggedIn) {
			response.sendRedirect(contextPath + "/Login");
		} else {
			chain.doFilter(req, res);
		}
	}

	@Override
	public void init(FilterConfig fc) {
	}

	@Override
	public void destroy() {
	}
}