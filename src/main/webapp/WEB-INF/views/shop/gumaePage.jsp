<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

<div id="gumaePage1">
<div id="img">
	<a href="${path }">
		<img src="${path }/attach${path}/logo/ngbshop.png" width='230' height='45'>
	</a>
</div>
</div>
<hr id="hr1">

<div id="gumaePage2">

<h2>주문/결제</h2>
<hr id="hr2">

<!-- 회원정보 -->
<c:forEach var="gumaeDto" items="${gumaeList }">
	<c:forEach var="memberDto" items="${memberList }">
		<c:if test="${gumaeDto.memberCode == memberDto.memberCode }">
			<c:set var="name" value="${memberDto.name }" />		
			<c:set var="phone1" value="${memberDto.phone1 }" />		
			<c:set var="phone2" value="${memberDto.phone2 }" />		
			<c:set var="phone3" value="${memberDto.phone3 }" />		
			<c:set var="email1" value="${memberDto.email1 }" />		
			<c:set var="email2" value="${memberDto.email2 }" />		
			<c:set var="juso1" value="${memberDto.juso1 }" />		
			<c:set var="juso2" value="${memberDto.juso2 }" />		
			<c:set var="juso3" value="${memberDto.juso3 }" />		
			<c:set var="juso4" value="${memberDto.juso4 }" />		
		</c:if>
	</c:forEach>
	<c:set var="gumaeAmount" value="${gumaeList.size() }" />
</c:forEach>
<!-- 회원정보 -->

<h3>구매자정보</h3>
<table id="buyerInfo">
	<tr>
		<th>이름</th>
		<td>${name }</td>
	</tr>
	<tr>
		<th>이메일</th>
		<td>${email1 }@${email2 }</td>
	</tr>
	<tr>
		<th>휴대폰 번호</th>
		<td>${phone1 }-${phone2 }-${phone3 }</td>
	</tr>
	<tr>
		<th>배송주소</th>
		<td>${juso2 } ${juso3 }
			<c:if test="${juso4 != '-' }">
				${juso4 }
			</c:if>		
		</td>
	</tr>
</table>

<h3>배송 총 ${gumaeAmount }건</h3>
<table id="productInfo">
<c:forEach var="gumaeDto" items="${gumaeList }">
	<c:forEach var="productDto" items="${productList }">
		<c:if test="${gumaeDto.productCode == productDto.productCode }">
			<c:set var="productDetailName" value="${productDto.productDetailName }" />
			<c:set var="productPrice" value="${productDto.productPrice }" />
			<c:set var="productHap" value="${productPrice * gumaeDto.productAmount }" />
			<!-- 이미지 -->
			<c:set var="imsiArray" value="${fn:split(productDto.attachInfo, ',') }" />
			<c:set var="imsiImg" value="${imsiArray[1] }" />
			<!-- 이미지 -->
			
			<c:set var="imsiArrival" value="${fn:split(productDto.arrivalDate, '-') }" />
			<c:set var="month" value="${imsiArrival[1] }" />		
			<c:set var="day" value="${imsiArrival[2] }" />
			<c:set var="imsiDay" value="" />
			<c:set var="arraivalDate" value="" />
			
			<c:if test="${productDto.deliveryPeriod == 1 }">
				<c:set var="imsiDay" value="내일" />
			</c:if>
			<c:if test="${productDto.deliveryPeriod == 2 }">
				<c:set var="imsiDay" value="모레" />
			</c:if>
			
			<c:if test="${productDto.deliveryPeriod == 1 }">
				<c:set var="arraivalDate" value="${imsiDay } ${month }/${day } 도착 보장" />
			</c:if>
			<c:if test="${productDto.deliveryPeriod != 1}">
				<c:set var="arraivalDate" value="${imsiDay } ${month }/${day } 도착 예정" />
			</c:if>
			
			<c:set var="deliveryPrice" value="${productDto.deliveryPrice }" />
			<c:set var="deliveryArea" value="${productDto.deliveryArea }" />
		</c:if>
	</c:forEach>
	<tr>
		<td><img src="${path}/attach${path}/product/${imsiImg }" width='100' height='100'></td>
		<td>
			<a id="productDetailName">${productDetailName }</a><br>
			${arraivalDate }
			<c:if test="${deliveryArea == '해외' }">
				<a id="deliveryArea">(${deliveryArea }배송)</a>
			</c:if>
		</td>
		<td>
			<fmt:formatNumber value="${productPrice }" pattern="#,###" />원
		</td>
		<td>
			수량 ${gumaeDto.productAmount }개
		</td>
		<td>
			<fmt:formatNumber value="${productHap }" pattern="#,###" />원
		</td>
		<td>
			<c:if test="${deliveryPrice == 0}">
				무료배송
			</c:if>
			<c:if test="${deliveryPrice != 0}">
				배송비 <fmt:formatNumber value="${deliveryPrice }" pattern="#,###" />원
			</c:if>
		</td>	<!-- 배송비 -->
	</tr>
	
	<c:set var="productTotal" value="${productTotal + productHap }" />
	<c:set var="deliveryTotal" value="${deliveryTotal + deliveryPrice }" />
