package com.shunicom.tools;

import java.io.IOException;  
import javax.servlet.Filter;  
import javax.servlet.FilterChain;  
import javax.servlet.FilterConfig;  
import javax.servlet.ServletException;  
import javax.servlet.ServletRequest;  
import javax.servlet.ServletResponse;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse; 


public class CharacterFilter implements Filter {  
    private FilterConfig config;  
      
    public void doFilter(ServletRequest req, ServletResponse resp,  
            FilterChain chain) throws IOException, ServletException {  
        HttpServletRequest request = (HttpServletRequest) req;  
        HttpServletResponse response = (HttpServletResponse) resp;  
        // 从web.xml文件中获取encoding对应的init-param中的param-value  
        String encoding = config.getInitParameter("encoding");  
        // 只要定义了变量；就要判断是否为空；不然会报空指针异常  
        if (encoding != null) {  
            // 指明内容请求格式的字符编码集  
            response.setContentType("text/html ;charset=" + encoding);  
            // 请求时规范字符编码格式  
            request.setCharacterEncoding(encoding);  
            // 指明输出的格式字符编码集  
            response.setCharacterEncoding(encoding);  
        }  
        // 进入下一个拦截器  
        chain.doFilter(request, response);  
    }  
    // FilterConfig 是拦截器的全局变量  
    public void init(FilterConfig config) throws ServletException {  
        this.config = config;  
    }  
    public void destroy() {  
    }  
}  