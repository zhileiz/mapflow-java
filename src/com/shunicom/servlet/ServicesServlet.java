package com.shunicom.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shunicom.visualize.processCSV;

/**
 * Servlet implementation class ServicesServlet
 */
public class ServicesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServicesServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processCSV pc = new processCSV();
		List<String> result = pc.reprocess("/home/zhileiz/heatmap.csv");
		StringBuilder sb = new StringBuilder();
		sb.append("[");
		for (String s:result){
			sb.append(s);
			System.out.println(s);
		}
		String toReturn = sb.toString();
		String trim = toReturn.substring(0,toReturn.length()-1).concat("]");
		response.getWriter().append(trim);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
