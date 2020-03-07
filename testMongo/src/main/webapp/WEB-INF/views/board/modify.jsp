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

  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote-lite.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote-lite.min.js"></script>
  <script type="text/javascript" src="/js/upload.js"></script>
  <script type="text/javascript" src="/js/summernote_upload.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<title>Welcome</title>
<script type="text/javascript">
glo_var = new Array(); 
</script>

<script type="text/javascript">
$(document).ready(function() {
     $('#summernote').summernote({
             height: 500,                 // set editor height
             minHeight: null,             // set minimum height of editor
             maxHeight: null,             // set maximum height of editor
             focus: true,                  // set focus to editable area after initializing summernote        
             callbacks: {
                 onImageUpload: function(files, editor, welEditable) {
                   for (var i = files.length - 1; i >= 0; i--) {
                     sendFile(files[i], this);
                   }
                 },
                 onMediaDelete : function(index) {
                	 
                	 var text = index[0]['src'];
                	 var text1 = text.split("=")
                	 var front = text1[1].substr(0,12);
                	 var end = 's_'+text1[1].substr(12);
                	 glo_var.push(front+end);

                     delFile(front+end);

                    
                }
             }
     });
});

</script>


<script type="text/javascript">
   function sendFile(file, el) {
       var form_data = new FormData();
       form_data.append('file', file);
       $.ajax({
         data: form_data,
         type: "POST",
         url: '/uploadAjax',
         cache: false,
         contentType: false,
         enctype: 'multipart/form-data',
         processData: false,
         success: function(data) {
       	  var imgsrc = summernote_getFileInfo(data);
			var fileInfo = getFileInfo(data);
			
			var html = template(fileInfo);
			$(".uploadedList").append(html);
           $(el).summernote('editor.insertImage', imgsrc);
           $('#imageBoard > ul').append('<li><img src="'+imgsrc+'" width="480" height="auto"/></li>');
         }
       });
     }
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
		formObj.attr("action","modify");
		formObj.attr("method","post");
		formObj.submit();
	})
});
</script>
<script id="template" type="text/x-handlebars-template">
<li class="list-group-item imgList">
	<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment">
	<div class="mailbox-attachment-info">
	<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
	<a href="{{fullName}}" class="btn btn-default btn-xs pull-right delbtn">
	<button id='test' data-src='{{fullName}}'>delete</button></a>
	</div>
</li>
</script>



<script id="templateAttach" type="text/x-handlebars-template">
<li class="list-group-item imgList" style="text-align:center;" data-src='{{fullName}}'>
	<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment">
	<div class="mailbox-attachment-info">
	<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a><br>
	<a id='test' class="btn btn-danger" data-src='{{fullName}}'>Delete</a>
	</span>
	</div>
</li>
</script>
<style type="text/css">
.fileDrop{
width: 80%;
height: 100px;
border: 1px dotted gray;
background-color: lime;
margin:auto;
}
.uploadTest{
white-space: nowrap;
width: 100%;
overflow:scroll;
overflow-x: auto;
overflow-y:hidden;

}

</style>
</head>
<body>

<form role="form" method="post" style="width: 90%;margin: 0 auto;" action="modify" id="registerForm">
	<label style="font-size: 20px;color: red;">수정하기</label>
  <div class="form-group">
    <label for="mainSearch">제목:</label>
    <input type="text" name="title" class="form-control" placeholder="메인검색어" value="${boardDTO.title}">
  </div>
  <div class="form-group">
    <label for="subSearch">내용:</label>
   
  </div>
  <textarea name="content" id="summernote">${boardDTO.content}</textarea>
  
  <div class="form-group">
  	<label for="fileDrop">File Drop Hear</label>
  	<div class="fileDrop"></div> 
  </div>
  
	<input type="hidden" name="id" value="${boardDTO.id}">
    <input type="hidden" name="page" value="${cri.page}">
	<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
	<input type="hidden" name="searchType" value="${cri.searchType}">
	<input type="hidden" name="keyword" value="${cri.keyword}">
	
	<div class="form-group uploadImg">
	<ul class="list-group list-group-horizontal uploadedList"></ul>
	</div>
	
</form>


<script type="text/javascript">
		
	var template = Handlebars.compile($("#template").html());
	
	$(".fileDrop").on("dragenter dragover", function(event){
		event.preventDefault();
	});
	
	$(".fileDrop").on("drop", function(event){
		event.preventDefault();
		
		var files=event.originalEvent.dataTransfer.files;
		
		var file = files[0];
		//console.log(file);
		
		var formData = new FormData();
		formData.append("file",file);
		
		$.ajax({
			url:'/uploadAjax',
			data:formData,
			dataType:'text',
			processData:false,
			contentType:false,
			type:'POST',
			success:function(data){
				
				var fileInfo = getFileInfo(data);
				
				var html = template(fileInfo);
				
				$(".uploadedList").append(html);
	
	
				
			}
		});
	});
</script>

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
		$("#registerForm").submit(function(event){
			event.preventDefault();
			var that = $(this);
			var str="";
			
			$(".note-editable").on("img",function(){
				alert("ㅜㅜ");
			});
			
			$(".uploadedList #test").each(function(index){
				str += "<input type='hidden' name='files["+index+"]' value='"+$(this).attr("data-src")+"'>";
			});
			
			
			for(var i = 0 ; i<glo_var.length ; i++){
				
				$.ajax({
					url:"/deleteFile",
					type:"post",
					data:{fileName:glo_var[i]},
					dataType:"text"
				});

			    };


			that.append(str);
			that.get(0).submit();
		});
		</script>
	
	<script type="text/javascript">
			$(".uploadedList").on("click","#test",function(event){
				var that = $(this);
				glo_var.push($(this).attr("data-src"));
				console.log(glo_var);
				that.parent("div").parent("span").parent("li").remove();
				});
	
			
	</script>

<script type="text/javascript">
//유니코드 문제로 앞의 무작위 생성된 이름이 같으면 li 목록에서도 삭제하도록 함. 최종적 hidden files 값에서 제거됨.
	function delFile(fileName){
		$(".uploadedList").find("li").each(function(index){
			var test2 = $(this).attr('data-src');
			if (fileName.substr(15,25) == test2.substr(15,25)){
				$(this).remove();
			}
			console.log(test);
		});
	}
</script>

<br>
  <p style="text-align: center;">
  	<button type="submit" class="btn btn-success goListBtn">목록으로</button>
  	<button type="submit" class="btn btn-primary modifyBtn">수정완료</button>
  	<button class="btn btn-danger removeBtn">삭제</button>
  </p>



</body>
</html>

