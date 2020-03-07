<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 자바 프로그램을 태그로 사용하도록 정의-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--숫자나 통화, 날짜 같은 형태 맞춰주기 위하여 정의-->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	게시판 리스트

	<table>
		<thead>
			<tr>
				<th>번호2</th>
				<th>제목</th>
				<th>작성자</th>

			</tr>
		</thead>
		<tbody>
			<!--데이터가 있는 만큼 <tr>이 반복됨 -->
			<c:forEach items="${list }" var="dto">
				<tr>
					<td>${dto.id}</td>
					<td>${dto.mainSearch}</td>
					<td>${dto.subSearch}</td>

					
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>