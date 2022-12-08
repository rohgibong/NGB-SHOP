<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

<div id="img">
<a href="${path }">
	<img src="${path }/attach${path}/logo/ngbshop2.png" width='230' height='45'>
</a>
</div>

<input type="hidden" id="checkMemberNo" value="${memberNo }">

<div id="cartPage">
	<div id="cartTop">
		<img src="${path }/attach${path}/logo/cart.png" id="cartImg" width='40' height='35'>
		<h1 id="cartTitle">장바구니</h1>
	</div>
	
	<c:if test="${cartList.size() != 0 }">
		<button type="button" id="sakjeAllBtn">전체삭제</button>
		<button type="button" id="sakjeSoldoutBtn" onClick="sakjeSoldOut('${memberNo}');">품절된 상품 삭제</button>
	</c:if>
	<div id="cartMain">
		<table id="cartTable">
			<tr>
			
			<c:if test="${cartList.size() == 0 }">
				<th>상품정보</th>
				<th>상품금액</th>
				<th>배송비</th>
			</c:if>
			
			<c:if test="${cartList.size() != 0 }">
				<th id="checkAllTh">
					<input type="checkbox" name="checkAll" id="checkAll" checked> 전체선택
				</th>
				<th>상품정보</th>
				<th width="90px">상품금액</th>
				<th width="90px">배송비</th>
			</c:if>
			
			</tr>
			
			<c:if test="${cartList.size() == 0 }">
				<tr>
					<td colspan="3" id="noItems">
						장바구니에 담은 상품이 없습니다. <br>
						<c:if test="${!(memberNo >= 0) }">
							<a id="loginMent">로그인을 하시면, 장바구니에 보관된 상품을 확인하실 수 있습니다.</a>
							<button type="button" id="loginBtn" onClick="location.href='${path}/member/login'">로그인하기</button>
						</c:if>
					</td>
				</tr>
			</c:if>
			
			<c:if test="${cartList.size() != 0 }">
				<c:forEach var="cartDto" items="${cartList }">
					<c:forEach var="productDto" items="${productList }">
						<c:if test="${cartDto.productCode == productDto.productCode }">
							<c:set var="productName" value="${productDto.productDetailName }" />
							<c:set var="productPrice" value="${productDto.productPrice }" />
							<c:set var="useable" value="${productDto.useable }" />
							<c:set var="deliveryPeriod" value="${productDto.deliveryPeriod }" />
							<c:set var="deliveryPrice" value="${productDto.deliveryPrice }" />
							<c:set var="deliveryArea" value="${productDto.deliveryArea }" />
							
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
							
							
							<c:set var="attachInfo" value="${fn:split(productDto.attachInfo, ',') }" />
							<c:set var="imgSrc" value="${attachInfo[1] }" />
							
							<c:set var="img" value="${path}/attach${path}/product/${imgSrc }" />
						</c:if>
					</c:forEach>
					
					<c:set var="hap" value="${productPrice * cartDto.productAmount }" />
					<c:if test="${useable == 'O'}">
						<c:set var="totalProductPrice" value="${totalProductPrice + hap }" />
					</c:if>
					<c:if test="${useable == 'X'}">
						<c:set var="totalProductPrice" value="${totalProductPrice}" />
					</c:if>
					
					<div id="checkImsiDiv">
					<c:if test="${useable == 'X'}">
						<input type="checkbox" name="checkImsi" id="checkImsi" class="checkImsi" value="${cartDto.cartNo }" checked>
					</c:if>
					</div>
					<tr>
						<td colspan="2">
							<div id="checkBoxDiv">
								<c:if test="${useable == 'O'}">
									<input type="checkbox" name="checkItems" id="checkItems" class="checkItems" value="${cartDto.cartNo }" checked>
								</c:if>
								<c:if test="${useable == 'X'}">
									<input type="checkbox" name="checkItems2" id="checkItems2" class="checkItems2" value="${cartDto.cartNo }" disabled>
								</c:if>
							</div>
							<div id="productDiv">
								<c:if test="${useable == 'O'}">
									<img src="${img }" id="productImg" width='80' height='80'>
								</c:if>
								<c:if test="${useable == 'X'}">
									<img src="${img }" id="productImgX" width='80' height='80'>
								</c:if>
								<div id="descriptionId">
									<div id="description1">
										<a id="productName" onClick="moveView(${cartDto.productCode})">${productName }</a>
									</div>
									<div id="description2">
									<c:if test="${useable == 'O'}">
										<c:if test="${imsiDay == '내일' }">
											<a id="arrival1">${arraivalDate }</a>
										</c:if>
										<c:if test="${imsiDay != '내일' }">
											<a id="arrival2">${arraivalDate }</a>
										</c:if>
										<c:if test="${deliveryArea == '해외'}">
											<a id="deliveryArea">(${deliveryArea }배송)</a>
										</c:if>
									</c:if>
									<c:if test="${useable == 'X'}">
										<a id="soldOutMent">품절</a>
									</c:if>
										<div id="price_amount">
											<a id="priceFont"><fmt:formatNumber value="${productPrice }" pattern="#,###" />원</a>
											<c:if test="${useable == 'O'}">
												<input type="text" id="writeAmount" name="writeAmount" value="${cartDto.productAmount }" maxlength="2" onChange="updateAmount(this.value, ${cartDto.cartNo }, '${useable}');" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
											</c:if>
											<c:if test="${useable == 'X'}">
												<input type="text" id="writeAmount" name="writeAmount" value="${cartDto.productAmount }" maxlength="2" readonly oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
											</c:if>
											<br>
											<button type="button" id="sakjeBtn" onClick="sakjeCartOne(${cartDto.cartNo})">X</button>
										</div>
									</div>
								</div>
							</div>
							
						</td>
						<td id="priceTd">
							<fmt:formatNumber value="${hap }" pattern="#,###" />원
							<input type="hidden" id="price_${cartDto.cartNo }" value="${hap }">
						</td>
						<td id="priceTd">
							<c:if test="${deliveryPrice == 0}">
								무료
								<c:set var="totaldeliveryPrice" value="${totaldeliveryPrice + deliveryPrice }" />
							</c:if>
							<c:if test="${deliveryPrice != 0}">
								<fmt:formatNumber value="${deliveryPrice }" pattern="#,###" />원
								<c:set var="totaldeliveryPrice" value="${totaldeliveryPrice + deliveryPrice }" />
							</c:if>
							<input type="hidden" id="deliveryPrice_${cartDto.cartNo }" value="${deliveryPrice }">
						</td>
					</tr>
				</c:forEach>
					<tr>
						<td colspan="4" id="priceHap">
							<a id="totalMent">총 상품가격</a>
							<a id="price2"><fmt:formatNumber value="${totalProductPrice }" pattern="#,###" /></a><a id="totalMent">원</a>
							<a id="totalMent">+</a>
							<a id="totalMent">총 배송비</a>
							<a id="price1"><fmt:formatNumber value="${totaldeliveryPrice }" pattern="#,###" /></a>원
							<a id="totalMent">=</a>
							<a id="totalMent">총 주문금액</a>
							<a id="price3"><fmt:formatNumber value="${totalProductPrice + totaldeliveryPrice }" pattern="#,###" /></a><a id="totalMent">원</a>
						</td>
					</tr>
			</c:if>
		</table>
		
		<c:if test="${cartList.size() != 0 }">
			<div id="btnDiv">
				<button type="button" id="shopBtn" onClick="location.href='${path}'">계속 쇼핑하기</button>&nbsp;
				<button type="button" id="buyBtn">구매하기</button>
			</div>
		</c:if>
		
		<form name="gumaeForm">
			<input type="hidden" name="checkedItem" id="checkedItem">
			<input type="hidden" name="checkAmount" id="checkAmount" value="0">
		</form>
		
	</div>


