package chap03.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EncodingTestServlet
 */
//	여러가지 URL에서 한 서블릿으로 매핑하는 것이 가능하다
@WebServlet(description = "한글 인코딩 테스트를 해보는 서블릿입니다.", urlPatterns = { "/encodingTest" })
public class EncodingTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/*
	 	GET방식 요청은 URL뒤에 데이터가 추가되어 도착한다
	 	URL의 해석은 Tomcat이 담당하기 때문에 URL뒤에 추가된 데이터를
	 	올바른 인코딩 타입으로 해석하기 위해서는 server.xml의 설정을 변경해야 한다
	 	(포트번호 설정하는 곳(connector태그)에 URIEncoding="EUC-KR" 추가)
	 	URI : URL에서 포트번호 뒷부분
	 */
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 문자열 추가
		//response.getWriter().append("Served at: ").append(request.getContextPath());

		// ContextPath : 우리 프로젝트의 최상위 URL. add and remove를 할 때 /server/server.xml에 자동으로 추가된다
		System.out.println("context path : "+request.getContextPath());
		System.out.println("subject : " + request.getParameter("subject"));
	}
	
	/*
	 	POST방식 요청은 데이터가 request 내부(body)에 실려 도착하기 때문에
	 	데이터를 꺼내기 전에 request 객체에 알맞은 인코딩 타입을 지정해주면 올바르게 디코딩 할 수 있다.
	 */

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("EUC-KR");
		
		doGet(request, response);
	}

}
