<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="sideMenu">

<div id="sideDivTitle">
	<h3>카테고리</h3>
</div>
	<div id="sideDiv" onClick="location.href='${path }/shop/list?categoryCode=1'">
		<a id="menuName">패션의류/잡화</a>
	</div>
	<div id="sideDiv" onClick="location.href='${path }/shop/list?categoryCode=2'">
		<a id="menuName">뷰티</a> <br>
	</div>
	<div id="sideDiv" onClick="location.href='${path }/shop/list?categoryCode=3'">
		<a id="menuName">출산/유아동</a> <br>
	</div>
	<div id="sideDiv" onClick="location.href='${path }/shop/list?categoryCode=4'">
		<a id="menuName">식품</a> <br>
	</div>
	<div id="sideDiv" onClick="location.href='${path }/shop/list?categoryCode=5'">
		<a id="menuName">주방용품</a> <br>
	</div>
	<div id="sideDiv" onClick="location.href='${path }/shop/list?categoryCode=6'">
		<a id="menuName">생활용품</a> <br>
	</div>
	<div id="sideDiv" onClick="location.href='${path }/shop/list?categoryCode=7'">
		<a id="menuName">홈인테리어</a> <br>
	</div>
	<div id="sideDiv" onClick="location.href='${path }/shop/list?categoryCode=8'">
		<a id="menuName">가전/디지털</a> <br>
	</div>
	<div id="sideDiv" onClick="location.href='${path }/shop/list?categoryCode=9'">
		<a id="menuName">스포츠/레저</a> <br>
	</div>
	<div id="sideDiv" onClick="location.href='${path }/shop/list?categoryCode=10'">
		<a id="menuName">자동차용품</a> <br>
	</div>
	<div id="sideDiv" onClick="location.href='${path }/shop/list?categoryCode=11'">
		<a id="menuName">도서/음반/DVD</a> <br>
	</div>
	<div id="sideDiv" onClick="location.href='${path }/shop/list?categoryCode=12'">
		<a id="menuName">완구/취미</a> <br>
	</div>
	<div id="sideDiv" onClick="location.href='${path }/shop/list?categoryCode=13'">
		<a id="menuName">문구/오피스</a> <br>
	</div>
	<div id="sideDiv" onClick="location.href='${path }/shop/list?categoryCode=14'">
		<a id="menuName">반려동물용품</a> <br>
	</div>
	<div id="sideDiv" onClick="location.href='${path }/shop/list?categoryCode=15'">
		<a id="menuName">헬스/건강식품</a> <br>
	</div>
	
	
</div>


<style>
#sideMenu{
	border-left: 1px solid #DCDCDC; border-right: 1px solid #DCDCDC;
	width: 200px; height: 700px; float: left;
}
#sideDivTitle{
	padding-left: 20px;
}
#sideDiv{
	border: 0px solid red; height: 20px; line-height: 20px; padding-left: 20px; margin-top: 10px;
}
#sideDiv:hover {
 	cursor: pointer;
}
#sideDiv:hover #menuName {
 	 color: #0074E9;
}
#menuName{
	text-decoration: none; color: #666666; font-size: 13px; padding-left: 20px;
}
</style>