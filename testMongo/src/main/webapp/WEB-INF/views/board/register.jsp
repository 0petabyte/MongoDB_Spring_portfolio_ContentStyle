<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
	<head>
		<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
		<title>Welcome</title>
		
				<!-- include libraries(jQuery, bootstrap) -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
   
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote-lite.min.css" rel="stylesheet">
    <script type="text/javascript" src="/js/upload.js"></script>
    <script type="text/javascript" src="/js/summernote_upload.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote-lite.min.js"></script>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
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
		<style type="text/css">
		.fileDrop{
		width: 100%;
		height: 100px;
		border: 1px dotted gray;
		background-color: #585858;
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
		<script id="template" type="text/x-handlebars-template">
		<li class="list-group-item imgList" data-src='{{fullName}}'>
			<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment">
			<div class="mailbox-attachment-info">
			<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
			<a href="{{fullName}}" class="btn btn-default btn-xs pull-right delbtn">
			<button id='test' data-src='{{fullName}}'>delete</button></a>
			</div>
		</li>
		</script>
		
		
	</head> 
	<body>
<form role="form" method="post" style="width: 90%;margin: 0 auto;" class="was-validated" id="registerForm">
  <div class="form-group">
  	<select class="form-control" name="board">
		<c:forEach items="${boardlist}" var="boardlist">
		 <c:if test="${boardlist.boardUrl == cri.board}">
			<c:set var="boardname" value="${boardlist.boardName}" ></c:set>
		 <option selected disabled hidden value="${boardlist.boardUrl}">${boardlist.boardName}</option>
		
		 </c:if>
		 <option value="${boardlist.boardUrl}">${boardlist.boardName}</option>
		 
		</c:forEach>
	</select>
	<input type="hidden" name="boardName" value="${boardname}">
    <label for="mainSearch">제목:</label>
    <input type="text" name="title" class="form-control" placeholder="제목" required>
    <label for="writer">글쓴이:</label>
    <input type="text" name="writer" class="form-control" value="${login.uname}" readonly="readonly">
    <input type="hidden" name="writerId" value="${login.uid}">
  </div>
  
  <div class="form-group">
    <label for="subSearch">내용:</label>
  </div>
  <textarea name="content" id="summernote"></textarea>
  
  <div class="form-group">

  	<input type="file" class="form-control-file border" id="inputBtn">

  	
  	<label for="fileDrop"></label>
  	<div class="fileDrop"><p style="color: white">업로드하실 파일을 상단 텍스트 박스 또는 이곳에 드래그 해주세요.</p></div> 
  </div>
  <br>
  <div class="box-footer">
  	<div>
  		<hr>
  	</div>
	<div class="form-group uploadTest">
  	<ul class="list-group list-group-horizontal uploadedList">
  	</ul>
</div>
  </div>
  <br>
<p style="text-align: center;">
  <button type="submit" class="btn btn-primary">글쓰기</button>
</p>
</form>

<script type="text/javascript">
		
$(function() {
	var template = Handlebars.compile($("#template").html());
			$("input:file").change(function(event){
				event.preventDefault();
				var file = $("#inputBtn")[0].files[0];
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
			
});
</script>


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
		
		<script type="text/javascript">
		$("#registerForm").submit(function(event){
			event.preventDefault();
			
			var that = $(this);
			
			var str="";

			
			$(".uploadedList .delbtn").each(function(index){
				str += "<input type='hidden' name='files["+index+"]' value='"+$(this).attr("href")+"'>";
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
				$.ajax({
					url:"/deleteFile",
					type:"post",
					data:{fileName:$(this).attr("data-src")},
					
					dataType:"text",
					success:function(result){
						if(result == 'deleted'){
							that.parent("a").parent("div").parent("span").parent("li").remove();
							
						}
					}
				});
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
		
	</body>
</html>
