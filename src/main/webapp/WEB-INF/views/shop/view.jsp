<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

<div id="productPage">

	<div id="productImg">
		<c:set var="imsiArray" value="${fn:split(dto.attachInfo, ',') }" />
		<c:set var="imsiImg" value="${imsiArray[1] }" />
		
		<img src="${path}/attach${path}/product/${imsiImg }" width='400' height='400'>
	</div>
	<div id="productDetail">
	
		<a id="vendorName" onClick="goVendor('${dto.vendorName }');">
			${dto.vendorName }
		</a><br>
		
		<a id="productName">
			${dto.productName }
		</a><br>
		
		<hr id="hrId">
		
		<c:if test="${dto.useable == 'O'}">
			<a id="productPrice"><fmt:formatNumber value="${dto.productPrice }" pattern="#,###" /></a><a id="productPrice2">원</a>
		</c:if>
		<c:if test="${dto.useable == 'X'}">
			<a id="productPrice11"><fmt:formatNumber value="${dto.productPrice }" pattern="#,###" /></a><a id="productPrice22">원</a>
		</c:if>
		<br>
		<c:if test="${dto.useable == 'X'}">
			<br>
			<a id="soldOutMent">품절</a>
		</c:if>
		<hr id="hrId2">
		
		<c:if test="${dto.deliveryPrice != '0' }">
			<a id="deliveryPrice">배송비 <fmt:formatNumber value="${dto.deliveryPrice }" pattern="#,###" />원</a>
		</c:if>
		<c:if test="${dto.deliveryPrice == '0' }">
			<a id="deliveryPriceFree">무료배송</a>
		</c:if>
		<br>
		
		<c:set var="imsiArrival" value="${fn:split(dto.arrivalDate, '-') }" />
		<c:set var="month" value="${imsiArrival[1] }" />		
		<c:set var="day" value="${imsiArrival[2] }" />
		<c:set var="imsiDay" value="" />
		
		<c:if test="${dto.deliveryPeriod == 1 }">
			<c:set var="imsiDay" value="내일" />
		</c:if>
		<c:if test="${dto.deliveryPeriod == 2 }">
			<c:set var="imsiDay" value="모레" />
		</c:if>
		
		<c:if test="${dto.useable == 'O'}">
			<c:if test="${dto.deliveryPeriod == 1 }">
				<a id="deliveryPeriod">${imsiDay} ${month }/${day } 도착 보장</a>
			</c:if>
			<c:if test="${dto.deliveryPeriod != 1}">
				<a id="deliveryPeriod2">${imsiDay} ${month }/${day } 도착 예정</a>
			</c:if>
		</c:if>
		
		<hr id="hrId2">
		
		<a id="descriptionId">${fn:replace(dto.productDescription, newLineChar, "<br/>") }</a>
		
		<hr id="hrId2">
		
		<div id="successWin">
			<div id="successWin1">
				<a id="successWinClose" onClick="closeWin();">X</a>
			</div>
			<div id="successWin2">
				<a id="successMent">상품이 장바구니에 담겼습니다.</a>
				<div id="goCartDiv" onClick="location.href='${path}/shop/cartList'">
					<a id="goCartMent">장바구니 바로가기 ></a>
				</div>
			</div>
		</div>
		
		<c:if test="${dto.useable == 'O'}">
		<div id="amountCartDiv">
			<input type="text" name="amount" id="amount" value="1" maxlength="2" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
			<button type="button" class="plus" id="upBtn">▲</button>
			<button type="button" class="minus" id="downBtn">▼</button>
			<label id="label_amount"></label>
			
			<button id="saveCart" type="button" onClick="saveCart();">
				장바구니 담기
			</button>
			
			<button id="buyProduct" type="button" onClick="buyThis();">
				바로구매 >
			</button>
		</div>
		</c:if>
		<c:if test="${dto.useable == 'X'}">
		<div id="amountCartDiv">
			<input type="text" name="amount2" id="amount2" value="0" disabled>
			<button type="button" id="upBtn2">▲</button>
			<button type="button" id="downBtn2">▼</button>
			<label id="label_amount"></label>
			
			<button id="saveCart2" type="button">
				장바구니 담기
			</button>
			
			<button id="buyProduct2" type="button">
				바로구매 >
			</button>
		</div>
		</c:if>
		
	</div>

