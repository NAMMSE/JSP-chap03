package chap03.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ElseServlet extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 응답객체에도 인코딩을 해줘야 한글 출력이 된다
		resp.setCharacterEncoding("EUC-KR");
		resp.getWriter().append("어떤 매핑에도 해당하지 않았습니다. (ElseServlet)");
	}
}
