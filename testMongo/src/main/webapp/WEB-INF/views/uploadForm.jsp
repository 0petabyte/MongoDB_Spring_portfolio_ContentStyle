<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
	<head>
		<meta charset="utf-8">
		<title>Welcome</title>
		<style type="text/css">
		iframe{
			width: 0px;
			height: 0px;
			border: 0px;
		}
		</style>
	</head> 
	<body>
		<form id="form1" action="uploadForm" method="post" enctype="multipart/form-data" target="zeroFrame">
			<input type="file" name="file"><input type="submit">
		</form>
		
		<iframe name="zeroFrame"></iframe>
		
		<script type="text/javascript">
			function addFilePath(msg){
				alert(msg);
				document.getElementById("form1").reset();
			}
		</script>
	</body>
</html>
