<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>

<div id="productPage">

<c:if test="${pageNumber <= 0 || pageNumber < map.startPage || pageNumber > map.lastPage}">
	<script>
		location.href="${path }/member/warning";
	</script>
</c:if>


<div id="contentTitle">
	<h1>${title }</h1>
	<a id="vendorTitle">${title4 }</a>
</div>

<%-- ${productCounter }건 ${pageNumber } / ${map.totalPage } --%>

<h3 id="searchTitle"><a id="title2">${title2 }</a>${title3 }</h3>

<c:set var="imsiNum" value="0" />
<c:forEach var="i" begin="1" end="${rowCounter }" >
<table id="contentTable">
	<tr>	
		<c:forEach var="j" begin="1" end="${cellCounter }">
		<c:set var="idxExist" value="X" />
		<c:if test="${imsiNum < list.size() }">
			<c:set var="idxExist" value="O" />
		</c:if>
		
		<c:if test="${idxExist == 'O' }">
			<td id="productTdId">
				<c:forEach var="dto" items="${list }" begin="${imsiNum }" end="${imsiNum }">
					<c:set var="imsiArray" value="${fn:split(dto.attachInfo, ',') }" />
					<c:set var="imsiImg" value="${imsiArray[1] }" />
					<c:set var="imsiDay" value="" />
					<div id="productDivId" onClick="move('view', ${dto.productCode})">
						<c:if test="${dto.useable == 'O'}">
							<img src="${path}/attach${path}/product/${imsiImg }" width='120' height='120'><br>
						</c:if>
						<c:if test="${dto.useable == 'X'}">
							<img src="${path}/attach${path}/product/${imsiImg }" width='120' height='120' id="imgX"><br>
						</c:if>
						<div id="description">
						<a id="productNameId">${dto.productDetailName }<br></a>
						<c:if test="${dto.useable == 'O'}">
							<a id="productPriceId1"><fmt:formatNumber value="${dto.productPrice }" pattern="#,###" /></a><a id="productPriceId2">원</a><br>
						</c:if>
						<c:if test="${dto.useable == 'X'}">
							<a id="productPriceId11"><fmt:formatNumber value="${dto.productPrice }" pattern="#,###" /></a><a id="productPriceId22">원</a><br>
						</c:if>
							<c:set var="imsiArrival" value="${fn:split(dto.arrivalDate, '-') }" />
							<c:set var="month" value="${imsiArrival[1] }" />		
							<c:set var="day" value="${imsiArrival[2] }" />
								<c:if test="${dto.deliveryPeriod == 1 }">
									<c:set var="imsiDay" value="내일" />
								</c:if>
								<c:if test="${dto.deliveryPeriod == 2 }">
									<c:set var="imsiDay" value="모레" />
								</c:if>
								<c:if test="${dto.useable == 'O'}">
									<c:if test="${dto.deliveryPeriod == 1 }">
										<a id="periodId">${imsiDay} ${month }/${day } 도착 보장</a><br><br>
									</c:if>
									<c:if test="${dto.deliveryPeriod != 1}">
										<a id="periodId2">${imsiDay} ${month }/${day } 도착 예정</a><br><br>
									</c:if>
								</c:if>
								<c:if test="${dto.useable == 'X'}">
									<a id="soldOutMent">품절</a>
								</c:if>
						</div>
					</div>
				</c:forEach>
			</td>
		</c:if>
		
		<c:if test="${idxExist == 'X' }">
			<td id="productTdId2">
			
			</td>
		</c:if>
		
		<c:set var="imsiNum" value="${imsiNum+1 }" />
		</c:forEach>
	</tr>
</table>
</c:forEach>

<c:if test="${productCounter > 0 }">
<div id="pageNumberDiv">

<c:if test="${map.startPage > map.pageSize }">
	<a class="nextPage" onClick="goPage('${map.startPage - map.pageSize }');">&lt;&lt;</a>
</c:if>
<c:if test="${map.startPage <= map.pageSize }">
	<a class="nextPage" onClick="goPage('${map.startPage }');">&lt;&lt;</a>
</c:if>
<c:if test="${map.startPage != pageNumber }">
	<a class="nextPage" onClick="goPage('${pageNumber - 1}');">&lt;</a>
