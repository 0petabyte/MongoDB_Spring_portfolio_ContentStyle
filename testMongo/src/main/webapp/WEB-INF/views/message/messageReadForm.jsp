<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<meta charset="utf-8">
<title>Welcome</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<body>



<div class="container">
<br>

  <h4 style="text-align: center;">${login.uname}님의 쪽지함</h4>
<br>

  <div class="list-group list-group-horizontal" style="text-align: center;">
  <a href="/messagelist?uid=${login.uid}&searchType=t" class="list-group-item list-group-item-primary list-group-item-action">받은 쪽지함</a>
<a href="/messagelist?uid=${login.uid}&searchType=s" class="list-group-item list-group-item-primary list-group-item-action">보낸 쪽지함</a>
<a href="/messagelist/send" class="list-group-item list-group-item-primary list-group-item-action">쪽지쓰기</a>

  </div>
<br>

  <div class="list-group-item">총 ${messageSize} 개의 쪽지가 있습니다.</div>
  <br>           
<div class="container mt-3">

  <div class="media border p-3">
    <img src="/img/img_avatar3.png" alt="John Doe" class="mr-3 mt-3 rounded-circle" style="width:60px;">
    <div class="media-body">
      <h4>${list.senderName} <small><i><fmt:formatDate pattern="yyyy.MM.dd HH:mm" value="${list.senddate}" /></i></small></h4>
      <p>${list.message}</p>      
    </div>
  </div>
</div>



</body>
</html>
