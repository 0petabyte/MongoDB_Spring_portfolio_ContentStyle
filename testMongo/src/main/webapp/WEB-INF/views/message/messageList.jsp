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
  <table class="table table-bordered table-hover">
    <thead>
      <tr>
        <th width="30%" style="text-align: center;">내용</th>
        
        <c:choose>
        	<c:when test="${type== 't'}">
        		<th width="20%">보낸사람</th>
        	</c:when>
        	<c:otherwise>
        		<th width="20%">받는사람</th>
        	</c:otherwise>
        </c:choose>

        <th width="20%">보낸시간</th>
        <th width="20%">읽은시간</th>
      </tr>
    </thead>
    <tbody style="font-size: 14px;">
   <c:if test="${login.uid == sendId}">
    <c:forEach items="${messagelist}" var="list">
      <tr>
      	<c:choose>
			<c:when test="${list.message.length() > 10 }">
				<td id="title"><a href="/messagelist/read?id=${list.id}&uid=${sendId}">${fn:substring(list.message,0,8) }...</a></td>
			</c:when>
			<c:otherwise>
				<td id="title"><a href="/messagelist/read?id=${list.id}&uid=${sendId}">${list.message}</a></td>
			</c:otherwise>
		</c:choose>
        <c:choose>
        	<c:when test="${type== 't'}">
        		<td>${list.senderName}</td>
        	</c:when>
        	<c:otherwise>
        		<td>${list.targetName}</td>
        	</c:otherwise>
        </c:choose>
		
        
        <td><fmt:formatDate pattern="yyyy.MM.dd " value="${list.senddate}" /></td>
      	<c:choose>
			<c:when test="${list.opendate != null }">
				<td><fmt:formatDate pattern="yyyy.MM.dd " value="${list.opendate}" /></td>
			</c:when>
			<c:otherwise>
				<td>읽지않음.</td>
			</c:otherwise>
		</c:choose>
		
		
      </tr>
    </c:forEach>
    

    
   </c:if>
    </tbody>
  </table>
  
  
</div>

	<div class="row text-center">
	  <div style="float:none; margin:0 auto">
		<ul class="pagination">
			<c:if test="${pageMaker.prev}">
				<li class="page-item"><a class="page-link" href="messagelist${pageMaker.makeSearch(pageMaker.startPage -1)}&uid=${sendId}">&laquo;</a></li>
			</c:if>
			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				<li class="<c:out value="${pageMaker.cri.page == idx ? 'page-item active':''}"/>">
					<a class="page-link" href="messagelist${pageMaker.makeSearch(idx)}&uid=${sendId}">${idx}</a></li>
			</c:forEach>
			
			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				<li class="page-item"><a class="page-link" href="messagelist${pageMaker.makeSearch(pageMaker.endPage +1)}&uid=${sendId}">&raquo;</a></li>
			</c:if>
		</ul>
	  </div>
	</div>


</body>
</html>
