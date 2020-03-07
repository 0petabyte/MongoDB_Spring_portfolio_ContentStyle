<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
	<head>
		<meta charset="utf-8">
		<title>Welcome</title>
		
    <script>
        function popup(){
            var url = "/messagelist?uid=${login.uid}&searchType=t";
            var name = "popup test";
            var option = "width = 500, height = 800, top = 100, left = 200, location = no"
            window.open(url, name, option);
        }
    </script>
   	<script type="text/javascript">
	   $(function(){
	        $("#joinBtn").click(function(){
	           location.href = '/user/join';
	        });
	    });
	</script>
    
	</head> 
	<body>

	<c:if test="${!empty login}">
	  <div class="card" style="width:200px">
    <img class="card-img-top" src="/img/img_avatar1.png" alt="Card image" style="width:100%">
    <div class="card-body">
      <h4 class="card-title">${login.uname} <br>님 반갑습니다.</h4>
      <p>보유포인트 : ${login.point}</p>
      <div class="list-group">
  <a href="#" onclick="popup();" class="list-group-item list-group-item-action list-group-item-success"><img src="/img/mail.png" style="max-width: 20px" ></img> 메세지함</a>
  <a href="#" class="list-group-item list-group-item-action list-group-item-info"><i class="fas fa-file"></i>회원정보 수정</a>
</div>
<br>
<div style="text-align: center;">
      <a href="/user/logout" class="btn btn-secondary">로그아웃</a>
      </div>
    </div>
  </div>
	
	
	
	
	</c:if>
	<c:if test="${null eq login}">
	  <form action="/user/loginPost" class="needs-validation" novalidate method="post">
    <div class="form-group">
      <label for="uname">Username:</label>
      <input type="text" class="form-control" id="uname" placeholder="User ID" name="uid" required>
      <div class="valid-feedback">Valid.</div>
      <div class="invalid-feedback">Please fill out this field.</div>
    </div>
    <div class="form-group">
      <label for="pwd">Password:</label>
      <input type="password" class="form-control" id="pwd" placeholder="User password" name="upw" required>
      <div class="valid-feedback">Valid.</div>
      <div class="invalid-feedback">Please fill out this field.</div>
    </div>
    <div class="form-group form-check">
      <label class="form-check-label">
        <input class="form-check-input" type="checkbox" name="useCookie" required> Rememver Me
      </label>
    </div>
    <button type="submit" class="btn btn-primary">로그인</button>
    <button type="button" id="joinBtn" class="btn btn-success">회원가입</button>
  </form>
	</c:if>
		
	</body>
</html>
