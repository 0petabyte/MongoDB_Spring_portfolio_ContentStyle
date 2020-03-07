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
<title>쪽지보내기</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>


<script>
$(function(){
    $( "#autocomplete" ).autocomplete({
        source : function( request, response ) {
             $.ajax({
                    type: 'get',
                    url: "/messages/searchId",
                    dataType: "json",
                    //request.term = $("#autocomplete").val()

                    success: function(data) {
                    	
                        var datamap = data.list.map(function(i) {
                            return {
                              label: i.uname + '(' + i.uid + ')',
                              value: i.uid,
                              desc: i.name
                            }
                          });
                          
                          var key = request.term;
                          
                          datamap = datamap.filter(function(i) {
                            return i.label.toLowerCase().indexOf(key.toLowerCase()) >= 0;
                          });
                    	
                    	console.log(data.list);
                        //서버에서 json 데이터 response 후 목록에 뿌려주기 위함
                        response(datamap);
                    }
               });
            },
        //조회를 위한 최소글자수
        minLength: 2,
        delay: 100,
        select: function( event, ui ) {
        	
            $("#testauto").val(ui.item.label);
            $("#testremove").hide();
            $("#showremove").show();
            $("#testauto").addClass(ui.item.value);

            // 만약 검색리스트에서 선택하였을때 선택한 데이터에 의한 이벤트발생
        }
    });
})


</script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#messageSendBtn").on("click",function(){
		var messageVal = $("#messageBox");
		var sendMessage = messageVal.val();
		var sendNameParse = $("#autocomplete");
		var sendName = sendNameParse.val();
		var userId = "${login.uid}";
		console.log(sendMessage);
		console.log(sendName);
		console.log(userId);

		$.ajax({
			type:'post',
			url:'/messages/',
			headers:{
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override":"POST"
				},
			dataType:'text',
			data:JSON.stringify({targetid:sendName, sender:userId, message:sendMessage}),
			success:function(result){
				if(result == 'SUCCESS'){
				messageVal.val("");
				sendNameParse.val("");
	            $("#testremove").show();
	            $("#showremove").hide();
	            alert("등록 되었습니다.");
				
				}	
			}});
		});
});
</script>

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

  <div class="list-group-item"> <div id="testremove"><label>받는이: </label> <input id="autocomplete"></div> <div id="showremove" style="display: none"><label>받는이 : </label><input id="testauto" readonly="readonly" style="background-color: gray;"></div></div></div>
  <br>           

<textarea rows="20" style="width: 100%" id="messageBox"></textarea>
<button type="submit" class="btn btn-primary" id="messageSendBtn">메세지 전송</button>



</body>
</html>
