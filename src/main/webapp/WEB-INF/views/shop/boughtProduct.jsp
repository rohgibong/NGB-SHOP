<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

<div id="boughtPage">
<h2>주문목록</h2>

<c:if test="${listSize == 0 }">
<table id="noBoughtTable">
	<tr>
		<td>
			주문한 상품이 없습니다.
		</td>
	</tr>
</table>
</c:if>

<c:if test="${listSize != 0 }">
<c:set var="regiDate" value="" />
<c:forEach var="boughtDto" items="${boughtList }">
	<c:forEach var="productDto" items="${productList }">
		<c:if test="${boughtDto.productCode == productDto.productCode  }">
			<c:set var="productDetailName" value="${productDto.productDetailName }" />
			<c:set var="productPrice" value="${productDto.productPrice }" />
			<c:set var="productAmount" value="${boughtDto.productAmount }" />
			<c:set var="commentNo" value="${boughtDto.commentNo }" />
			<c:set var="imsiArray" value="${fn:split(productDto.attachInfo, ',') }" />
			<c:set var="imsiImg" value="${imsiArray[1] }" />
		</c:if>
	</c:forEach>
	
	<c:if test="${boughtDto.regiDate != regiDate}">
		<h3>${boughtDto.regiDate } 주문</h3>
		<c:set var="regiDate" value="${boughtDto.regiDate }" />
	</c:if>
	
	<table id="boughtTable">
		<tr>
			<td id="tableTd1">
				<div id="div1">
				
				</div>
				<div id="div2">
					<img src="${path}/attach${path}/product/${imsiImg }" width='80' height='80' id="productImg">
				</div>
				<div id="div3">
					${productDetailName }<br><br>
					<fmt:formatNumber value="${productPrice }" pattern="#,###" />원 · ${productAmount }개
				</div>
			</td>
			<td id="tableTd2">
				<div id="successWin_${boughtDto.cartNo }" class="successWin">
					<div id="successWin1">
						<a id="successWinClose" onClick="closeWin('${boughtDto.cartNo }');">X</a>
					</div>
					<div id="successWin2">
						<a id="successMent">상품이 장바구니에 담겼습니다.</a>
						<div id="goCartDiv" onClick="location.href='${path}/shop/cartList'">
							<a id="goCartMent">장바구니 바로가기 ></a>
						</div>
					</div>
				</div>
				<button type="button" onClick="getCart('${boughtDto.productCode}', '${productAmount }', '${boughtDto.memberCode}', '${boughtDto.cartNo}');" id="getCartBtn">장바구니 담기</button>
				
				<c:if test="${commentNo == 0}">
					<button type="button" onClick="cancelBought('${boughtDto.cartNo}', '${boughtDto.productCode}', '${productAmount }', '${boughtDto.memberCode}');" id="cancelBtn">주문 취소</button>
					<button type="button" onClick="writeComment('${boughtDto.cartNo}', '${boughtDto.productCode}', '${boughtDto.memberCode}');" id="commentBtn">리뷰 작성</button>
				</c:if>
				
			</td>
		</tr>
	</table>
</c:forEach>
</c:if>
<input type="hidden" name="cartNo" id="cartNo">
<input type="hidden" name="productCode" id="productCode">
<input type="hidden" name="imsiMemberCode" id="imsiMemberCode">


</div>

<script>
function getCart(value1, value2, value3, value4){
	$.ajax({
		type: "post",
		data: {
				"productCode" : value1,
				"productAmount" : value2,
				"no" : value3
			},
		url: "${path }/shop/cartChugaProc",
		success : function(result){
			if(result > 0){
				document.getElementById("successWin_"+value4).style.visibility = 'visible';
			}
		}
	});
}
function cancelBought(value1, value2, value3, value4){
	if(confirm('주문을 취소하시겠습니까?')){
		$.ajax({
			type: "post",
			data: {
					"cartNo" : value1,
					"productCode" : value2,
					"productAmount" : value3,
					"memberCode" : value4
				},
			url: "${path }/shop/cancelBought",
			success : function(result){
				if(result > 0){
					alert('주문 취소가 정상적으로 완료되었습니다.')
					location.reload();
				}
			}
		});
	}
}
function writeComment(value1, value2, value3){
	document.getElementById("cartNo").value = value1;
	document.getElementById("productCode").value = value2;
	document.getElementById("imsiMemberCode").value = value3;
	window.open("${path}/shop/commentChuga", "commentChuga", "width=700, height=400, toolbar=no, menubar=no, scrollbars=no, resizable=yes");
}

function closeWin(value1){
	document.getElementById("successWin_"+value1).style.visibility = 'hidden';
}

</script>

<style>
#body{
	
}
#menu{
	width: 1100px; margin:auto;
}
#searchDiv{
	width: 500px;
}
#searchData{
	width: 335px;
}
#boughtPage{
	width: 1100px; margin: auto; border: 0px solid red;
}
h2, h3{
	margin-left: 100px;
}
#noBoughtTable{
	width: 900px; height: 400px;
	margin: auto;
	border: 1px solid #DDDDDD;
	border-collapse: collapse;
	text-align: center;
	font-size: 20px; font-weight: bold;
}
#boughtTable{
	width: 900px;
	margin: auto;
	border: 1px solid #DDDDDD;
	border-collapse: collapse;
}
#div1{
	width: 100%; height: 50px;
	border: 0px solid red;
}
#div2{
	width: 100px; height: 100px;
	border: 0px solid red;
	float: left;
}
#productImg{
	margin-left: 20px;
}
#div3{
	width: 624px; height: 100px;
	border: 0px solid red;
	float: left;
	padding-left: 15px;
}
#tableTd2{
	width: 150px; height: 150px;
	border-left: 1px solid #DDDDDD;
	text-align: center;
}
.successWin{
	width: 220px; height: 80px;
	margin-left: 10px; margin-top: 40px;
	border: 1px solid #DCDCDC;
	position: absolute;
	background-color: white;
	visibility: hidden;
}
#successWin1{
	width: 100%; height: 20px;
	text-align: right;
}
#successWin2{
	width: 100%; height: 60px;
	text-align: center;
}
#successWinClose{
	margin-right: 7px;
	font-size: 15px;
	font-weight: bold;
	color: #666666;
	cursor: pointer;
}
#successMent{
	font-size: 12px;
}
#goCartDiv{
	width: 160px; height: 25px;
	line-height: 25px;
	border: 1px solid #0074E9;
	margin-left: 30px;
	margin-top: 5px;
	cursor: pointer;
}
#goCartMent{
	font-size: 13px; color: #0074E9; font-weight: bold;
}
#getCartBtn, #cancelBtn, #commentBtn{
	width: 130px; height: 30px;
	border: 1px solid #DDDDDD;
	background-color: white;
	font-size: 13px;
	border-radius: 5px 5px;
	cursor: pointer;
}
#cancelBtn{
	margin-top: 10px;
}
#commentBtn{
	margin-top: 10px;
	border: 1px solid #0074E9;
	color: #0074E9;
}
</style>