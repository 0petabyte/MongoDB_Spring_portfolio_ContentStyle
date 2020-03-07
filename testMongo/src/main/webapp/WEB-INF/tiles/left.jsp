<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="list-group">

<a href="/board/list" class="list-group-item list-group-item-action list-group-item-secondary">모든 게시판</a>



<c:forEach items="${boardlist}" var="dto">
<c:choose>
<c:when test="${dto.boardUrl == cri.board}">
<a href="/board/list?board=${dto.boardUrl}" class="list-group-item list-group-item-action list-group-item-primary">${dto.boardName}</a>
</c:when>
<c:otherwise>
<a href="/board/list?board=${dto.boardUrl}" class="list-group-item list-group-item-action list-group-item-light">${dto.boardName}</a>
</c:otherwise>
</c:choose>

</c:forEach>
	<c:if test="${login.uname == 'Admin'}">
	<a href="/admin/boardPage" class="list-group-item list-group-item-action list-group-item-info">관리자</a>
	</c:if>
</div>