<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<html>
	<head>
		<meta charset="utf-8">
		<title>Welcome</title>
<script type="text/javascript">
$(document).ready(function(){
	$("#boardtable tr #modify").click(function(){ 
		console.log("click4");
		var td1 = "";
		var td2 = "";
		$(this).parent().parent().find("td").each(function(i, item){ 
			if (i == 1) {
				$(item).hide();
				$(item).next().show();
				td1 = $(item).text();
			}
			if (i == 3) {
				td3 = $(item).text();	
				$(item).hide();
				$(item).next().show();
			}
			if (i == 5) {
				td5 = $(item).text();	
				$(item).hide();
				$(item).next().show();
			}
			if (i == 7) {
				td5 = $(item).text();	
				$(item).hide();
				$(item).next().show();
			}
		});

	});
});
</script>

<script type="text/javascript">
$(document).ready(function(){
	$("#boardtable tr #modifyCommit").click(function(){ 
		var td1 = "";
		var td2 = "";
		$(this).parent().parent().find("td").each(function(i, item){ 
			if (i == 2) {
				valBoardName = $(item).children().val();
			}
			if (i == 4) {
				valBoardUrl = $(item).children().val();
			}
			if (i == 6) {
				valBoardOrder = $(item).children().val();
			}

			if (i == 9) {
				valId = $(item).text();	
			}
		});
		
		 $.ajax({
			type:'put',
			url:'/admin/modify',
			headers:{
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override":"PUT"
				},
			dataType:'text',
			data:JSON.stringify({id:valId, boardName:valBoardName, boardUrl:valBoardUrl, boardOrder:valBoardOrder}),
			success:function(result){
				if(result == 'SUCCESS'){
					location.reload();
				}	
			}});
	});
});
</script>

		
	</head> 
	
	
	<body><div class="list-group">

	</div>
		<form action="boardcreate" method="post">
		
		<c:forEach items="${boardlist}" var="list">
		 </c:forEach>
		  <div class="form-group">
		    <label for="email">게시판 이름:</label>
		    <input type="text" class="form-control" placeholder="추가할 이름을 입력해주세요" id="text" name="boardName">
		    <label for="email">DB명:</label>
		    <input type="text" class="form-control" placeholder="추가할 URL 입력해주세요" id="text" name="boardUrl">
   		    <label for="email">순서:</label>
		    <input type="text" class="form-control" value="0" id="text" name="boardOrder">
		    
		  </div>
		  <button type="submit" class="btn btn-primary">Submit</button>
		 
		</form>
		
		
		<div class="container">
			<table class="table table-striped" id="boardtable">
				<thead>
					<tr>
						<th style="width: 5%">#</th>
						<th style="width: 20%">게시판명</th>
						<th style="width: 20%">DB명</th>
						<th style="width: 20%">게시판순서</th>
						<th style="width: 10%">기능</th>
						<th style="width: 10%">삭제</th>
					</tr>
				</thead>
				<tbody>
				<c:set var="var" value="1"/>
				<c:forEach items="${boardlist}" var="list">
				<c:set var="num" value="1"/>
					<tr>
						<td></td>
						<td>${list.boardName}</td>
						<td style="display: none" id="boardName"><input type="text" value="${list.boardName}"></td>
						<td>${list.boardUrl}</td>	
						<td style="display: none" id="boardUrl"><input type="text" value="${list.boardUrl}"></td>
						<td>${list.boardOrder}</td>
						<td style="display: none" id="boardOrder"><input type="text" value="${list.boardOrder}"></td>
						<td><a id="modify" class="btn btn-warning">수정 </a></td>
						<td style="display: none" id="boardModify"><a id="modifyCommit" class="btn btn-success">수정완료 </a></td>
						<td style="display: none" id="boardId">${list.id}</td>
						<td><a href="/admin/boardRemove?id=${list.id}" class="btn btn-danger"> 삭제</a></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		
		</div>
		
	</body>
</html>
