<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
	<head>
		<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
		<title>Welcome</title>
		<link rel="stylesheet" type="text/css" href="/css/mainPage.css?ver=27">
		<link rel="stylesheet" type="text/css" href="/css/slick/slick-theme.css">
		<link rel="stylesheet" type="text/css" href="/css/slick/slick.css">
		<link rel="stylesheet" type="text/css" href="/css/slick/slick_setting.css">
		<script type="text/javascript" src="/js/slick/slick.min.js"></script>
		<script type="text/javascript" src="/js/slick/slick.js"></script>
		
	</head> 
	<body>
    <div id="container">
    
    	<div class="headerBoard" id="board0">
    	<div id="demo" class="carousel slide" data-ride="carousel">

  <!-- Indicators -->
  <ul class="carousel-indicators">
    <li data-target="#demo" data-slide-to="0" class="active"></li>
    <li data-target="#demo" data-slide-to="1"></li>
    <li data-target="#demo" data-slide-to="2"></li>
  </ul>
  
  <!-- The slideshow -->
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="/img/la.jpg" alt="Los Angeles" width="100%" height="250">
    </div>
    <div class="carousel-item">
      <img src="/img/chicago.jpg" alt="Chicago" width="100%" height="250">
    </div>
    <div class="carousel-item">
      <img src="/img/ny.jpg" alt="New York" width="100%" height="250">
    </div>
  </div>
  
  <!-- Left and right controls -->
  <a class="carousel-control-prev" href="#demo" data-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </a>
  <a class="carousel-control-next" href="#demo" data-slide="next">
    <span class="carousel-control-next-icon"></span>
  </a>
