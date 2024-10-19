package com.example.lab10univers;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.IOException;
import java.time.LocalTime;

@WebFilter(filterName = "LogFilter", urlPatterns = "/*")
public class LogFilter implements Filter {
    private static final Logger LOG = LogManager.getLogger(LogFilter.class);

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws ServletException, IOException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;

        String servletPath = httpRequest.getServletPath();
        String method = httpRequest.getMethod();
        String timeStamp = LocalTime.now().toString();
        String remoteAddress = request.getRemoteAddr();

        LOG.info("Log: Path={}, Method={}, Time={}, IP={}", servletPath, method, timeStamp, remoteAddress);

        chain.doFilter(request, response);
    }

}