</div>

<script>
$(document).ready(function(){
	$("#checkAll").click(function(){
		if($("#checkAll").prop("checked")){
			$("input[name=checkItems]").prop("checked", true);
			$('#sakjeAllBtn').text('전체삭제');
		} else{
			$("input[name=checkItems]").prop("checked", false);
			$('#sakjeAllBtn').text('선택삭제');
		}
		
		priceCal();
	});
	$(".checkItems").change(function(){
		if($(".checkItems:checked").length == $(".checkItems").length){
			$("#checkAll").prop("checked", true);
			$('#sakjeAllBtn').text('전체삭제');
		} else{
			$("#checkAll").prop("checked", false);
			$('#sakjeAllBtn').text('선택삭제');
		}
		priceCal();
	});
});

function priceCal(){
	var no = "";
	var price = 0;
	var deliveryPrice = 0;
	var totalPrice = 0;
	var totaldeliveryPrice = 0;
	var priceHap = 0;
	
	var obj = document.getElementsByName("checkItems");
	for(i=0; i<obj.length; i++){
		if(obj[i].checked){
			no = obj[i].value;
			deliveryPrice = document.getElementById("deliveryPrice_" + no).value;
			totaldeliveryPrice = totaldeliveryPrice + parseInt(deliveryPrice);
			price = document.getElementById("price_" + no).value;
			totalPrice = totalPrice + parseInt(price);
			priceHap = totaldeliveryPrice + totalPrice;
		}
	}
	
	$("#price1").html(commify2(totaldeliveryPrice));
	$("#price2").html(commify2(totalPrice));
	$("#price3").html(commify2(priceHap));
}

