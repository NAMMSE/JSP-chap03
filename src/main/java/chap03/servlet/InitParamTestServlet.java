package chap03.servlet;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class InitParamTestServlet extends HttpServlet{

	// init() : 이 서블릿이 최초로 초기화될 때 한 번 실행되는 메서드
	@Override
	public void init(ServletConfig config) throws ServletException {
		// 지역 초기화 파라미터는 ServletConfig 내부에 들어있다.
		// 주로 해당 서블릿의 초기화에 이용되는 값들이다.
		System.out.println("user : "+config.getInitParameter("user"));
		System.out.println("password : "+config.getInitParameter("password"));
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		// 전역 초기화 파라미터는 application 객체 내부에 들어있다
		// 주로 웹 애플리케이션 전체에 영향을 미치는 값들이다
		ServletContext application = req.getServletContext();
		
		System.out.println(application.getInitParameter("pub_date"));
		System.out.println(application.getInitParameter("developer"));
		System.out.println(application.getInitParameter("user"));
		System.out.println(application.getInitParameter("pass"));
		
		resp.getWriter().append("Init Parameter Test");
	
	}
}