</div>

<form name="gumaeForm">
	<input type="hidden" name="productCode" id="productCode" value="${dto.productCode }">
	<input type="hidden" name="productAmount" id="productAmount">
	<input type="hidden" name="no" id="no" value="${sessionNo }">
</form>

<form name="gumaeForm2">
	<input type="hidden" name="checkedItem" id="checkedItem">
	<input type="hidden" name="checkAmount" id="checkAmount">
</form>

<input type="hidden" name="ip" id="ip" value="${ip }">

<script>
function goVendor(value1){
	location.href = '${path}/shop/list?vendorName='+value1;
}

var current = "1";

$('.plus').click(function(){
	current++;
	if(current > 99){
		current=99;
		$("#label_amount").html("최대 수량은 99개입니다.");
		$("#label_amount").css('color', 'red');
		$("#label_amount").css('font-size', '9px');
	} else{
		$("#label_amount").html("");
	}
	update();
})

$('.minus').click(function(){
	current--;
	
	if(current < 1){
		current=1;
		$("#label_amount").html("최소 수량은 1개입니다.");
		$("#label_amount").css('color', 'red');
		$("#label_amount").css('font-size', '9px');
	} else{
		$("#label_amount").html("");
	}
	update();
})

function update(){
	$('#amount').val(current);
}

function saveCart(){
	document.gumaeForm.productAmount.value = document.getElementById("amount").value;
	var productCode = $("#productCode").val();
	var productAmount = $("#productAmount").val();
	var no = $("#no").val();
	if(productAmount == 0){
		$("#label_amount").html("최소 수량은 1개입니다.");
		$("#label_amount").css('color', 'red');
		$("#label_amount").css('font-size', '9px');
		return;
	}
	if(!(no > 0)){
		var ip = document.getElementById("ip").value;
		var ipArray = ip.split(".");
		document.gumaeForm.no.value = ipArray[0]+ipArray[1]+ipArray[2];
	}
	
	$.ajax({
		type: "post",
		data: {
				"productCode" : productCode,
				"productAmount" : productAmount,
				"no" : document.gumaeForm.no.value
			},
		url: "${path }/shop/cartChugaProc",
		success : function(result){
			if(result > 0){
				successWin.style.visibility = 'visible';
			} else{
				alert('등록 중 오류가 발생했습니다.');
			}
		}
	});
}

function buyThis(){
	document.gumaeForm.productAmount.value = document.getElementById("amount").value;
	var productCode = $("#productCode").val();
	var productAmount = $("#productAmount").val();
	var no = $("#no").val();
	if(productAmount == 0){
		$("#label_amount").html("최소 수량은 1개입니다.");
		$("#label_amount").css('color', 'red');
		$("#label_amount").css('font-size', '9px');
		return;
	}
	if(!(no > 0)){
		location.href = "${path}/member/login";
		return;
	}
	
	$.ajax({
		type: "post",
		data: {
				"productCode" : productCode,
				"productAmount" : productAmount,
				"no" : document.gumaeForm.no.value
			},
		url: "${path }/shop/cartChugaProc",
		success : function(result){
			if(result > 0){
				$.ajax({
					type: "post",
					data: {
							"productCode" : productCode,
							"no" : document.gumaeForm.no.value
						},
					url: "${path }/shop/searchCart",
					success : function(result){
						if(result > 0){
							document.gumaeForm2.checkedItem.value = result;
							document.gumaeForm2.checkAmount.value = document.getElementById("amount").value;
							document.gumaeForm2.action = "${path}/shop/gumaePage";
							document.gumaeForm2.method = "post";
							document.gumaeForm2.submit();
						} else{
							alert('오류가 발생했습니다.');
						}
					}
				});
				
			} else{
				alert('구매 중 오류가 발생했습니다.');
			}
		}
	});
}

function closeWin(){
	successWin.style.visibility = 'hidden';
}

</script>