function commify2(n){
    var reg = /(^[+-]?\d+)(\d{3})/;   
    n += '';                          
 
    while (reg.test(n))
    {
    n = n.replace(reg, '$1' + ',' + '$2');
    }
 
    return n;
}

function moveView(value1){
	location.href = "${path}/shop/view?productCode="+value1;
}

function updateAmount(value1, value2, value3){
	if(value1 == ''){
		alert('상품 최소 수량은 1개입니다.');
		location.reload();
		return;
	}
	if(value3 == 'X'){
		alert('품절된 상품입니다.');
		location.reload();
		return;
	}
	
	$.ajax({
		type: "post",
		data: {
				"cartNo" : value2,
				"productAmount" : value1
			},
		url: "${path }/shop/sujungAmount",
		success : function(result){
			if(result > 0){
				location.reload();
			} else{
				alert('수정 중 오류가 발생했습니다.');
			}
		}
	});
}

function sakjeCartOne(value1){
	$.ajax({
		type: "post",
		data: {
				"cartNo" : value1
			},
		url: "${path }/shop/sakjeCartOne",
		success : function(result){
			if(result > 0){
				location.reload();
			} else{
				alert('삭제 중 오류가 발생했습니다.');
			}
		}
	});
}

$(document).on('click', '#sakjeAllBtn', function(){
	var chk_items = [];
	$(".checkItems:checked").each(function(){
		var items = $(this).val();
		chk_items.push(items);
	});
	if(chk_items == ''){
		alert('1개 이상의 상품을 선택해주세요.');
		return;
	}
	if(confirm('선택한 상품을 삭제하시겠습니까?')){
		$.ajax({
			type: "post",
			traditional: true,
			data: {
					"chk_items" : chk_items
				},
			url: "${path }/shop/sakjeCartChecked",
			success : function(result){
				if(result > 0){
					location.reload();
				} else{
					alert('삭제 중 오류가 발생했습니다.');
				}
			}
		});
	}
});

$(document).on('click', '#buyBtn', function(){
	var checkMemberNo = $("#checkMemberNo").val();
	
	var chk_items = [];
	$(".checkItems:checked").each(function(){
		var items = $(this).val();
		chk_items.push(items);
	});
	if(chk_items == ''){
		alert('1개 이상의 상품을 선택해주세요.');
		return;
	}
	$('#checkedItem').val(chk_items);
	if(!(checkMemberNo > 0)){
		location.href = "${path}/member/login";
		return;
	}
	document.gumaeForm.action = "${path}/shop/gumaePage";
	document.gumaeForm.method = "post";
	document.gumaeForm.submit();
});

function sakjeSoldOut(value1){
	var chk_items = [];
	if(confirm('품절된 상품을 모두 삭제하시겠습니까?')){
	$(".checkImsi:checked").each(function(){
		var items = $(this).val();
		chk_items.push(items);
	});
	if(chk_items == ''){
		alert('품절된 상품이 없습니다.');
		return;
	}
	$.ajax({
		type: "post",
		traditional: true,
		data: {
				"chk_items" : chk_items
			},
		url: "${path }/shop/sakjeSoldOut",
		success : function(result){
			if(result > 0){
				alert('품절된 상품을 삭제했습니다.');
				location.reload();
			} else{
				alert('삭제 중 오류가 발생했습니다.');
			}
		}
	});
	}	
}

</script>


