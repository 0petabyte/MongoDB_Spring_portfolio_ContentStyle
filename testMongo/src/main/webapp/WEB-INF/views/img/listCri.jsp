<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 자바 프로그램을 태그로 사용하도록 정의-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--숫자나 통화, 날짜 같은 형태 맞춰주기 위하여 정의-->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	$(document).ready(
		function(){
			$('#searchBtn').on("click",function(event){
				self.location = "list"
				+ '${pageMaker.makeQuery(1)}'
				+ '&searchType='
				+ $("select option:selected").val()
				+ "&keyword=" + encodeURIComponent($('#keywordInput').val());
			});
			
			$('#newBtn').on("click",function(evt){
				self.location = "register";
			});
		});

</script>
<script type="text/javascript">


</script>
</head>
<body>
	
	<div class="box-body form-inline">
		<select name="searchType" class="form-control" >
			<option value="n" <c:out value="${cri.searchType ==null ? 'selected':''}"/>>
			---</option>
			<option value="t" <c:out value="${cri.searchType eq 't'?'selected':''}"/>>
			제목</option>
			<option value="c" <c:out value="${cri.searchType eq 'c'?'seleted':''}"/>>
			내용</option>
			<option value="tc" <c:out value="${cri.searchType eq 'tc'?'seleted':''}"/>>
			제목 OR 내용</option>
		</select>
		<input class="form-control" type="text" name="keyword" id="keywordInput" value="${cri.keyword}">
		<button id="searchBtn" class="btn btn-outline-success">Search</button>
		<button id="newBtn" class="btn btn-outline-primary">New Board</button>
	</div>

	 <table class="table table-hover">
		<thead>
			<tr>
				<th>제목</th>
				<th>내용</th>
				<th>글쓴이</th>
				<th>시간</th>
			

			</tr>
		</thead>
		<tbody>
			<!--데이터가 있는 만큼 <tr>이 반복됨 -->
			<c:forEach items="${list}" var="dto">
				<tr>
					
					<td><a href="read${pageMaker.makeSearch(pageMaker.cri.page)}&id=${dto.id}">${dto.title}</a></td>
					<td>${dto.content}</td>
					<td>${dto.writer}</td>
					<td><fmt:formatDate pattern="yyyy.MM.dd HH:mm" value="${dto.dateTime}" /></td>
					
					
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 페이징 처리 Pageing -->

	<div class="row text-center">
	  <div style="float:none; margin:0 auto">
		<ul class="pagination">
			<c:if test="${pageMaker.prev}">
				<li class="page-item"><a class="page-link" href="list${pageMaker.makeSearch(pageMaker.startPage -1)}">&laquo;</a></li>
			</c:if>
			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				<li class="<c:out value="${pageMaker.cri.page == idx ? 'page-item active':''}"/>">
					<a class="page-link" href="list${pageMaker.makeSearch(idx)}">${idx}</a></li>
			</c:forEach>
			
			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				<li class="page-item"><a class="page-link" href="list${pageMaker.makeSearch(pageMaker.endPage +1)}">&raquo;</a></li>
			</c:if>
		</ul>
	  </div>
	</div>

</body>
</html>