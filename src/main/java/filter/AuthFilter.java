package filter;

import java.io.IOException;
import javax.servlet.Filter;
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