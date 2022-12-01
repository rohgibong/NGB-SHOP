<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>


<c:if test="${!(folderName == 'shop' && fileName == 'list')}">
<div id="categoryDiv">
	<div id="categoryBtn">
		<a id="categoryIcon">≡</a><br>
		<a id="category">카테고리</a>
	</div>
	<div id="categoryList">
		<div class="categoryMenu" onClick="location.href='${path }/shop/list?categoryCode=1'">
			<a id="categoryName">패션의류/잡화</a>
		</div>
		<div class="categoryMenu" onClick="location.href='${path }/shop/list?categoryCode=2'">
			<a id="categoryName">뷰티</a>
		</div>
		<div class="categoryMenu" onClick="location.href='${path }/shop/list?categoryCode=3'">
			<a id="categoryName">출산/유아동</a>
		</div>
		<div class="categoryMenu" onClick="location.href='${path }/shop/list?categoryCode=4'">
			<a id="categoryName">식품</a>
		</div>
		<div class="categoryMenu" onClick="location.href='${path }/shop/list?categoryCode=5'">
			<a id="categoryName">주방용품</a>
		</div>
		<div class="categoryMenu" onClick="location.href='${path }/shop/list?categoryCode=6'">
			<a id="categoryName">생활용품</a>
		</div>
		<div class="categoryMenu" onClick="location.href='${path }/shop/list?categoryCode=7'">
			<a id="categoryName">홈인테리어</a>
		</div>
		<div class="categoryMenu" onClick="location.href='${path }/shop/list?categoryCode=8'">
			<a id="categoryName">가전/디지털</a>
		</div>
		<div class="categoryMenu" onClick="location.href='${path }/shop/list?categoryCode=9'">
			<a id="categoryName">스포츠/레저</a>
		</div>
		<div class="categoryMenu" onClick="location.href='${path }/shop/list?categoryCode=10'">
			<a id="categoryName">자동차용품</a>
		</div>
		<div class="categoryMenu" onClick="location.href='${path }/shop/list?categoryCode=11'">
			<a id="categoryName">도서/음반/DVD</a>
		</div>
		<div class="categoryMenu" onClick="location.href='${path }/shop/list?categoryCode=12'">
			<a id="categoryName">완구/취미</a>
		</div>
		<div class="categoryMenu" onClick="location.href='${path }/shop/list?categoryCode=13'">
			<a id="categoryName">문구/오피스</a>
		</div>
		<div class="categoryMenu" onClick="location.href='${path }/shop/list?categoryCode=14'">
			<a id="categoryName">반려동물용품</a>
		</div>
		<div class="categoryMenu" onClick="location.href='${path }/shop/list?categoryCode=15'">
			<a id="categoryName">헬스/건강식품</a>
		</div>
	</div>
</div>
</c:if>
<div id="img">
	<a href="${path }">
		<img src="${path }/attach${path}/logo/ngbshop.png" width='230' height='45'>
	</a>
</div>
<div id="searchDiv">
	<form name="searchForm">
	<div id="searchCate" onClick="showAndClose();">
		<a id="searchCateAll">전체</a><a id="arrow">▼</a>
		<input type="hidden" name="searchGubun" id="searchGubun" value="0">
	</div>
	<input type="text" name="searchData" id="searchData" placeholder="찾고 싶은 상품을 검색해보세요!" value="${searchData }">
	<img src="${path }/attach${path}/logo/search.png" id="searchBtn" width='35' height='35' onClick="search();">
	</form>
