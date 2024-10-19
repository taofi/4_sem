package com.example.lab9;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.log4j.xml.DOMConfigurator;

import java.io.IOException;
import java.time.LocalTime;

@WebFilter(filterName = "LogFilter")
public class LogFilter implements Filter {
    static {
        new DOMConfigurator().doConfigure("D:\\4_sem\\TPI\\lab9\\log\\log4j.xml", LogManager.getLoggerRepository());
    }
    private static final Logger LOG = Logger.getLogger(LogFilter.class);
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;

        String servletPath = httpRequest.getServletPath();
        String method = httpRequest.getMethod();
        String timeStamp = LocalTime.now().toString();
        String remoteAddress = request.getRemoteAddr();

        LOG.info("Log: " + servletPath + method + timeStamp + remoteAddress);

        chain.doFilter(request, response);
    }
}
