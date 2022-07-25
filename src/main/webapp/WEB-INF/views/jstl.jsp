<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSTL</title>
<!-- 0725 ���� -->
</head>
<body>

	<h3># JSTL (JSP Standard Tag Library)</h3>
	<!-- maven repository �˻� > jstl �˻� > �ٿ� �� ���� �� ���� > �ٿ� �� ���� ���� ���� > jar�� �ٿ� > ������Ʈ ��Ŭ�� �����н� 
		> ����н��� add external jar > ������Ʈ ��Ŭ�� properties > deployment assembly > add > java > �߰� > ���� ����� -->
	<!-- ������ �Ҷ��� Ŭ�����н��� �־�� -->
	<ul>
		<li>JSP ���Ͽ��� �ڹ� �ڵ带 �ս��� ����ϱ� ���� Ŀ���� �±� ���̺귯��</li>
		<li>�ڹ��� �� ���� �ٽɱ���� �±� ���·� ����� �� �ִ�</li>
		<li>�ַ� ȭ���� ���� �� ������ ��ɵ��� ���ԵǾ� �ִ�</li>
		<li>JSP ���� �� ���� Ŀ���� �±׸� �߰��� �� ����ؾ� �Ѵ�</li>
	</ul>

	<h3># JSTL Core</h3>
	
	<p>�ڹ��� �ֿ� �ٽ� �������� ����� �� �ִ� Ŀ���� �±� ���̺귯��</p>
	
	<dl>
		<dt>c:set</dt>
		<dd>setAttribute�� ���ϰ� ����� �� �ִ�.</dd>
		<dt>c:if</dt>
		<dd>�ڹ��� if���� ���ϰ� ����� �� �ִ�. (else, else if�� ����)</dd>
		<dt>c:choose, c:when, c:otherwise</dt>
		<dd>if, else if, elseó�� ����� �� �ִ� ���ǹ�</dd>
		<dt>c:forEach</dt>
		<dd>�������� �ݺ� ó��</dd>
		<dt>c:forTokens</dt>
		<dd>�ϳ��� �� �����͸� �ڸ��鼭 �ݺ� ó��</dd>
		<dt>c:url</dt>
		<dd>Context Path�� ������ URL�� �ڵ����� ����</dd>
	</dl>
	
	<hr />
	
	<!-- 
		# c:set
		
		- ���ŷο� setAttribute�� ���ϰ� ����� �� �ִ�.
		- var : ��Ʈ����Ʈ�� �̸�
		- value : ��Ʈ����Ʈ�� ��
		- scope : page/request/session/application(���� �� �⺻ �� : page) 
	-->
	<c:set var="fruit" value="apple" scope="request" />
	<c:set var="car" value="mycar"/>
	<%
		request.setAttribute("fruit","banana");
	%>
	
	${fruit }
	page.car : ${pageScope.car },
	request.car : ${requestScope.car }
	
	<c:set var="animal" value="�罿"></c:set> <!-- Ŀ���� �±��̱� ������ ����� �ΰ��� ������ null�̶�� ���ڰ��� ���� ���̰� ���� ���� ���� ���� -->
	<c:if test="${animal != null }">
		<p>animal attribute�� ����ִ� ���� ${animal }�Դϴ�.</p>
	</c:if>
	
	<c:set var="tea" value="����" scope="application"></c:set>
	
	<!-- �̰� ���� c:set�� ��������ٸ� ${tea }�� �� ��ü�� �����Ƿ� null�̱� ������ null�� �ν��ϰ� ��µ��� �ʴ´� -->
	<c:if test="${tea }">
		<p>${tea }�Դϴ�.</p>
	</c:if>
	
	<% if(pageContext.getAttribute("tea") != null
		&& request.getAttribute("tea")!= null
		&& session.getAttribute("tea")!= null
		&& application.getAttribute("tea")!= null) {%>
		<p>${tea }�Դϴ�</p>
		<%} %>
	
	<c:set var="num" value="85"></c:set>
	<p>
		<c:choose>
			<c:when test="${num > 100 || num < 0}">
			��ȿ���� ���� �����Դϴ�.
			</c:when>
			<c:when test="${num > 90}">
			A����Դϴ�.
			</c:when>
			<c:when test="${num > 80}">
			B����Դϴ�.
			</c:when>
			<c:when test="${num > 70}">
			C����Դϴ�.
			</c:when>
			<c:otherwise>
			F����Դϴ�.(else)
			</c:otherwise>
		</c:choose>
	</p>

	<!-- begin ! end�� Ȱ���� ���ϴ� ���ڷ� �ݺ��ϱ� -->
	<!-- 
		# forEach���� varStatus
		
		 - status.first : ù ��° �ݺ��� �� true
		 - status.last  : ������ �ݺ��� �� true
		 - status.index : �ε��� (���� i��)
		 - status.count : ���� (1���� ����)
		 - status.begin : ���� �ߴ� ��
		 - status.end   : ������ ��
	 -->
	<c:forEach begin="55" end="80" var="i" varStatus="status">
	<c:choose>
		<c:when test="${status.first }">
			<div id="div${i }" style="color:red;">${i }��° DIV�Դϴ�.</div>
		</c:when>
		<c:when test="${status.last }">
			<div id="div${i }" style="color:blue;">${i }��° DIV�Դϴ�.</div>
		</c:when>
		<c:when test="${status.count % 2==1 }">
			<div id="div${i }" style="color:green;">${status.index }��° DIV�Դϴ�.</div>
		</c:when>
		<c:otherwise>
		<div id="div${i }">${i }��° DIV�Դϴ�.</div>
		</c:otherwise>
		</c:choose>
	</c:forEach>
	
	<!-- items�� iterable(������� ���� �� �ִ�)��ü �־� ����ϱ� -->
	
	<%
		// c:set���� ��� �ڹ� ������ ����� �� �ִ� ���� �ƴϴ�...
		String[] drinks = {"�ݶ�","���̴�","ȯŸ","�̸���","�䱸��Ʈ"};
		request.setAttribute("drinks", drinks);
	%>
	
	<!-- �迭, List, Set ... ���� iterable�� ��ü���̴� -->
	<!-- items : ���� �ϳ��� �����ش� -->
	<c:forEach items="${drinks }" var="drink">
		<div id="${drink }">${drink }</div>
	</c:forEach>
	
	
	<!-- delims : String�� splitó�� �ش� ���� ������ ��� ���� ������ delim's'�̱� ������ �������� ��� �׸�ŭ ��� ���� ������ -->
	<ul>
		<c:forTokens items="milk/bread,fish,cake/beer" delims="/," var="food">
			<li id="${food }">${food }</li>
		</c:forTokens>
	</ul>


	<!-- c:url�� �����ϰ� URL �����ϱ� -->
	<p><c:url value="/main/test"></c:url></p>
	
	<p>	<!-- chap03�� �ƴ϶� getcontextpath �ִ°� �������̰� �����Ѱ� Ȯ�� / �̰Ŷ� ���� c:url�̶� ����-->
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
	
	<a href="<c:url value="/main/test"/>"></a> <!-- �̰Ŷ� -->
	<a href="${myURL }">����������!</a><!-- �̰Ŷ� ���� -->






















</body>
</html>