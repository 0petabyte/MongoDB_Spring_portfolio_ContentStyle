<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
	<head>
		<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
		<title>Welcome</title>
		<style type="text/css">
		.sticky-header th { position: sticky; top: 60px; left:0;}
		@media (max-width: 768px){
		.test{
		width: 100%; height: 100%;
		
		}
		.test{
		height: 3000px;
		overflow-x: auto; 
		}
		.sticky-header th { position: sticky; top: 10px; left:0; }
		</style>
	</head> 
	<body>
  <div class="alert alert-success">
    <strong>안내:</strong> DB는 DB수집 정확도율입니다. 정확도 율이 높을수록 신뢰도가 높습니다.
  </div>
<div class="container">
<div class="test">
  <table class="table table-striped">
    <thead>
      <tr class="sticky-header">
        <th>코인명</th>
        <th>거래소</th>
        <th>매수총액</th>
        <th>매도총액</th>
        <th>매수-매도총액</th>
        <th>거래량</th>
        <th>종가</th>
        <th>상승률</th>
        <th>DB</th>
        <th>채결강도</th>
        <th>날짜</th>
      </tr>
    </thead>
    <tbody>

      <c:forEach items="${list}" var="dto"> 
        <tr>
        	<td>${dto.coinname}</td>
        	<td>${dto.exchange}</td>
        	<td><fmt:formatNumber value="${dto.bid_total_24}" pattern="#,###" /></td>
        	<td><fmt:formatNumber value="${dto.ask_total_24}" pattern="#,###" /></td>
        	<c:choose>
        		<c:when test="${dto.sum_total_24 > 0}">
        			<td style="color: blue"><fmt:formatNumber value="${dto.sum_total_24}" pattern="#,###" /></td>
        		</c:when>
        		<c:otherwise>
        			<td style="color: red"><fmt:formatNumber value="${dto.sum_total_24}" pattern="#,###" /></td>
        		</c:otherwise>
        	</c:choose>
        	<td><fmt:formatNumber value="${dto.bidqtyToday + dto.askqtyToday}" pattern="#,###" /></td>
        	<td><fmt:formatNumber value="${dto.closeprice}" pattern="#,###" /></td>
        	<td><fmt:formatNumber value="${dto.torate}" pattern="#.##" />%</td>
        	<td><fmt:formatNumber value="${(dto.bidqtyToday + dto.askqtyToday) / dto.volume}" pattern="0.00%" /></td>
        	<td><fmt:formatNumber value="${dto.askbidvolumeToday}" pattern="#,###" /></td>
        	
        	<td>${dto.days}</td>
        </tr>
      </c:forEach>

    </tbody>
  </table>
  </div>
</div>
		
	</body>
</html>
