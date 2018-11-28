package com.it.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Enumeration;

public class LoginStateFilter implements Filter{

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpSession session = ((HttpServletRequest) request).getSession(true);
        if(session.getAttribute("user")!=null){
            chain.doFilter(request,response);
        }else {
            ((HttpServletResponse) response).sendRedirect("/power.jsp");
        }
    }

    @Override
    public void destroy() {
    }
}