<style>
#body{
	height: 800px;
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
#productPage{
	width: 1100px; height: 1000px; margin: auto; border: 0px solid red;
}
#productImg{
	height: 460px; width: 450px;
	padding-top: 30px; padding-left: 50px;
	border: 0px solid black;
	float: left;
}
#productDetail{
	height: 450px; width: 580px;
	padding-top: 40px; padding-left: 20px;
	border: 0px solid black;
	float: left;
}
#vendorName{
	font-size: 12px; color: #0074E9;
}
#vendorName:hover{
	cursor: pointer;
	text-decoration: underline;
}
#productName{
	font-size: 18px; font-weight: bold;
}
#hrId{
	margin-top: 20px;
	margin-bottom: 20px;
	border-color: #EEEEEE;
}
#productPrice{
	font-size: 21px; font-weight: bolder; color: #AE0000;
}
#productPrice2{
	font-size: 18px; font-weight: bold; color: #AE0000; margin-left: 2px;
}
#productPrice11{
	font-size: 21px; font-weight: bolder; color: #DDDDDD;
}
#productPrice22{
	font-size: 18px; font-weight: bold; color: #DDDDDD; margin-left: 2px;
}
#hrId2{
	margin-top: 50px;
	margin-bottom: 20px;
	border: 1px solid #EEEEEE;
}
#deliveryPrice, #deliveryPriceFree{
	font-size: 13px;
}
#deliveryPriceFree{
	font-weight: bold;
}
#deliveryPeriod{
	font-size: 14px; font-weight: bold;
	color: #00891A;
}
#deliveryPeriod2{
	font-size: 14px; font-weight: bold;
}
#descriptionId{
	font-size: 13px;
}
#amountCartDiv{
	border: 0px solid red;
	width: 500px;
	height: 50px;
}
#amount{
	position: absolute;
	width: 60px; height: 40px; text-align: center;
	font-size: 18px; font-weight: bold;
	border: 1px solid #DCDCDC;
}
#amount2{
	position: absolute;
	width: 60px; height: 40px; text-align: center;
	font-size: 18px; font-weight: bold;
	color: #DDDDDD;
	border: 1px solid #DCDCDC;
}
#upBtn{
	position: absolute;
	width: 30px; height: 20px;
	margin-left: 60px;
	background-color: white;
	border: 1px solid #DCDCDC;
	color: gray;
}
#upBtn2{
	position: absolute;
	width: 30px; height: 20px;
	margin-left: 60px;
	background-color: white;
	border: 1px solid #DCDCDC;
	color: #DDDDDD;
}
#upBtn:hover {
	cursor: pointer;
}
#downBtn{
	position: absolute;
	width: 30px; height: 20px;
	margin-top: 20px; margin-left: 60px;
	background-color: white;
	border: 1px solid #DCDCDC;
	color: gray;
}
#downBtn2{
	position: absolute;
	width: 30px; height: 20px;
	margin-top: 20px; margin-left: 60px;
	background-color: white;
	border: 1px solid #DCDCDC;
	color: #DDDDDD;
}
#downBtn:hover {
	cursor: pointer;
}
#label_amount{
	position: absolute;
	margin-top: 45px;
}
#successWin{
	width: 220px; height: 80px;
	margin-left: 85px; margin-top: 50px;
	border: 1px solid #DCDCDC;
	position: absolute;
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
#saveCart{
	position: absolute;
	width: 190px; height: 40px;
	margin-left: 100px;
	background-color: white; color: #0074E9;
	border: 1px solid #0074E9;
	font-size: 16px; font-weight: bold;
	cursor: pointer;
}
#buyProduct{
	position: absolute;
	width: 190px; height: 40px;
	margin-left: 300px;
	background-color: #0074E9; color: white;
	border: 1px solid #0074E9;
	font-size: 16px; font-weight: bold;
	cursor: pointer;
}
#saveCart2{
	position: absolute;
	width: 190px; height: 40px;
	margin-left: 100px;
	background-color: white; color: #0074E9;
	border: 1px solid #0074E9;
	font-size: 16px; font-weight: bold;
	opacity: 0.2;
}
#buyProduct2{
	position: absolute;
	width: 190px; height: 40px;
	margin-left: 300px;
	background-color: #0074E9; color: white;
	border: 1px solid #0074E9;
	font-size: 16px; font-weight: bold;
	opacity: 0.2;
}
#soldOutMent{
	font-size: 14px;
	font-weight: bold;
}



</style>