</c:if>
<c:if test="${map.startPage == pageNumber }">
	<a class="nextPage" onClick="goPage('${pageNumber}');">&lt;</a>
</c:if>

<c:forEach var="i" begin="${map.startPage }" end="${map.lastPage }" step="1">
	<c:if test="${i == pageNumber }">
		<a class="selectedNumber" onClick="goPage('${i}');">${i}</a>
	</c:if>
	<c:if test="${i != pageNumber }">
		<a class="nonSelectedNumber" onClick="goPage('${i}');">${i}</a>
	</c:if>
</c:forEach>

<c:if test="${map.lastPage != pageNumber }">
	<a class="nextPage" onClick="goPage('${pageNumber + 1}');">&gt;</a>
</c:if>
<c:if test="${map.lastPage == pageNumber }">
	<a class="nextPage" onClick="goPage('${pageNumber}');">&gt;</a>
</c:if>
<c:if test="${map.lastPage < map.totalPage }">
	<a class="nextPage" onClick="goPage('${map.startPage + map.pageSize }');">&gt;&gt;</a>
</c:if>
<c:if test="${map.lastPage >= map.totalPage }">
	<a class="nextPage" onClick="goPage('${map.lastPage }');">&gt;&gt;</a>
</c:if>

</div>
</c:if>


</div>

<script>
function move(value1, value2){
	location.href = "${path}/shop/"+value1+"?productCode="+value2;
}
function goPage(value1){
	if(${categoryCode} > 0){
		location.href='${path }/shop/list?categoryCode=${categoryCode}&pageNumber='+value1;
	} else {
		location.href='${path }/shop/list?pageNumber='+value1+'&searchGubun=${searchGubun}&searchData=${searchData}';
	}
}
</script>


<style>
#menu{
	width: 1400px; margin:auto;
}
#content{
	width: 1400px; margin:auto;
}
#img{
	margin-left: 30px; margin-top: 30px;
	position: absolute;
}
#searchDiv{
	margin-left: 300px;
	width: 800px;
}
#searchCateList{
	margin-left: 301px;
}
#searchData{
	width: 635px;
}
#myPage_cart{
	margin-right: 130px; 
}
#productPage{
	width: 1190px; float: right;
}
#contentTitle{
	text-align: center; padding-bottom: 20px;
}
#vendorTitle{
	font-size: 14px;
}
#searchTitle{
	text-align: left; padding-left: 100px;
}
#title2{
	color: red;
}
#contentTable{
	margin: auto; border-spacing: 20px; text-align: center; border-top: 1px solid #DCDCDC; margin-bottom: 0px;
}
#description{
	text-align: left; padding-top: 10px; width: 90%; margin: auto;
}
#productTdId{
	width: 200px; height: 250px; cursor: pointer;
}
#productTdId:hover{
	box-shadow: 0px 0px 10px #BDBDBD;
}
#imgX{
	opacity: 0.2;
}
#productNameId, #productPriceId2{
	font-size: 13px;
}
#productPriceId1{
	font-size: 20px; font-weight: bold; color: #AE0000;
}
#productPriceId2{
	color: #AE0000;
}
#productNameId2, #productPriceId22{
	font-size: 13px;
	color: #DDDDDD;
}
#productPriceId11{
	font-size: 20px; font-weight: bold; color: #DDDDDD;
}
#productPriceId22{
	color: #DDDDDD;
}
#periodId{
	font-size: 12px; color: #00891A;
}
#periodId2{
	font-size: 12px;
}
#productTdId2{
	width: 200px; height: 200px;
}
#soldOutMent{
	font-size: 13px;
	font-weight: bold;
}
#pageNumberDiv{
	text-align: center;
	height: 70px;
	line-height: 70px;
}
.selectedNumber{
	padding: 5px 10px;
	border: 1px solid #0074E9;
	font-size: 14px; font-weight: bold;
	color: #0074E9;
}
.selectedNumber:hover, .nonSelectedNumber:hover, .nextPage:hover{
	text-decoration: underline;
	cursor: pointer;
}
.nonSelectedNumber{
	padding: 5px 10px;
	font-size: 14px; font-weight: bold;
	color: #555555;
}
.nextPage{
	padding: 5px 10px;
	background-color: #FCFCFC;
	border: 1px solid #CCCCCC;
	font-size: 14px; font-weight: bold;
	color: #CCCCCC;
}

</style>