</div>
<div id="searchCateList">
	<div id="searchCateMenu0" class="searchCateMenu">
		<a id="searchCateName0" class="searchCateName">전체</a>
		<input type="hidden" id="searchCateName0_0" value="0">
	</div>
	<div id="searchCateMenu1" class="searchCateMenu">
		<a id="searchCateName1" class="searchCateName">패션의류/잡화</a>
		<input type="hidden" id="searchCateName1_1" value="1">
	</div>
	<div id="searchCateMenu2" class="searchCateMenu">
		<a id="searchCateName2" class="searchCateName">뷰티</a>
		<input type="hidden" id="searchCateName2_2" value="2">
	</div>
	<div id="searchCateMenu3" class="searchCateMenu">
		<a id="searchCateName3" class="searchCateName">출산/유아동</a>
		<input type="hidden" id="searchCateName3_3" value="3">
	</div>
	<div id="searchCateMenu4" class="searchCateMenu">
		<a id="searchCateName4" class="searchCateName">식품</a>
		<input type="hidden" id="searchCateName4_4" value="4">
	</div>
	<div id="searchCateMenu5" class="searchCateMenu">
		<a id="searchCateName5" class="searchCateName">주방용품</a>
		<input type="hidden" id="searchCateName5_5" value="5">
	</div>
	<div id="searchCateMenu6" class="searchCateMenu">
		<a id="searchCateName6" class="searchCateName">생활용품</a>
		<input type="hidden" id="searchCateName6_6" value="6">
	</div>
	<div id="searchCateMenu7" class="searchCateMenu">
		<a id="searchCateName7" class="searchCateName">홈인테리어</a>
		<input type="hidden" id="searchCateName7_7" value="7">
	</div>
	<div id="searchCateMenu8" class="searchCateMenu">
		<a id="searchCateName8" class="searchCateName">가전/디지털</a>
		<input type="hidden" id="searchCateName8_8" value="8">
	</div>
	<div id="searchCateMenu9" class="searchCateMenu">
		<a id="searchCateName9" class="searchCateName">스포츠/레저</a>
		<input type="hidden" id="searchCateName9_9" value="9">
	</div>
	<div id="searchCateMenu10" class="searchCateMenu">
		<a id="searchCateName10" class="searchCateName">자동차용품</a>
		<input type="hidden" id="searchCateName10_10" value="10">
	</div>
	<div id="searchCateMenu11" class="searchCateMenu">
		<a id="searchCateName11" class="searchCateName">도서/음반/DVD</a>
		<input type="hidden" id="searchCateName11_11" value="11">
	</div>
	<div id="searchCateMenu12" class="searchCateMenu">
		<a id="searchCateName12" class="searchCateName">완구/취미</a>
		<input type="hidden" id="searchCateName12_12" value="12">
	</div>
	<div id="searchCateMenu13" class="searchCateMenu">
		<a id="searchCateName13" class="searchCateName">문구/오피스</a>
		<input type="hidden" id="searchCateName13_13" value="13">
	</div>
	<div id="searchCateMenu14" class="searchCateMenu">
		<a id="searchCateName14" class="searchCateName">반려동물용품</a>
		<input type="hidden" id="searchCateName14_14" value="14">
	</div>
	<div id="searchCateMenu15" class="searchCateMenu">
		<a id="searchCateName15" class="searchCateName">헬스/건강식품</a>
		<input type="hidden" id="searchCateName15_15" value="15">
	</div>
</div>
<div id="myPage_cart">
	<div id="myPageBtn">
		<img src="${path }/attach${path}/logo/myPage.png" id="myPageImg" width='35' height='35' onClick="boughtProduct();"><br>
		<a id="myPageMent" onClick="boughtProduct();">MyPage</a>
		<div id="myPageList">
			<div id="buyProductListBtn">
				<a id="buyListId" onClick="boughtProduct();">주문목록</a>
			</div>
			<div id="sujungBtn">
				<a id="sujungId" onClick="changeUserInfo();">회원정보<br>수정</a>
			</div>
		</div>
	</div>
	<div id="cartBtn" onClick="location.href='${path}/shop/cartList'">
		<img src="${path }/attach${path}/logo/cart.png" id="cartImg" width='40' height='35'><br>
		<a id="cartMent">장바구니</a>
	</div>
</div>



<script>
function showAndClose(){
	if(searchCateList.style.visibility == 'hidden'){
		searchCateList.style.visibility = 'visible';
	} else {
		searchCateList.style.visibility = 'hidden';
	}
}

function search(){
	var searchGubun = $("#searchGubun").val();
	var searchData = $("#searchData").val();
	if(searchData == ''){
		alert('검색어를 입력해주세요.');
		return;
	}
	document.searchForm.action = "${path}/shop/list";
	document.searchForm.method = "post";
	document.searchForm.submit();
}


function boughtProduct(){
	var memberNo = document.userForm.memberCode.value;
	if(memberNo == ''){
		location.href = "${path}/member/login";
	} else {
		document.userForm.action = "${path}/shop/boughtProduct";
		document.userForm.method = "post";
		document.userForm.submit();
	}
}

function changeUserInfo(){
	var memberNo = document.userForm.memberCode.value;
	if(memberNo == ''){
		location.href = "${path}/member/login";
	} else {
		document.userForm.action = "${path}/member/checkPw";
		document.userForm.method = "post";
		document.userForm.submit();
	}
}

