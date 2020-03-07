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
<div class="container">
<form class="form-inline" action="/action_page.php">
  <label for="email">Email address:</label>
  <input type="email" class="form-control" placeholder="Enter email" id="email">
  <label for="pwd">Password:</label>
  <input type="password" class="form-control" placeholder="Enter password" id="pwd">
  <div class="form-check">
    <label class="form-check-label">
      <input class="form-check-input" type="checkbox"> Remember me
    </label>
  </div>
  <button type="submit" class="btn btn-primary">Submit</button>
</form>
</div>
<div class="container">
  <h2>Hover Rows</h2>
  <p>The .table-hover class enables a hover state (grey background on mouse over) on table rows:</p>            
  <table class="table table-hover">
		<thead>
			<tr>
				<th>번호</th>
				<th>메인검색어</th>
				<th>연관검색어</th>

			</tr>
		</thead>
		<tbody>
			<!--데이터가 있는 만큼 <tr>이 반복됨 -->
			<c:forEach items="${list}" var="dto">
				<tr>
					<td>${dto.id}</td>
					<td>${dto.mainSearch}</td>
					<td>${dto.subSearch}</td>

					
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	test
<video controls autoplay loop>
   <source src="https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4" type="video/mp4"> 

</video>



</body>
</html>