<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	$(document).ready(
		function(){
			$('#allSearchBtn').on("click",function(event){
				self.location = "list"
				+ '${pageMaker.makeQuery(1)}'
				+ '&searchType=tc'
				+ "&keyword=" + encodeURIComponent($('#mainKey').val())
				+ "&board=${cri.board}";
			});

		});

</script>


<style>
.navbar{
    background: #848484;
}

.dropdown{
    border-radius:0;
    border:0;
}
.dropdown-menu{
    background: #848484;
    border:0;
    top:80%;
    border-radius:0px 0px 5px 5px;
}
.dropdown-item:hover{
    background:#A4A4A4;
    color:#fff;
}
.dropdown-menu a{
    color:#fff;
} 

</style>


<style>



@media (min-width: 768px){
.mobileMenu{
display: none;
}
	}
	
</style>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top navbar-light">
  <a class="navbar-brand" href="/"><img src="/img/jiung_logo.png" width="80px;"></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">

<%--     <c:choose>
		<c:when test="${cri.board == null}">
		<li class="nav-item active">
			<a href="/board/list" class="nav-link">모든 게시판</a>
		</li>
		</c:when>
		<c:otherwise>
		<li class="nav-item">
			<a href="/board/list" class="nav-link">모든 게시판</a>
			
		</li>
		</c:otherwise>
	</c:choose> --%>
     <li class="nav-item dropdown dmenu">
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        커뮤니티 게시판
      </a>
				<div class="dropdown-menu sm-menu">
					<c:forEach items="${boardlist}" var="dto">
						<c:choose>
							<c:when test="${dto.boardUrl == cri.board}">
								<a href="/board/list?board=${dto.boardUrl}"
									class="dropdown-item active">${dto.boardName} 
									<span class="sr-only">(current)</span></a>
							</c:when>
							<c:otherwise>
								<a href="/board/list?board=${dto.boardUrl}"
									class="dropdown-item">${dto.boardName} <span
									class="sr-only">(current)</span></a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
			</li>
    


			<c:forEach items="${boardlist}" var="dto">
				<c:choose>
					<c:when test="${dto.boardUrl == cri.board}">
						<li class="nav-item active mobileMenu">
						<a href="/board/list?board=${dto.boardUrl}"
							class="nav-link">${dto.boardName} <span class="sr-only">(current)</span></a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="nav-item mobileMenu">
						<a href="/board/list?board=${dto.boardUrl}"
							class="nav-link">${dto.boardName} <span class="sr-only">(current)</span></a>
						</li>
					</c:otherwise>
				</c:choose>

			</c:forEach>

		<li class="nav-item">
    		<a href="/coin/listAll" class="nav-link">비트코인</a>
    	</li>

    </ul>
    <div class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" name="keyword" placeholder="Search" aria-label="Search" id="mainKey">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit" id="allSearchBtn">Search</button>
    </div>
  </div>
</nav>

<script type="text/javascript">
$(document).ready(function () {
	$('.navbar-light .dmenu').hover(function () {
	        $(this).find('.sm-menu').first().stop(true, true).slideDown(150);
	    }, function () {
	        $(this).find('.sm-menu').first().stop(true, true).slideUp(105)
	    });
	});
</script>