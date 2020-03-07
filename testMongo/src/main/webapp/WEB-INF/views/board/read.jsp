<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/css/codePage.css" />
<link rel="stylesheet" type="text/css" href="/css/popup.css" />
<link rel="stylesheet" type="text/css" href="/css/reply.css" />
<script type="text/javascript" src="/js/upload.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var formObj = $("form[role='form']");
	$(".goListBtn").on("click", function(){
		formObj.attr("method","get");
		formObj.attr("action","list?board={cri.board}");
		formObj.submit();
	});
	$(".removeBtn").on("click",function(){
		var arr=[];
		$(".uploadedList li").each(function(index){
			arr.push($(this).attr("data-src"));
		})
		if(arr.length > 0){
			$.post("/deleteAllFiles",{files:arr},function(){
			});
		}
		formObj.attr("action","remove");
		formObj.submit();
		
	});
	$(".modifyBtn").on("click",function(){
		formObj.attr("method","get");
		formObj.attr("action","modify");
		formObj.submit();
	})
});
</script>


<script type="text/javascript">
Handlebars.registerHelper("prettifyDate", function(timeValue){
	var dateObj = new Date(timeValue);
	var year = dateObj.getFullYear();
	var month = dateObj.getMonth() + 1;
	var date = dateObj.getDate();
	var hour = dateObj.getHours();
	var minute = dateObj.getMinutes();
	var second = dateObj.getSeconds();
	return year+"/"+month+"/"+date+" "+hour+":"+minute+":"+second;
	});
var printData = function(replyArr, target, templateObject){

	var template = Handlebars.compile(templateObject.html());

	var html = template(replyArr);

	$(".replyLi").remove();
	
	$(".replyLiText").remove();

	target.after(html);

	}
</script>
<script type="text/javascript">
var bno = '${boardDTO.id}';
var replyPage = 1;
function getPage(pageInfo){
	$.getJSON(pageInfo, function(data){
		var reCnt = data.pageMaker.totalCount;
		printData(data.list, $("#repliesDiv"), $('#template'));
		printPaging(data.pageMaker, $(".pagination"));
		document.getElementById("reCnt").innerHTML = reCnt;
		document.getElementById("reTitleCnt").innerHTML = reCnt;
		
		
		});
	}

var printPaging = function(pageMaker, target){
	var str="";

	if(pageMaker.prev){
		str+= "<li class='page-item'><a class='page-link' href ='" + (pageMaker.startPage-1)+"'> << </a></li>";
			}
		for(var i=pageMaker.startPage, len=pageMaker.endPage;i<= len;i++){
			
			var strClass=pageMaker.cri.page == i?"class='page-item active'":'';
			str += "<li "+strClass+"><a class='page-link' href='"+i+"'>"+i+"</a></li>"
			}

		if(pageMaker.next){
			str += "<li class='page-item'><a class='page-link' href='"+(pageMaker.endPage +1)+"'> >> </a></li>";
			}
	

	target.html(str);
	
	}
</script>
<script type="text/javascript">
getPage("/replies/"+bno+"/1");
</script>
<!-- <script type="text/javascript">
$(document).ready(function(){
$("#repliesDiv").on("click", function(){

	getPage("/replies/"+bno+"/1");
	});
});
</script> -->
<script type="text/javascript">
$(document).ready(function(){
$(".pagination").on("click", "li a", function(event){
	event.preventDefault();
	replyPage = $(this).attr("href");
	getPage("/replies/"+bno+"/"+replyPage);
	});
});
</script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#replyAddBtn").on("click",function(){
		var replyerObj = $("#newReplyWriter");
		var replytextObj = $("#newReplyText");
		var replyer = replyerObj.val();
		var replytext = replytextObj.val();

		$.ajax({
			type:'post',
			url:'/replies',
			headers:{
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override":"POST"
				},
			dataType:'text',
			data:JSON.stringify({rno:bno, replyer:replyer, replytext:replytext}),
			success:function(result){
				if(result == 'SUCCESS'){
				//alert("등록 되었습니다.");
				replyPage=1;
				
				getPage("/replies/"+bno+"/"+replyPage);
				
				replytextObj.val("");
				}	
			}});
		});
});
</script>
<script type="text/javascript">
$(document).ready(function(){
	$(".timeline").on("click",".replyLi", function(event){
		var reply=$(this);
		var replyText=window.document.getElementById("replyText").innerHTML;
		$("#replytext").val(reply.find('.timeline-body').text());
		$("#replyer").val(reply.find('.timeline-plyer').text());
		$(".modal-title").html(reply.attr("data-rno"));
		});
	});
</script>
<script type="text/javascript">
$(document).ready(function(){
	$("#replyModBtn").on("click",function(){
		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();
		$.ajax({
			type:'put',
			url:'/replies/'+rno,
			headers:{
				"Content-Type":"application/json",
				"X-HTTP-Method-Ovrride":"PUT"
				},
			data:JSON.stringify({replytext:replytext}),
			dataType:'text',
			success:function(result){
				if(result=="SUCCESS"){
					$('#modDiv').modal("hide");
					getPage("/replies/"+bno+"/"+replyPage);
					}
				}
			});
		});
	});
