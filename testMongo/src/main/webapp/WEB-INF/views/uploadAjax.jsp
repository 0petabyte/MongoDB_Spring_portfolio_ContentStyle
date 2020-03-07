<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
	<head>
		<meta charset="utf-8">
		<title>Welcome</title>
		<style type="text/css">
			.fileDrop{
				width:100%;
				height: 200px;
				border:1px dotted blue;
			}
			
			small{
				margin-left: 3px;
				font-weight: bold;
				color:gray;
			}
		</style>
		
		<script type="text/javascript">
			function checkImageType(fileName){
				var pattern = /jpg$|gif$|png$|jpeg$/i;
				
				return fileName.match(pattern);
			}
		</script>
		
		<script type="text/javascript">
			function getOriginalName(fileName){
				if(checkImageType(fileName)){
					return;
				}
				var idx = fileName.indexOf("_") +1;
				return fileName.substr(idx);
			}
		</script>
		<script type="text/javascript">
		function getImageLink(fileName){
			if(!checkImageType(fileName)){
				return;
			}
			
			var front = fileName.substr(0,12);
			var end = fileName.substr(14);
			
			return front + end;
		}
		</script>

	</head> 
	<body>
		<h3>Ajax File Upload</h3>
		<div class="fileDrop"></div>
		<div class="uploadedList"></div>
		
		
		<script type="text/javascript">
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
						
						var str="";
						
						console.log(data);
						console.log(checkImageType(data));
						console.log(getOriginalName(data));
						if(checkImageType(data)){
							str = "<div>"
								+"<a href='displayFile?fileName="+getImageLink(data)+"'>"
								+"<img src='displayFile?fileName="+data+"'/>"
								+"</a><button id='test' data-src='"+data+"'>delete</button></div>";
						}else{
							str = "<div><a href='displayFile?fileName="+data+"'>"
									+getOriginalName(data)+"</a>"
									+"<button id='test' data-src='"+data+"'>delete</button></div>"
						}
						
						$(".uploadedList").append(str);
					}
				});
			});
		</script>
		
				<script type="text/javascript">
			$(".uploadedList").on("click","#test",function(event){
				var that = $(this);
				console.log(event);
				$.ajax({
					url:"deleteFile",
					type:"post",
					data:{fileName:$(this).attr("data-src")},
					
					dataType:"text",
					success:function(result){
						if(result == 'deleted'){
							that.parent("div").remove();
							
						}
					}
				});
			});
			
		</script>
	</body>
</html>
