<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
	<head>
		<meta charset="utf-8">
		<title>Welcome</title>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	</head> 
	<body>
		<!-- 
		<div id="displayDiv">
		
		</div>
	
		<script id="template" type="text/x-handlebars-template">
			<span style="color:red"> {{name}} </span>
			<div>
				<span> {{userid}}</span>
				<span> {{addr}}</span>
			</div>
		</script>
		<script type="text/javascript">
		var source = $("#template").html();
		var template = Handlebars.compile(source);
		var data = {name:"홍길동", userid:"user00", addr:"조선 한양"};
		
		$("#displayDiv").html(template(data));
		</script> -->
		
<!-- 		<script type="text/javascript">
			var source = "<h1><p>{{name}}</p> <p>{{userid}}</p> <p>{addr}}</p></h1>";
			var template = Handlebars.compile(source);
			var data = {name:"홍길동", userid:"user00", addr:"조선 한양"};
			
			$("#displayDiv").html(template(data));
		</script> -->
		
		<ul id="repliese">
		
		</ul>
		
		<script id="template" type="text/x-handlebars-template">
			{{#each .}}
			<li class="replyLi">
				<div>{{rno}}</div>
				<div>{{replytext}}</div>
				<div>{{replydate}}</div>
			</li>
			{{/each}}
		</script>
		<script type="text/javascript">
			var source = $("#template").html();
			var template = Handlebars.compile(source);
			var data = [
				{rno:1, replytext:'1번 댓글...', replydate:new Date()},
				{rno:2, replytext:'1번 댓글...', replydate:new Date()},
				{rno:3, replytext:'1번 댓글...', replydate:new Date()},
				{rno:4, replytext:'1번 댓글...', replydate:new Date()},
				{rno:5, replytext:'1번 댓글...', replydate:new Date()}
			];
			$("#repliese").html(template(data));
		</script>
		
		<script type="text/javascript">
		$(document).ready(function(){
			var ele = document.getElementById('repliese');
			console.log(ele.childElementCount);
			
		

		});
		</script>
	</body>
</html>
