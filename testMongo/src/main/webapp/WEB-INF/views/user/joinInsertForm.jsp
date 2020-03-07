<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html lang="ko">
<head>
<meta charset="UTF-8" name="viewport"
	content="width=device-width, initial-scale=1">
<title>Welcome</title>
<link rel="stylesheet" type="text/css" href="/css/join.css" />
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function sample4_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var roadAddr = data.roadAddress; // 도로명 주소 변수
						var extraRoadAddr = ''; // 추가 정보 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample4_postcode').value = data.zonecode;
						document.getElementById("sample4_roadAddress").value = roadAddr;
						document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

						// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
						if (roadAddr !== '') {
							document.getElementById("sample4_extraAddress").value = extraRoadAddr;
						} else {
							document.getElementById("sample4_extraAddress").value = '';
						}

						var guideTextBox = document.getElementById("guide");
						// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						if (data.autoRoadAddress) {
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							guideTextBox.innerHTML = '(예상 도로명 주소 : '
									+ expRoadAddr + ')';
							guideTextBox.style.display = 'block';

						} else if (data.autoJibunAddress) {
							var expJibunAddr = data.autoJibunAddress;
							guideTextBox.innerHTML = '(예상 지번 주소 : '
									+ expJibunAddr + ')';
							guideTextBox.style.display = 'block';
						} else {
							guideTextBox.innerHTML = '';
							guideTextBox.style.display = 'none';
						}
					}
				}).open();
	}
</script>






<!--  <button id="test_btn">테스트 버튼</button> -->
<script type="text/javascript">
$(document).ready(function() {
	var formObj = $("form[role='form']");
    $("#test_btn").click(function() {
        $.ajax({
            url: '/VerifyRecaptcha',
            type: 'post',
            data: {
                recaptcha: $("#g-recaptcha-response").val()
            },
            success: function(data) {
                switch (data) {
                    case 0:
                        alert("자동 가입 방지 봇 통과");
                        var idchk = $("#idchk").css("color");
                        var pwchk = $("#pwchk").css("color");
                        var pwchk2 = $("#pwchk2").css("color");
                        var nickchk = $("#nickchk").css("color");
                        if(idchk == "rgb(0, 128, 0)" && pwchk == "rgb(0, 128, 0)" && pwchk2 == "rgb(0, 128, 0)"&& nickchk == "rgb(0, 128, 0)"){
                    		formObj.attr("method","post");
                    		formObj.attr("action","joininsert");
                    		formObj.submit();
                    		alert("가입이 완료되었습니다.")
                        }else if(idchk != "rgb(0, 128, 0)"){
                        	alert("아이디 중복확인을 해주세요.")
                        }else if(pwchk != "rgb(0, 128, 0)" || pwchk2 != "rgb(0, 128, 0)" ){
                        	alert("비밀번호가 조건에 맞지 않습니다.")
                        }else if(nickchk != "rgb(0, 128, 0)"){
                        	alert("닉네임 중복확인을 해주세요.")
                        }else{
                        	alert("필요한 정보의 누락입니다.")
                        }

                        break;

                    case 1:
                        alert("자동 가입 방지 봇을 확인 한뒤 진행 해 주세요.");
                        break;

                    default:
                        alert("자동 가입 방지 봇을 실행 하던 중 오류가 발생 했습니다. [Error bot Code : " + Number(data) + "]");
                        break;
                }
            }
        });
    });
});

</script>

<script type="text/javascript">
$(document).ready(function() {
    $("#joinIdBtn").click(function() {
    	if($("#joinId").val().length < 1){
    		alert("아이디를 입력해주세요.")
    	}else{
        $.ajax({
            url: 'joinId',
            type: 'post',
            data: {
                id: $("#joinId").val()
            },
            success: function(data) {
            	if(data == true){
                	if(confirm("사용가능한 아이디 입니다 사용 하시겠습니까?"))
            		{
                		$('#joinId').attr("readonly",true).attr("disabled",false).css("background-color","gray");
                		$('#idchk').css("color","green");
            		}
            	}else{
            		alert("이미 사용중인 아이디 입니다.")
            	}
            }
        });
    	}
    });
});

</script>

<script type="text/javascript">
$(document).ready(function() {
    $("#joinUnameBtn").click(function() {
    	if($("#joinUname").val().length < 1){
    		alert("닉네임을 입력해주세요.")
    	}else{
    	
        $.ajax({
            url: 'joinUname',
            type: 'post',
            data: {
                uname: $("#joinUname").val()
            },
            success: function(data) {

            	if(data == true){
                	if(confirm("사용가능한 닉네임 입니다 사용 하시겠습니까?"))
            		{
                		$('#joinUname').attr("readonly",true).attr("disabled",false).css("background-color","gray");
                		$("#nickchk").css("color","green");
            		}
            	}else{
            		alert("이미 사용중인 아이디 입니다.")
            	}
            }
        });
    	}
    });
});

