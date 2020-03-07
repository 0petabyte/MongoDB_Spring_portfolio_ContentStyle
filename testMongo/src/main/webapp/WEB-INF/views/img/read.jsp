<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 자바 프로그램을 태그로 사용하도록 정의-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--숫자나 통화, 날짜 같은 형태 맞춰주기 위하여 정의-->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/css/codePage.css" />
<script type="text/javascript">
$(document).ready(function(){
	var formObj = $("form[role='form']");
	$(".goListBtn").on("click", function(){
		formObj.attr("method","get");
		formObj.attr("action","list");
		formObj.submit();
	});
	$(".removeBtn").on("click",function(){
		formObj.attr("method","get");
		formObj.attr("action","remove");
		formObj.submit();
	});
	$(".modifyBtn").on("click",function(){
		self.location="/img/list?page=${cri.page}&perPageNum=${cri.perPageNum}"
			+ "&searchType=${cri.searchType}&keyword=${cri.keyword}";
		formObj.attr("method","get");
		formObj.attr("action","modify");
		formObj.submit();
	})
});
</script>

</head>
<body>
<br>
<div class="container">
<form role="form" method="post" class="was-validated" action="modify">
	<div class="form-group">
		
		<div class="contentView">
		<p class="titleView">${imgDTO.title}</p>
		<p class="titleTime"><a href ="list?groupnum=${imgDTO.id}" class="titleGroup">테스트</a> <fmt:formatDate value="${imgDTO.dateTime}" pattern="yyyy.MM.dd HH:mm:ss" /><span class="contentWriter">${imgDTO.id}</span></p>
		
		<hr>
		<p class="contentViewer">
		${imgDTO.content}
		</p>
		<input type="hidden" name="id" value="${imgDTO.id}">
     	<input type="hidden" name="page" value="${cri.page}">
  		<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
  		<input type="hidden" name="searchType" value="${cri.searchType}">
  		<input type="hidden" name="keyword" value="${cri.keyword}">
		</div>
	</div>
	</form>
  <div>
  	<button type="submit" class="btn btn-success goListBtn">목록</button>
  	<button type="submit" class="btn btn-primary modifyBtn">수정</button>
  	<button type="submit" class="btn btn-danger removeBtn">삭제</button>
  </div>

</div>

</body>
</html>

