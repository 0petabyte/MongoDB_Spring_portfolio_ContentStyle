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
	

	<table>
		<thead>
			<tr>
				<th>메인검색어</th>
				<th>연관검색어</th>
				<th></th>
				<th></th>

			</tr>
		</thead>
		<tbody>
			<!--데이터가 있는 만큼 <tr>이 반복됨 -->
			<c:forEach items="${list}" var="dto">
				<tr>
					
					<td>${dto.mainSearch}</td>
					<td>${dto.subSearch}</td>
					<td><a href="remove?id=${dto.id}"><button class="btn btn-danger">삭제</button></a></td>
					<td><a href="modify?id=${dto.id}"><button class="btn btn-warning">수정</button></a></td>
						
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>