</c:forEach>
</table>

<h3>결제정보</h3>
<table id="gumaeInfo">
	<tr>
		<th id="gumaeInfoTh">총상품가격</th>
		<td>
			<a id="priceId"><fmt:formatNumber value="${productTotal }" pattern="#,###" /></a>원
		</td>
	</tr>
	<tr>
		<th id="gumaeInfoTh">배송비</th>
		<td>
			<a id="priceId"><fmt:formatNumber value="${deliveryTotal }" pattern="#,###" /></a>원
		</td>
	</tr>
	<tr>
		<th id="gumaeInfoTh">총결제금액</th>
		<td>
			<a id="totalPriceId"><fmt:formatNumber value="${productTotal + deliveryTotal }" pattern="#,###" /></a>원
		</td>
	</tr>
	<tr>
		<th id="gumaeInfoTh">결제방법</th>
		<td>
			<input type="radio" name="gumaeMethod" checked> 계좌이체 &nbsp;
			<input type="radio" name="gumaeMethod"> 신용/체크카드 &nbsp;
			<input type="radio" name="gumaeMethod"> 법인카드 &nbsp;
			<input type="radio" name="gumaeMethod"> 휴대폰결제 &nbsp;
			<input type="radio" name="gumaeMethod"> 무통장입금(가상계좌) &nbsp;
		</td>
	</tr>
</table>

<div id="btnDiv">
	<button type="button" id="buyBtn" onClick="gumae();">결제하기</button>
</div>

</div>

<form name="gumaeForm">
	<input type="hidden" name="checkedProduct" value="${checkedItem }">
</form>

<script>
function gumae(){
	if(confirm('주문 하시겠습니까?')){
		document.gumaeForm.action = "${path}/shop/gumaeProc";
		document.gumaeForm.method = "post";
		document.gumaeForm.submit();
	}
	
}
</script>

<style>
#gumaePage1{
	width: 950px;
	margin: auto;
	border: 0px solid red;
}
#hr1{
	border: 1px solid #DDDDDD;
}
#hr2{
	border: 1px solid #666666;
}
#gumaePage2{
	width: 950px;
	margin: auto;
	border: 0px solid red;
}
#buyerInfo, #productInfo, #gumaeInfo{
	width: 950px;
	border-top: 2px solid lightgray;
	border-collapse: collapse;
	font-size: 14px;
}
#buyerInfo{
	height: 150px;
}
th{
	background-color: #F4F4F4;
	border-bottom: 1px solid #DDDDDD;
}
td{
	border-bottom: 1px solid #DDDDDD;
	padding-left: 10px;
}
#productDetailName{
	font-size: 16px;
	font-weight: bold;
}
#deliveryArea{
	font-size: 12px;
}
#gumaeInfoTh{
	width: 150px; height: 40px;
}
#priceId, #totalPriceId{
	font-weight: bold;
}
#totalPriceId{
	font-size: 15px;
}
#btnDiv{
	padding-top: 30px;
	text-align: center;
}
#buyBtn{
	height: 60px; width: 180px;
	font-weight: bold; color: white; font-size: 18px;
	background-color: #0074E9; border: 2px solid #0074E9;
	border-radius: 5px;
	cursor: pointer
}

</style>