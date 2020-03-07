<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
	<head>
		<link>
		<meta charset="UTF-8?ver=1" name="viewport" content="width=device-width, initial-scale=1">
		<title>Welcome</title>
		<style type="text/css">
		.sticky-header th { position: sticky; top: 60px; left:0;}
		.sticky-header2 th{ position: sticky; top: 107px; left:0;}
		@media (max-width: 768px){
		.test{
		width: 100%; height: 100%;
		
		}
		.test{
		height: 3000px;
		overflow-x: auto; 
		}
		.sticky-header th { position: sticky; top: 0px; left:0; }
		.sticky-header2 th{ position: sticky; top: 42px; left:0;}
		</style>
	</head> 
	<body>

<div class="container"> 
  <div class="alert alert-success">
    <strong>안내:</strong> 이벤트는 매일 0시 / 합계는 오전 9시 30분 기준으로 업데이트 됩니다.2
  </div>


<!-- <div class="table-responsive"></div> -->
<div class="test">
  <table class="table table-striped" style="text-align: center;">
    <thead>
      <tr class="sticky-header">
        <th rowspan="2" style="background-color: white; vertical-align: middle">코인명<br>매수량기준<a href="?sort=asktotal"><img src="/img/arrow.svg" width="20px"></a></th>
        <th rowspan="2" style="background-color: white; vertical-align: middle">거래소</th>
        <th colspan="2" style="background-color: #F5A9D0;">7일<a href="?sort=total_7day"><img src="/img/arrow.svg" width="20px"></a></th>
        <th colspan="2" style="background-color: #CED8F6">14일<a href="?sort=total_14day"><img src="/img/arrow.svg" width="20px"></a></th>
        <th colspan="2" style="background-color: #F2F5A9">30일<a href="?sort=total_30day"><img src="/img/arrow.svg" width="20px"></a></th>
        <th rowspan="2" style="background-color: white; vertical-align: middle">이벤트내용</th>
        <th rowspan="2" style="background-color: white; vertical-align: middle">이벤트<br>날짜<a href="?sort=eventday"><img src="/img/arrow.svg" width="20px"></a></th>
      </tr>
    
      <tr class="sticky-header2">
        <th style="background-color: #F5A9D0">합계</th>
        <th style="background-color: #F5A9D0">상승률</th>
        <th style="background-color: #CED8F6">합계</th>
        <th style="background-color: #CED8F6">상승률</th>
        <th style="background-color: #F2F5A9">합계</th>
        <th style="background-color: #F2F5A9">상승률</th>

      </tr>

    </thead>
    <tbody>

      <c:forEach items="${AllList}" var="dto"> 
        <tr>
        	<td><a href="/coin/list?coin=${dto.coinname}">${dto.coinname}</a></td>
        	<td>${dto.exchange}</td>
        	<td><fmt:formatNumber value="${dto.total_7day}" pattern="#,###" /></td>
        	<c:choose>
        		<c:when test="${dto.rate_7day > 0}">
        			<td><fmt:formatNumber value="${dto.rate_7day}" pattern="0.00" />%</td>
        		</c:when>
	        	<c:otherwise>
	        		<td style="color: red;"><fmt:formatNumber value="${dto.rate_7day}" pattern="0.00" />%</td>
	        	</c:otherwise>
            </c:choose>
        	<td><fmt:formatNumber value="${dto.total_14day}" pattern="#,###" /></td>
        	<c:choose>
        		<c:when test="${dto.rate_14day > 0}">
        			<td><fmt:formatNumber value="${dto.rate_14day}" pattern="0.00" />%</td>
        		</c:when>
	        	<c:otherwise>
	        		<td style="color: red;"><fmt:formatNumber value="${dto.rate_14day}" pattern="0.00" />%</td>
	        	</c:otherwise>
            </c:choose>
        	<td><fmt:formatNumber value="${dto.total_30day}" pattern="#,###" /></td>
        	<c:choose>
        		<c:when test="${dto.rate_30day > 0}">
        			<td><fmt:formatNumber value="${dto.rate_30day}" pattern="0.00" />%</td>
        		</c:when>
	        	<c:otherwise>
	        		<td style="color: red;"><fmt:formatNumber value="${dto.rate_30day}" pattern="0.00" />%</td>
	        	</c:otherwise>
            </c:choose>

        	<td><a href="${dto.url}" target="_blank">${dto.title}</a></td>
        	<c:choose>
        	<c:when test="${dto.eventday == 99999999 }">
        	<td></td>
        	</c:when>
        	<c:otherwise>
        	<td>${dto.eventday}</td>
        	</c:otherwise>
        	</c:choose>

    
        </tr>
      </c:forEach>

    </tbody>
  </table>
  </div>
</div>
		
	</body>
</html>