</script>
<script type="text/javascript">
	function passcheck(){
 var password = $("#password").val();
 var checkpassword = $("#checkpassword").val();
 if(password.length < 6 || password.length > 16){
	 document.getElementById('pass').innerHTML = "비밀번호는 6글자이상 16글자 미만이여야 합니다."
	 $("#pass").css("color","red");
 }else{
	 document.getElementById('pass').innerHTML = "사용가능한 비밀번호입니다."
	 $("#pass").css("color","blue");
 }
 if(password == checkpassword){
	 document.getElementById('passchk').innerHTML = "비밀번호가 일치합니다."
	 	
		 $("#passchk").css("color","blue");
	 $("#pwchk").css("color","green");
	 $("#pwchk2").css("color","green");
 }else{
	 document.getElementById('passchk').innerHTML = "비밀번호가 일치하지 않습니다."
		 $("#passchk").css("color","red");
 }
	};
</script>
</head>
<body>
	<div class="container" style="width: 100%;" >
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link" href="join">이용약관</a></li>
			<li class="nav-item"><a class="nav-link" href="#">본인인증</a></li>
			<li class="nav-item"><a class="nav-link active"
				href="joininsert">기본정보입력</a></li>

		</ul>
		<br>
	

	<div class="conTitles backgroundNon">
		<h5 id="headLine">회원가입</h5>
		<p>회원에 가입하시면 더욱 다양한 서비스를 이용하실 수 있습니다.</p>
	</div>
	<!-- //join_info -->
	<form role="form" action="join" method="post">
	
		<table class="table" style="margin: auto;">

		<tr>
			<th><span id="idchk">아이디(*):</span></th>
			<td><input type="text" id="joinId" name="uid" placeholder="아이디를 입력하세요"></td>
			<td><button type="button" id="joinIdBtn">중복확인</button></td>
		</tr>
		<tr>
		<td colspan="3"><span>특수문자를 제외한 4자~10자 이내로 입력하세요.</span></td>
		</tr>
		<tr>
			<th><span id="pwchk">비밀번호(*):</span></th>
			<td colspan="3"><input type="password" class="mb-2 mr-sm-2" id="password"  onchange="passcheck()" placeholder="비밀번호를 입력하세요"></td>
			
		</tr>
		<tr>
		<td colspan="3"><span id="pass" style="color: red"></span></td>
		</tr>
		
		<tr>
			<th><span id="pwchk2">비밀번호확인(*):</span></th>
			<td colspan="3"><input type="password" class="mb-2 mr-sm-2" id="checkpassword" name="upw" onchange="passcheck()" placeholder="비밀번호를 입력하세요"></td>
		</tr>
		<tr>
		<td colspan="3"><span id="passchk" style="color: red"></span></td>
		</tr>
		

		
		<tr>
			<th><span id="nickchk">닉네임(*):</span></th>
			<td><input type="text" id="joinUname" name="uname" placeholder="닉네임을 입력하세요"></td>
			<td><button type="button" id="joinUnameBtn">중복확인</button></td>
		</tr>
		<tr>
			<th>이메일:</th>
			<td><input type="email" class="mb-2 mr-sm-2" name="email"></td>
			<td colspan="2">
				<select>
					<option>@daum.net</option>
					<option>@naver.com</option>
					<option>@google.com</option>
					<option selected="selected">직접입력</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>주소:</th>
			<td>
				<input type="text" id="sample4_postcode" class="d_form mini mb-2 mr-sm-2" placeholder="우편번호" readonly="readonly"></td>
				<td><input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="d_btn">
			</td>
		</tr>
		<tr>
			<th></th>
			<td colspan="2"><input style="width: 100%" type="text" id="sample4_roadAddress" class="d_form std" placeholder="도로명주소" readonly="readonly"></td>
		</tr>
		<tr>
			<th></th>
			<td colspan="2"><input style="width: 100%" type="text" id="sample4_jibunAddress" class="d_form std" placeholder="지번주소" readonly="readonly"></td>
		</tr>
		<tr>
			<th></th>
			<td colspan="2"><span id="guide" style="color: #999; display: none"></span><input style="width: 100%" type="text" id="sample4_extraAddress" class="d_form" placeholder="참고항목"  readonly="readonly"></td>
			
		</tr>
		<tr>
			<th></th>
			<td colspan="2"><input style="width: 100%" type="text" name="address" id="sample4_detailAddress" class="d_form" placeholder="상세주소"></td>
		</tr>

		<tr>
			<th></th>
			<td colspan="2"><div class="g-recaptcha" data-sitekey="6Lfg09cUAAAAAI4NB6j340pg1fvp-roGhQ_AgWXk"></div></td>
		</tr>

		</table>

		<div style="text-align: center;">
			<button type="button" id="test_btn" class="btn btn-primary">가입신청</button>
			<br>
			<br>
		</div>




	
	</form>
</div>

</body>
</html>