var searchCateName0 = $("#searchCateName0").text();
var searchCateName0_0 = $("#searchCateName0_0").val();
$('#searchCateMenu0').click(function(){
	$('#searchCateAll').text(searchCateName0);
	$('#searchGubun').val(searchCateName0_0);
	searchCateList.style.visibility = 'hidden';
})
var searchCateName1 = $("#searchCateName1").text();
var searchCateName1_1 = $("#searchCateName1_1").val();
$('#searchCateMenu1').click(function(){
	$('#searchCateAll').text(searchCateName1);
	$('#searchGubun').val(searchCateName1_1);
	searchCateList.style.visibility = 'hidden';
})
var searchCateName2 = $("#searchCateName2").text();
var searchCateName2_2 = $("#searchCateName2_2").val();
$('#searchCateMenu2').click(function(){
	$('#searchCateAll').text(searchCateName2);
	$('#searchGubun').val(searchCateName2_2);
	searchCateList.style.visibility = 'hidden';
})
var searchCateName3 = $("#searchCateName3").text();
var searchCateName3_3 = $("#searchCateName3_3").val();
$('#searchCateMenu3').click(function(){
	$('#searchCateAll').text(searchCateName3);
	$('#searchGubun').val(searchCateName3_3);
	searchCateList.style.visibility = 'hidden';
})
var searchCateName4 = $("#searchCateName4").text();
var searchCateName4_4 = $("#searchCateName4_4").val();
$('#searchCateMenu4').click(function(){
	$('#searchCateAll').text(searchCateName4);
	$('#searchGubun').val(searchCateName4_4);
	searchCateList.style.visibility = 'hidden';
})
var searchCateName5 = $("#searchCateName5").text();
var searchCateName5_5 = $("#searchCateName5_5").val();
$('#searchCateMenu5').click(function(){
	$('#searchCateAll').text(searchCateName5);
	$('#searchGubun').val(searchCateName5_5);
	searchCateList.style.visibility = 'hidden';
})
var searchCateName6 = $("#searchCateName6").text();
var searchCateName6_6 = $("#searchCateName6_6").val();
$('#searchCateMenu6').click(function(){
	$('#searchCateAll').text(searchCateName6);
	$('#searchGubun').val(searchCateName6_6);
	searchCateList.style.visibility = 'hidden';
})
var searchCateName7 = $("#searchCateName7").text();
var searchCateName7_7 = $("#searchCateName7_7").val();
$('#searchCateMenu7').click(function(){
	$('#searchCateAll').text(searchCateName7);
	$('#searchGubun').val(searchCateName7_7);
	searchCateList.style.visibility = 'hidden';
})
var searchCateName8 = $("#searchCateName8").text();
var searchCateName8_8 = $("#searchCateName8_8").val();
$('#searchCateMenu8').click(function(){
	$('#searchCateAll').text(searchCateName8);
	$('#searchGubun').val(searchCateName8_8);
	searchCateList.style.visibility = 'hidden';
})
var searchCateName9 = $("#searchCateName9").text();
var searchCateName9_9 = $("#searchCateName9_9").val();
$('#searchCateMenu9').click(function(){
	$('#searchCateAll').text(searchCateName9);
	$('#searchGubun').val(searchCateName9_9);
	searchCateList.style.visibility = 'hidden';
})
var searchCateName10 = $("#searchCateName10").text();
var searchCateName10_10 = $("#searchCateName10_10").val();
$('#searchCateMenu10').click(function(){
	$('#searchCateAll').text(searchCateName10);
	$('#searchGubun').val(searchCateName10_10);
	searchCateList.style.visibility = 'hidden';
})
var searchCateName11 = $("#searchCateName11").text();
var searchCateName11_11 = $("#searchCateName11_11").val();
$('#searchCateMenu11').click(function(){
	$('#searchCateAll').text(searchCateName11);
	$('#searchGubun').val(searchCateName11_11);
	searchCateList.style.visibility = 'hidden';
})
var searchCateName12 = $("#searchCateName12").text();
var searchCateName12_12 = $("#searchCateName12_12").val();
$('#searchCateMenu12').click(function(){
	$('#searchCateAll').text(searchCateName12);
	$('#searchGubun').val(searchCateName12_12);
	searchCateList.style.visibility = 'hidden';
})
var searchCateName13 = $("#searchCateName13").text();
var searchCateName13_13 = $("#searchCateName13_13").val();
$('#searchCateMenu13').click(function(){
	$('#searchCateAll').text(searchCateName13);
	$('#searchGubun').val(searchCateName13_13);
	searchCateList.style.visibility = 'hidden';
})
var searchCateName14 = $("#searchCateName14").text();
var searchCateName14_14 = $("#searchCateName14_14").val();
$('#searchCateMenu14').click(function(){
	$('#searchCateAll').text(searchCateName14);
	$('#searchGubun').val(searchCateName14_14);
	searchCateList.style.visibility = 'hidden';
})
var searchCateName15 = $("#searchCateName15").text();
var searchCateName15_15 = $("#searchCateName15_15").val();
$('#searchCateMenu15').click(function(){
	$('#searchCateAll').text(searchCateName15);
	$('#searchGubun').val(searchCateName15_15);
	searchCateList.style.visibility = 'hidden';
})
</script>

