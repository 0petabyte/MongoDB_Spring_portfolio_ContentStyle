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
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote-lite.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote-lite.min.js"></script>

<title>Welcome</title>
<script type="text/javascript">
$(document).ready(function() {
     $('#summernote').summernote({
             height: 500,                 // set editor height
             minHeight: null,             // set minimum height of editor
             maxHeight: null,             // set maximum height of editor
             focus: true                  // set focus to editable area after initializing summernote
     });
});

</script>
  
<script type="text/javascript">
$(document).ready(function(){
	var formObj = $("form[role='form']");
	$(".goListBtn").on("click", function(){
		formObj.attr("method","get");
		formObj.attr("action","list");
		formObj.submit();
	});
	$(".removeBtn").on("click",function(){
		self.location="/img/list?page=${cri.page}&perPageNum=${cri.perPageNum}"
				+ "&searchType=${cri.searchType}&keyword=${cri.keyword}";
		formObj.attr("action","remove");
		formObj.submit();
	});
	$(".modifyBtn").on("click",function(){
		formObj.attr("action","modify");
		formObj.attr("method","post");
		formObj.submit();
	})
});
</script>

</head>
<body>

<form role="form" method="post" style="width: 90%;margin: 0 auto;" action="modify">
	<label style="font-size: 20px;color: red;">수정하기</label>
  <div class="form-group">
    <label for="mainSearch">제목:</label>
    <input type="text" name="title" class="form-control" placeholder="메인검색어" value="${imgDTO.title}">
  </div>
  <div class="form-group">
    <label for="subSearch">내용:</label>
   
  </div>
  <textarea name="content" id="summernote">${imgDTO.content}</textarea>
	<input type="hidden" name="id" value="${imgDTO.id}">
  
</form>
<br>
  <p style="text-align: center;">
  	<button type="submit" class="btn btn-success goListBtn">목록으로</button>
  	<button type="submit" class="btn btn-primary modifyBtn">수정완료</button>
  	<button type="submit" class="btn btn-danger removeBtn">삭제</button>
  </p>



</body>
</html>