</div>
    	
    	</div>
      	<div class="topBoard" id="boardTop1">
            <div class="content" id="content1">
                <div class="setTitle"><a href="/board/list?board=${dto.board}">${boardList[0].boardName}</a></div>
                <ul class="title">
                	<c:forEach items="${list}" var="dto">
                	<c:if test="${dto.board == boardList[0].boardUrl}">
                	 <li class="title"><a class="title" href="/board/read?id=${dto.id}&board=${dto.board}">${dto.title}</a></li>
                	</c:if>
					</c:forEach>
                </ul>
            </div>
        </div>
        
   		<div class="footerBoard" id="board4">
   		<div id="imgTitle">이미지 갤러리</div>
		<div class="slider autoplay">
		<c:forEach items="${picList}" var="picList">
		<c:set var="picUrl" value="${fn:replace(picList.files[0], '/s_', '/')}" />
			<div class="imgBoard">
				<img src="/displayFile?fileName=${picUrl}">
				<div><a class="title" href="/board/read?id=${picList.id}&board=${picList.board}">${picList.title}</a></div>
			</div>
		</c:forEach>
			</div>
		</div>
        
    	
        <div class="board" id="board1">
            <div class="content" id="content1">
                <div class="setTitle"><a href="/board/list?board=${dto.board}">${boardList[1].boardName}</a></div>
                <ul class="title">
                	<c:forEach items="${list}" var="dto">
                	<c:if test="${dto.board == boardList[1].boardUrl}">
                	 <li class="title"><a class="title" href="/board/read?id=${dto.id}&board=${dto.board}">${dto.title}</a></li>
                	</c:if>
					</c:forEach>
                </ul>
            </div>
            <div class="content" id="content2">
                <div class="setTitle"><a href="/board/list?board=${dto.board}">${boardList[2].boardName}</a></div>
                <ul class="title">
                	<c:forEach items="${list}" var="dto">
                	<c:if test="${dto.board == boardList[2].boardUrl}">
                	 <li class="title"><a class="title" href="/board/read?id=${dto.id}&board=${dto.board}">${dto.title}</a></li>
                	</c:if>
					</c:forEach>
                </ul>
            </div>
            <div class="content" id="content3">
                <div class="setTitle"><a href="/board/list?board=${dto.board}">${boardList[3].boardName}</a></div>
                <ul class="title">
                	<c:forEach items="${list}" var="dto">
                	<c:if test="${dto.board == boardList[3].boardUrl}">
                	 <li class="title"><a class="title" href="/board/read?id=${dto.id}&board=${dto.board}">${dto.title}</a></li>
                	</c:if>
					</c:forEach>
                </ul>
            </div>
        </div>
        <div class="board" id="board2">
            <div class="content" id="content4">
                <div class="setTitle"><a href="/board/list?board=${dto.board}">${boardList[4].boardName}</a></div>
                <ul class="title">
                	<c:forEach items="${list}" var="dto">
                	<c:if test="${dto.board == boardList[4].boardUrl}">
                	 <li class="title"><a class="title" href="/board/read?id=${dto.id}&board=${dto.board}">${dto.title}</a></li>
                	</c:if>
					</c:forEach>
                </ul>
            </div>
            <div class="content" id="content5">
            <div class="setTitle"><a href="/board/list?board=${dto.board}">${boardList[5].boardName}</a></div>
                <ul class="title">
                	<c:forEach items="${list}" var="dto">
                	<c:if test="${dto.board == boardList[5].boardUrl}">
                	 <li class="title"><a class="title" href="/board/read?id=${dto.id}&board=${dto.board}">${dto.title}</a></li>
                	</c:if>
					</c:forEach>
                </ul>
            </div>
            <div class="content" id="content6">
            <div class="setTitle"><a href="/board/list?board=${dto.board}">${boardList[6].boardName}</a></div>
                <ul class="title">
                	<c:forEach items="${list}" var="dto">
                	<c:if test="${dto.board == boardList[6].boardUrl}">
                	 <li class="title"><a class="title" href="/board/read?id=${dto.id}&board=${dto.board}">${dto.title}</a></li>
                	</c:if>
					</c:forEach>
                </ul>
            </div>
        </div>
        <div class="board" id="board3">
            <div class="content" id="content7">
                <div class="setTitle"><a href="/board/list?board=${dto.board}">${boardList[7].boardName}</a></div>
                <ul class="title">
                	<c:forEach items="${list}" var="dto">
                	<c:if test="${dto.board == boardList[7].boardUrl}">
                	 <li class="title"><a class="title" href="/board/read?id=${dto.id}&board=${dto.board}">${dto.title}</a></li>
                	</c:if>
					</c:forEach>
                </ul>
            </div>
            <div class="content" id="content8">
            <div class="setTitle"><a href="/board/list?board=${dto.board}">${boardList[8].boardName}</a></div>
                <ul class="title">
                	<c:forEach items="${list}" var="dto">
                	<c:if test="${dto.board == boardList[8].boardUrl}">
                	 <li class="title"><a class="title" href="/board/read?id=${dto.id}&board=${dto.board}">${dto.title}</a></li>
                	</c:if>
					</c:forEach>
                </ul>
            </div>
            <div class="content" id="content9">
            <div class="setTitle"><a href="/board/list?board=${dto.board}">${boardList[9].boardName}</a></div>
                <ul class="title">
                	<c:forEach items="${list}" var="dto">
                	<c:if test="${dto.board == boardList[9].boardUrl}">
                	 <li class="title"><a class="title" href="/board/read?id=${dto.id}&board=${dto.board}">${dto.title}</a></li>
                	</c:if>
					</c:forEach>
                </ul>
            </div>
        </div>


		<script type="text/javascript">
		var x = window.matchMedia("(max-width: 700px)")
		 if (x.matches) {
				$('.autoplay').slick({
					  slidesToShow: 1,
					  slidesToScroll: 1,
					  autoplay: true,
					  autoplaySpeed: 2000,
					});
			  } else {
					$('.autoplay').slick({
						  slidesToShow: 3,
						  slidesToScroll: 1,
						  autoplay: true,
						  autoplaySpeed: 2000,
						});
			  }
		

		
		</script>

		
    </div>
    
    
    
	</body>
</html>
