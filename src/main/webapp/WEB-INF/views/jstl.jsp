<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSTL</title>
<!-- 0725 수업 -->
</head>
<body>

	<h3># JSTL (JSP Standard Tag Library)</h3>
	<!-- maven repository 검색 > jstl 검색 > 다운 수 많은 것 선택 > 다운 수 많은 버전 선택 > jar로 다운 > 프로젝트 우클릭 빌드패스 
		> 모듈패스에 add external jar > 프로젝트 우클릭 properties > deployment assembly > add > java > 추가 > 서버 재시작 -->
	<!-- 집에서 할때는 클래스패스에 넣어보기 -->
	<ul>
		<li>JSP 파일에서 자바 코드를 손쉽게 사용하기 위한 커스텀 태그 라이브러리</li>
		<li>자바의 몇 가지 핵심기능을 태그 형태로 사용할 수 있다</li>
		<li>주로 화면을 만들 때 유용한 기능들이 포함되어 있다</li>
		<li>JSP 파일 맨 위에 커스텀 태그를 추가한 뒤 사용해야 한다</li>
	</ul>

	<h3># JSTL Core</h3>
	
	<p>자바의 주요 핵심 문법들을 사용할 수 있는 커스텀 태그 라이브러리</p>
	
	<dl>
		<dt>c:set</dt>
		<dd>setAttribute를 편리하게 사용할 수 있다.</dd>
		<dt>c:if</dt>
		<dd>자바의 if문을 편리하게 사용할 수 있다. (else, else if가 없다)</dd>
		<dt>c:choose, c:when, c:otherwise</dt>
		<dd>if, else if, else처럼 사용할 수 있는 조건문</dd>
		<dt>c:forEach</dt>
		<dd>순차적인 반복 처리</dd>
		<dt>c:forTokens</dt>
		<dd>하나의 긴 데이터를 자르면서 반복 처리</dd>
		<dt>c:url</dt>
		<dd>Context Path를 포함한 URL을 자동으로 생성</dd>
	</dl>
	
	<hr />
	
	<!-- 
		# c:set
		
		- 번거로운 setAttribute를 편리하게 사용할 수 있다.
		- var : 어트리뷰트의 이름
		- value : 어트리뷰트의 값
		- scope : page/request/session/application(생략 시 기본 값 : page) 
	-->
	<c:set var="fruit" value="apple" scope="request" />
	<c:set var="car" value="mycar"/>
	<%
		request.setAttribute("fruit","banana");
	%>
	
	${fruit }
	page.car : ${pageScope.car },
	request.car : ${requestScope.car }
	
	<c:set var="animal" value="사슴"></c:set> <!-- 커스텀 태그이기 때문에 밸류에 널값을 넣으면 null이라는 문자값이 들어가는 것이고 널을 넣을 수가 없다 -->
	<c:if test="${animal != null }">
		<p>animal attribute에 들어있던 값은 ${animal }입니다.</p>
	</c:if>
	
	<c:set var="tea" value="녹차" scope="application"></c:set>
	
	<!-- 이건 위에 c:set을 안적어줬다면 ${tea }에 값 자체가 없으므로 null이기 때문에 null로 인식하고 출력되지 않는다 -->
	<c:if test="${tea }">
		<p>${tea }입니다.</p>
	</c:if>
	
	<% if(pageContext.getAttribute("tea") != null
		&& request.getAttribute("tea")!= null
		&& session.getAttribute("tea")!= null
		&& application.getAttribute("tea")!= null) {%>
		<p>${tea }입니다</p>
		<%} %>
	
	<c:set var="num" value="85"></c:set>
	<p>
		<c:choose>
			<c:when test="${num > 100 || num < 0}">
			유효하지 않은 점수입니다.
			</c:when>
			<c:when test="${num > 90}">
			A등급입니다.
			</c:when>
			<c:when test="${num > 80}">
			B등급입니다.
			</c:when>
			<c:when test="${num > 70}">
			C등급입니다.
			</c:when>
			<c:otherwise>
			F등급입니다.(else)
			</c:otherwise>
		</c:choose>
	</p>

	<!-- begin ! end를 활용해 원하는 숫자로 반복하기 -->
	<!-- 
		# forEach문의 varStatus
		
		 - status.first : 첫 번째 반복일 때 true
		 - status.last  : 마지막 반복일 때 true
		 - status.index : 인덱스 (현재 i값)
		 - status.count : 개수 (1부터 시작)
		 - status.begin : 시작 했던 값
		 - status.end   : 마지막 값
	 -->
	<c:forEach begin="55" end="80" var="i" varStatus="status">
	<c:choose>
		<c:when test="${status.first }">
			<div id="div${i }" style="color:red;">${i }번째 DIV입니다.</div>
		</c:when>
		<c:when test="${status.last }">
			<div id="div${i }" style="color:blue;">${i }번째 DIV입니다.</div>
		</c:when>
		<c:when test="${status.count % 2==1 }">
			<div id="div${i }" style="color:green;">${status.index }번째 DIV입니다.</div>
		</c:when>
		<c:otherwise>
		<div id="div${i }">${i }번째 DIV입니다.</div>
		</c:otherwise>
		</c:choose>
	</c:forEach>
	
	<!-- items에 iterable(순서대로 꺼낼 수 있는)객체 넣어 사용하기 -->
	
	<%
		// c:set으로 모든 자바 문법을 사용할 수 있는 것이 아니다...
		String[] drinks = {"콜라","사이다","환타","미린다","요구르트"};
		request.setAttribute("drinks", drinks);
	%>
	
	<!-- 배열, List, Set ... 등이 iterable한 객체들이다 -->
	<!-- items : 값을 하나씩 꺼내준다 -->
	<c:forEach items="${drinks }" var="drink">
		<div id="${drink }">${drink }</div>
	</c:forEach>
	
	
	<!-- delims : String의 split처럼 해당 문자 단위로 끊어서 값을 꺼낸다 delim's'이기 때문에 여러개를 적어도 그만큼 끊어서 값을 꺼낸다 -->
	<ul>
		<c:forTokens items="milk/bread,fish,cake/beer" delims="/," var="food">
			<li id="${food }">${food }</li>
		</c:forTokens>
	</ul>


	<!-- c:url로 간편하게 URL 생성하기 -->
	<p><c:url value="/main/test"></c:url></p>
	
	<p>	<!-- chap03이 아니라 getcontextpath 넣는게 유동적이고 안전한거 확인 / 이거랑 위에 c:url이랑 같다-->
		<%=request.getContextPath() %>/main/test
	</p>
	
	<p>
		<c:url value="/main/test" var="myURL" scope="page">
			<c:param name="age" value="10">
			</c:param>
			<c:param name="math" value="95">
			</c:param>
		</c:url>
	</p>
	
	<a href="<c:url value="/main/test"/>"></a> <!-- 이거랑 -->
	<a href="${myURL }">눌러보세요!</a><!-- 이거랑 같다 -->






















</body>
</html>