<style>
#categoryDiv:hover #categoryList{
	display: block;
}
#categoryList{
	top: 135px;	position: absolute; border: 1px solid lightgray; display: none;
}
.categoryMenu{
	background: white; width: 150px; height: 35px; text-align: center; line-height: 35px; font-size: 13px;
}
.categoryMenu:hover {
	background-color: lightgray; cursor: pointer;
}
#categoryBtn{
	width: 100px; height: 105px; background-color: #4285F4; text-align: center; color: white;
	position: absolute;
}
#categoryIcon{
	font-size: 60px; line-height: 65px; cursor: default;
}
#category{
	font-size: 13px; cursor: default;
}
#categoryName{
	text-decoration: none; color: #666666
}
#img{
	margin-left: 140px; margin-top: 30px;
	position: absolute;
}
#searchDiv{
	margin-left: 400px; margin-top: 30px;
	height: 40px;
	position: absolute;
	border: 2px solid #4285F4;
}
#searchCate{
	width: 110px; height: 30px;
	padding: 11px 0px 0px 10px;
	font-size: 13px;
	border-right: 1px solid #DCDCDC;
	position: absolute;
}
#arrow{
	float: right;
	padding-right: 5px;
}
#searchCateList{
	margin-left: 400px; margin-top: 73px;
	width: 121px; height: 496px;
	position: absolute;
	background-color: white;
	visibility: hidden;
}
.searchCateMenu{
	text-align: center;
	height: 30px;
	line-height: 30px;
	border-bottom: 1px solid #DCDCDC;
	border-left: 1px solid #DCDCDC;
	border-right: 1px solid #DCDCDC;
}
.searchCateMenu:hover {
	background-color: lightgray; cursor: pointer;
}
.searchCateName{
	font-size: 13px;
}
#searchData{
	margin-left: 122px;
	padding-left: 10px;
	height: 40px;
	font-size: 15px;
	border: 0px;
	outline: 0px;
	position: absolute;
}
#searchBtn{
	float: right;
	padding-right: 5px;
}
#myPage_cart{
	float: right; margin-top: 30px;
	height: 60px; width: 140px;
}
#myPageBtn{
	float: left;
	height: 125px; width: 60px;
	text-align: center;
}
#myPageImg{
	margin-left: 5px;
	margin-right: 5px;
}
#myPageMent{
	margin-left: 10px;
	margin-right: 10px;
}
#cartBtn{
	float: left;
	height: 50px; width: 50px;
	margin-left: 5px;
	text-align: center;
}
#myPageMent, #cartMent{
	font-size: 12px;
	font-weight: bold;
}
#searchCate:hover, #searchBtn:hover, #myPageBtn:hover, #cartBtn:hover {
	cursor: pointer;
}
#myPageBtn:hover #myPageList{
	display: block;
}
#myPageList{
	width: 60px; height: 70px;
	border: 1px solid #DDDDDD;
	position: absolute;
	margin-top: 5px;
	display: none;
}
#buyProductListBtn, #sujungBtn{
	width: 100%; height: 49%;
	text-align: center;
	font-size: 12px;
	background-color: white;
	color: #666666;
}
#buyProductListBtn{
	border-bottom: 1px solid #DDDDDD;
	line-height: 35px;
}
#buyListId:hover, #sujungid:hover{
	text-decoration: underline;
}
</style>