</script>	


<script type="text/javascript">
$(document).ready(function(){
	$("#replyDelBtn").on("click",function(){
		
		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();

		$.ajax({
			type:'delete',
			url:'/replies/'+rno,
			headers:{
				"Content-Type":"application/json",
				"X-HTTP-Method-Override":"DELETE"
				},
			dataType:'text',
			success:function(result){
				
				if(result == "SUCCESS"){
					
					$('#modDiv').modal("hide");
					getPage("/replies/"+bno+"/"+replyPage);
					}
				}
			});
		});
	});
</script>
<script type="text/javascript">
Handlebars.registerHelper("eqReplyer",function(replyer, block){
	var accum = '';
if(replyer =='${login.uname}'){
	accum += block.fn();
}
return accum;
});

</script>


<script id="template" type="text/x-handlebars-template" >
		{{#each .}}
 <li class="replyLiText list-group-item list-group-item-primary" data-rno={{id}}>
<div class="row" style="height:20px;">
  <div class="col-7 timeline-plyer"><h5>{{replyer}} 님</h5></div>
  
  <div class="col-5 timeline-time" style="text-align:right;"><span class="time badge badge-primary badge-pill">{{prettifyDate regdate}}</span></div>
</div>

<li class="list-group-item list-group-item-light replyLi" data-rno={{id}}>
<div class="row">

  <div class="timeline-plyer" style="display:none;">{{replyer}}</div>
  <div class="col-9 timeline-body" id="replyText" style="white-space:pre-wrap;">{{replytext}}</div>
{{#eqReplyer replyer}}
  <div class="col-3" style="text-align:right;"><a data-toggle="modal" data-target="#modDiv" class="btn btn-light btn-sm" id="test">수정</a></div>
{{/eqReplyer}}  
</div>
</li>


</li>



		{{/each}}
</script>


<script id="templateAttach" type="text/x-handlebars-template">
<li class="list-group-item imgList" style="text-align:center;" data-src='{{fullName}}'>
	<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment">
	<div class="mailbox-attachment-info">
	<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
	</span>
	</div>
</li>
</script>

<%-- <c:set var="imglen" value="${fn:length(boardDTO.files)}" />

<c:forEach items="${boardDTO.files}" var="img"  varStatus="status">
imgList.push("${img}");
</c:forEach>

<script type="text/javascript">

	var imgLen = ${imglen};
	console.log(imgLen);
	var imgList = new Array();
	for (var i=0; i<imgLen;i++){
		console.log(String(i));
		var cnt = parseInt(i);
		var test = "${boardDTO.files[i]}"
		console.log(test);
		console.log("${boardDTO.files[i]}");
	}
	console.log(imgList);
	
</script> --%>



<style type="text/css">
.uploadImg{
  display: flex;
  align-content: flex-start;
  flex-direction: column;
  flex-wrap: wrap;
  overflow: auto;
}
</style>
</head>

<body>
<br>
<div class="popup back" style="display:none;"></div>
<div id="popup_front" class="popup front" style="display:none;">
<img id="popup_img">
</div>

<div class="container">
<form role="form" method="post" class="was-validated" action="modify">
	<div class="form-group">
		
		<div class="contentView">
		<div class="alert alert-success">
		  <strong>${boardDTO.boardName} 게시판</strong>
		</div>
		
		<div class="form-inline">

		<p class="titleView">${boardDTO.title} </p>  <p> [</p><p class="bg-green" id="reTitleCnt"></p><p> ]</p> </div>

		<p class="titleTime"><a href ="list?groupnum=${boardDTO.id}" class="titleGroup"> ${boardDTO.writer}</a> <span class="contentWriter"><fmt:formatDate value="${boardDTO.dateTime}" pattern="yyyy.MM.dd HH:mm:ss" /></span></p>

		<hr>
		<div class="contentViewer">

		${boardDTO.content}

</div>
		<%-- <c:out value="${fn:length(boardDTO.files)}" /> --%>

		<input type="hidden" name="id" value="${boardDTO.id}">
     	<input type="hidden" name="page" value="${cri.page}">
  		<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
  		<input type="hidden" name="searchType" value="${cri.searchType}">
  		<input type="hidden" name="keyword" value="${cri.keyword}">
  		<input type="hidden" name="board" value="${cri.board}">
		</div>
	</div>
	</form>

	<div class="form-group uploadImg">
	<ul class="list-group list-group-horizontal uploadedList"></ul>
	
	<script>
		var template = Handlebars.compile($("#templateAttach").html());
		<c:forEach items="${boardDTO.files}" var="img">
		var imgSrc = '${img}';
		var fileInfo = getFileInfo(imgSrc);
		var html = template(fileInfo);
		$(".uploadedList").append(html);
		</c:forEach>
	</script>
		
<script type="text/javascript">
$(".uploadedList").on("click", ".mailbox-attachment-info a",function(event){
	var fileLink = $(this).attr("href");
	
	if(checkImageType(fileLink)){
		event.preventDefault();
		
        var link = fileLink;
        var img=new Image();
        img.src = link;
        var imgWidth=img.width;
        if (imgWidth == null || imgWidth == 0){
        	imgWidth = 500;
        }

        var imgHeight=img.height;
        
        if (imgHeight == null || imgHeight == 0){
        	imgHeight = 500;
        }
        
        if (img.width == null || img.width == 0){
        	img.width = 500;
        }
        if (img.height == null || img.height == 0){
        	img.height = 500;
        }
        var popWidth=img.width+30;
        var popHeight=img.height+30;
        
        var OpenWindow=window.open('','_blank', 'width='+popWidth+', height='+popHeight+', menubars=no, scrollbars=auto' );
        OpenWindow.document.write("<img src='"+link+"' width='"+imgWidth+"' height='"+imgHeight+"' style='padding:0;margin:0;'>");
		
/* 		
		
		
		
		var imgTag = $("#popup_img");
		imgTag.attr("src",fileLink); */
		
		$(".popup").show('slow');
		imgTag.addClass("show");
	}
});
$("#popup_img").on("click",function(){
	$(".popup").hide('slow');
})

</script>


<!-- The Modal -->
<div id="myModal" class="modal">
  <span class="close">&times;</span>
  <img class="modal-content" id="img01">
  <div id="caption"></div>
</div>


<script>
// Get the modal
var modal = document.getElementById("myModal");

// Get the image and insert it inside the modal - use its "alt" text as a caption
var img = document.getElementById("myImg");
var modalImg = document.getElementById("img01");
var captionText = document.getElementById("caption");
img.onclick = function(){
  modal.style.display = "block";
  modalImg.src = this.src;
  captionText.innerHTML = this.alt;
}

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks on <span> (x), close the modal
span.onclick = function() { 
  modal.style.display = "none";
}
</script>



	</div>
  <div>

  	<button type="submit" class="btn btn-success goListBtn">목록</button>
  	<c:if test="${login.uname == boardDTO.writer}">
  	<button type="submit" class="btn btn-primary modifyBtn">수정</button>
  	<button type="submit" class="btn btn-danger removeBtn">삭제</button>
  	</c:if>
  	

  </div>

</div>

<c:if test="${not empty login}">
<div class="row" id="replyComent">
	<div class="col-md-12">
		<div class="box box-success">
			<div class="box-header">
				<h3 class="box-title"><br></h3>
			</div>
			<div class="box-body">
			
					<input class="form-control" type="text" value="${login.uname}" id="newReplyWriter"  readonly="readonly">
				
					<textarea class="form-control" placeholder="댓글을 입력하세요" style="height:200px;" id="newReplyText"></textarea>
				
			</div>
			
			<!-- /.box body -->
			<div class="box-footer" style="text-align:center;">
				<br><button type="submit" class="btn btn-primary" id="replyAddBtn">ADD REPLY</button>
			</div>
		</div>
	</div>
</div>
</c:if>

<c:if test="${empty login}">
<div style="text-align: center;"><p>로그인하지 않은 사용자는 댓글을 입력할수 없습니다.</p> <a href="/user/login?board=${cri.board}">로그인</a></div>
</c:if>

<br>
<!-- The time Line -->
<ul class="timeline list-group" id="replyStyle">
	<!-- timeLinetile label -->
	<li class="time-label list-group-item" id="repliesDiv">댓글 [<span class="bg-green" id="reCnt">
	</span>]</li>
</ul>


	
	<br><ul id="pagination" class="pagination pagination-sm no-margin" style="justify-content: center;">
	</ul>




<!-- Modal -->
<div class="modal fade" id="modDiv" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel" style="display:none;"></h5>
        <input type="text" id='replyer' readonly="readonly" style="text-align: center;border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;focus {outline:none;}"> 님의 글입니다.
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          
       
       <br>
       <textarea id='replytext' style="width: 100%;height: 300px;"></textarea>

      </div>
      <div class="modal-footer">
				<button class="btn btn-success" type="button" id="replyModBtn">Modify</button>
				<button class="btn btn-danger" type="button" id="replyDelBtn">DELETE</button>
				<button class="btn btn-secondary" type="button" data-dismiss="modal" id="closeBtn">Close</button>
      </div>
    </div>
  </div>
</div>



<!-- 


The Modal
<div class="modal" id="modDiv">
  <div class="modal-dialog">
    <div class="modal-content">

      Modal Header
      <div class="modal-header">
        <h4 class="modal-title"></h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      Modal body
      <div class="modal-body">
       <input type="text" id='replyer' readonly="readonly">
       <input type="text" id='replytext'>
      </div>

      Modal footer
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
    	<button type="button" id="replyModBtn">Modify</button>
		<button type="button" id="replyDelBtn">DELETE</button>
			
      </div>

    </div>
  </div>
</div>

 -->

		<!-- <div id="modDiv" style="display: none;">
			<div class="modal-title"></div>
			<div>
				
				<input type="text" id='replytext'>
			</div>
			<div>
				<button type="button" id="replyModBtn">Modify</button>
				<button type="button" id="replyDelBtn">DELETE</button>
				<button type="button" id="closeBtn">Close</button>
			</div>
		</div> -->



</body>
</html>