<style>
*{
	background-color: #EBEBEB;
}
#img{
	text-align: center; margin-bottom: 20px;
}
#cartPage{
	width: 950px;
	background-color: white; border-top: 1px solid #808080;
	margin: auto;
}
#cartTop{
	width: 100%; height: 100px;
	background-color: white;
	cursor: default;
}
#cartImg{
	position: absolute;
	margin-left: 30px; margin-top: 40px;
}
#cartTitle{
	background-color: white;
	position: absolute;
	margin-left: 82px; margin-top: 37px;
}
#cartMain{
	width: 100%;
	background-color: white;
}
#cartTable{
	background-color: white;
	width: 880px;
	margin: auto;
	margin-top: 30px;
	border-collapse: collapse;
	border-spacing: 0;
	cursor: default;
}
#checkAllTh{
	width: 80px; padding-left: 10px;
}
th{
	background-color: #FAFAFA;
	height: 35px;
	font-size: 13px; font-weight: bold;
	border-top: 1px solid #DDDDDD; border-bottom: 1px solid #DDDDDD;
}
td{
	background-color: white;
	border-bottom: 1px solid #DDDDDD;
}
#noItems{
	background-color: white;
	text-align: center; font-weight: bold;
	height: 150px;
	line-height: 35px;
}
#loginMent{
	background-color: white;
	font-weight: normal;
	font-size: 13px;
}
#loginBtn{
	border: 1px solid #BDBEC7;
	background-color: #F3F3F3;
	color: #777881;
}
#checkImsiDiv{
	display: none;
}
#checkBoxDiv{
	height: 140px; width: 50px;
	text-align: center; background-color: white;
	float:left;
}
#checkItems{
	margin-top: 63px;
}
#checkItems2{
	margin-top: 63px;
}
#productDiv{
	height: 135px; width: 648px;
	background-color: white;
	border: 0px solid red;
	margin-left: 40px;
}
#productImg{
	margin-top: 32px;
}
#productImgX{
	margin-top: 32px;
	opacity: 0.2;
}
#descriptionId{
	height: 100%; width: 530px;
	float: right;
	background-color: white;
}
#description1{
	height: 50px; width: 100%;
	border-bottom: 1px solid #DDDDDD;
	background-color: white;
	margin-top: 10px;
}
#description2{
	height: 65px; width: 100%;
	background-color: white;
	margin-top: 10px;
}
#productName{
	background-color: white; color: #555555;
	font-weight: bold;
	font-size: 15px;
}
#productName:hover{
	cursor: pointer;
	text-decoration: underline;
}
#arrival1, #arrival2{
	background-color: white; font-size: 13px;
}
#arrival1{
	color: #00891A;
}
#deliveryArea{
	font-weight: bold;
	color: red; font-size: 13px;
	background-color: white;
}
#soldOutMent{
	font-size: 13px;
	font-weight: bold;
	background-color: white;
}
#price_amount{
	height: 100%; width: 150px;
	float: right; background-color: white;
	text-align: right;
}
#priceFont{
	font-size: 13px;
	background-color: white;
	color: #777881;
	margin-right: 5px;
	float:center;
}
#selectAmount{
	background-color: white;
}
option{
	background-color: white;
}
#writeAmount{
	background-color: white;
	width: 30px;
}
#sakjeBtn{
	border: 1px solid #6E6E6E;
	color: #6E6E6E; background-color: white;
	margin-top: 5px;
	cursor: pointer;
}
#priceTd{
	text-align: center;
	font-size: 13px;
	background-color: white;
	border-left: 1px solid #DDDDDD;
}
#priceHap{
	height: 100px;
	text-align: center;
}
#sakjeAllBtn{
	position: absolute;
	margin-bottom: 10px;
	border: 1px solid #DDDDDD;
	background-color: white;
	height: 25px;
	margin-left: 35px;
	cursor: pointer;
}
#sakjeSoldoutBtn{
	position: absolute;
	margin-bottom: 10px;
	border: 1px solid #DDDDDD;
	background-color: white;
	height: 25px;
	margin-left: 110px;
	cursor: pointer;
}
#totalMent{
	background-color: white;
	font-size: 15px;
	color: #555555;
}
#price1, #price2{
	background-color: white;
	font-size: 18px;
	font-weight: bold;
}
#price3{
	background-color: white;
	font-size: 20px;
	font-weight: bold;
	color: #EA0000;
}
#btnDiv{
	padding-top: 30px; padding-bottom: 30px;
	background-color: white;
	text-align: center;
	border: 0px solid red;
}
#shopBtn{
	height: 60px; width: 180px;
	font-weight: bold; color: #0074E9; font-size: 18px;
	background-color: white; border: 2px solid #0074E9;
	border-radius: 5px;
	cursor: pointer
}
#buyBtn{
	height: 60px; width: 180px;
	font-weight: bold; color: white; font-size: 18px;
	background-color: #0074E9; border: 2px solid #0074E9;
	border-radius: 5px;
	cursor: pointer
}
</style>