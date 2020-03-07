<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
	<head>
		<meta charset="utf-8">
		<title>Welcome</title>
		<script type="text/javascript">
		
		</script>
		<script type="text/javascript">
		function getAllList(){
		$(document).ready(function(){
			var rno = "5e243b3a493466cd648256cc";
			$.getJSON("/replies/5e243b3a493466cd648256cc/1",function(data){
				
				var str="";
				console.log("첫번째"+data.length);
				
				$(data).each(function(){
					str += "<li replyid='"+this.id+"' class='replyLi'>"
					+this.replyer + ":" + this.replytext
					+ "<button>MOD</button></li>";
				});
				
				$("#replies").html(str);
			});
		});
		};
		</script>
		
		
		
<script type="text/javascript">
		function getPageList(page){
			var textId = "5e243b3a493466cd648256cc";

			$.getJSON("/replies/"+textId+"/"+page,function(data){
				console.log(data.list.length);
			
			var str="";
			
			
			$(data.list).each(function(){
				str += "<li replyid='"+this.id+"' class='replyLi'>"
				+this.replyer + ":" + this.replytext
				+ "<button>MOD</button></li>";
			});
			
			$("#replies").html(str);
			
			printPaging(data.pageMaker);
			});
		
		}
		
		</script>
		
		<script>
		function printPaging(pageMaker){
			var str= "";
			
			if(pageMaker.prev){
			str+= "<li class='page-item'><a class='page-link' href ='" + (pageMaker.startPage-1)+"'> << </a></li>";
				}
			for(var i=pageMaker.startPage, len=pageMaker.endPage;i<= len;i++){
				
				var strClass=pageMaker.cri.page == i?"class='page-item active'":'';
				str += "<li "+strClass+"><a class='page-link' href='"+i+"'>"+i+"</a></li>"
				}

			if(pageMaker.next){
				str += "<li class='page-item active'><a class='page-link' href='"+(pageMaker.endPage +1)+"'> >> </a></li>";
				}
			$('.pagination').html(str);
			}
		</script>
		
		<script>
		$(document).ready(function(){
		var replyPage = 1;
		$(".pagination").on("click", "li a", function(event){
			event.preventDefault();
			replyPage = $(this).attr("href");
			getPageList(replyPage);
			})
		})
		</script>
		
		<script type="text/javascript">
	
		
		getPageList(1);
		
		</script>
		
		
		<script type="text/javascript">
		$(document).ready(function(){
		$("#replyAddBtn").on("click",function(){
			
			var replyer = $("#newReplyWriter").val();
			var replytext = $("#newReplyText").val();
			var rno = "5e243b3a493466cd648256cc";
			$.ajax({
				type:'post',
				url:'/replies',
				headers:{
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override":"POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					rno:rno,
					replyer : replyer,
					replytext : replytext
				}),
				success:function(result){
					if(result == 'SUCCESS'){
						alert('등록되었습니다.');
						getAllList();
					}
				}
			});
		});
		});
		</script>
		
		<script type="text/javascript">
		$(document).ready(function(){
		$("#replies").on("click",".replyLi button", function(){
			var reply = $(this).parent();
			
			var rno = reply.attr("replyid");
			var replytext = reply.text();
			
			$(".modal-title").html(rno);
			
			$("#replytext").val(replytext);
			$("#modDiv").show("slow");
			
		});
		});
		</script>
		
		<script type="text/javascript">
		$(document).ready(function(){
		$('#replyDelBtn').on("click",function(){
			var rno = $(".modal-title").html();
			var replytext = $("#replytext").val();
			
			$.ajax({
				type : 'delete',
				url : '/replies/'+rno,
				headers:{
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override":"DELETE"
				},
				dataType : 'text',
				success : function(result){
					console.log("result:" + result);
					if(result == 'SUCCESS'){
						alert("삭제 되었습니다.");
						$("#modDiv").hide("slow");
						getAllList();
					}
				}
			});
		});
		});
		</script>
		
		<script type="text/javascript">
		$(document).ready(function(){
			$("#replyModBtn").on("click",function(){
			var rno =$(".modal-title").html();
			var replytext = $("#replytext").val();
			alert(replytext);
			$.ajax({
				type:'put',
				url:'/replies/'+rno,
				headers:{
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override":"PUT"
				},
				data:JSON.stringify({replytext:replytext}),
				dataType:'text',
				success:function(result){
					console.log("result:"+result);
					if(result == 'SUCCESS'){
						alert("수정되었습니다.");
						$("#modDiv").hide("slow");
						getPageList(replyPage);
					}
				}});
			});
		});
		</script>
		
		
		<style type="text/css">
		#modDiv{
			width:300px;
			height: 100px;
			background-color: gray;
			position: absolute;
			top: 50%;
			left: 50%;
			margin-top: -50px;
			margin-left: -150px;
			padding: 10px;
			z-index: 1000;
		}
		</style>
	</head> 
	<body>
		<div>
			<div>
				REPLYER <input type="text" name="replyer" id="newReplyWriter">
			</div>
			<div>
				REPLY TEXT <input type="text" name="replytext" id="newReplyText">
			</div>
			<button id="replyAddBtn">ADD REPLY</button>
		</div>
	
		<div id="modDiv" style="display: none;">
			<div class="modal-title"></div>
			<div>
				
				<input type="text" id='replytext'>
			</div>
			<div>
				<button type="button" id="replyModBtn">Modify</button>
				<button type="button" id="replyDelBtn">DELETE</button>
				<button type="button" id="closeBtn">Close</button>
			</div>
		</div>
		<ul id="replies">
		
		</ul>
		<ul class="pagination">
		</ul>
	</body>
</html>
