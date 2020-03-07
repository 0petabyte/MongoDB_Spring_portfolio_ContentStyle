<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
	<head>
		<meta charset="utf-8">
		<title>Welcome</title>
		
				<!-- include libraries(jQuery, bootstrap) -->

    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote-lite.min.js"></script>
		<meta charset="utf-8">
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
	</head> 
	<body>
<form role="form" method="post" style="width: 90%;margin: 0 auto;" class="was-validated">
  <div class="form-group">
    <label for="mainSearch">제목:</label>
    <input type="text" name="title" class="form-control" placeholder="제목" required>
    <label for="writer">글쓴이:</label>
    <input type="text" name="writer" class="form-control" placeholder="글쓴이" required>
  </div>
  
  <div class="form-group">
    <label for="subSearch">내용:</label>
  </div>
  <textarea name="content" id="summernote"></textarea>
  <br>
<p style="text-align: center;">
  <button type="submit" class="btn btn-primary">글쓰기</button>
</p>
</form>
	</body>
</html>
