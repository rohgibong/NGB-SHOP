<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

<c:if test="${memberNo != 1}">
	<script>
		location.href="${path }/member/warning";
	</script>
</c:if>

<div id="productPage">

<div id="img">
<a href="${path }">
	<img src="${path }/attach${path}/logo/ngbshop.png" width='230' height='45'>
</a>
</div>

<table id="table" border="1">
	<tr>
		<td width="300px">
			<c:set var="imsiArray" value="${fn:split(dto.attachInfo, ',') }" />
			<c:set var="imsiImg" value="${imsiArray[1] }" />
			
			<img src="${path}/attach${path}/product/${imsiImg }" width='300' height='300'>
		</td>
		<td height="500px">
			<div style="border: 0px solid red; height: 50px; font-size: 20px; font-weight: bold;" >
				${dto.productName } <br>
			</div>
			<div style="border: 0px solid red; height: 30px; font-size: 20px" >
				<fmt:formatNumber value="${dto.productPrice }" pattern="#,###" />원<br><br>
			</div>
			<div style="border: 0px solid red;" id="content">
				${dto.productDescription }
			</div>
			<br>
			<hr>
			제조사 : 	${dto.vendorName }<br><br>
			카테고리 : <c:forEach var="cateDto" items="${categoryList }">
						<c:if test="${dto.categoryCode == cateDto.categoryCode }">
							${cateDto.categoryName }
						</c:if>
					</c:forEach> <br><br>
			<c:set var="imsiArrival" value="${fn:split(dto.arrivalDate, '-') }" />
			<c:set var="month" value="${imsiArrival[1] }" />		
			<c:set var="day" value="${imsiArrival[2] }" />
			배송예정일 : 
			<c:if test="${dto.deliveryPeriod == '1' }">
			내일
			</c:if>
			<c:if test="${dto.deliveryPeriod == '2' }">
			모레
			</c:if>
			<a style="color: red; font-weight: bold;">${month }/${day }</a> 도착 예정<br><br>
			배송비 : <fmt:formatNumber value="${dto.deliveryPrice }" pattern="#,###" />원
			<c:if test="${dto.deliveryArea == '해외' }">
				<a style="font-weight: bold;">(해외배송)</a>
			</c:if>
			<br><br>
			판매여부 : ${dto.useable } (품절이면 X)<br><br>
			등록일 : ${dto.regiDate } <br>
		</td>
	</tr>
</table>
<div id="btnDiv">
	<button type="button" onClick="sujung();" id="btn1">수정</button>&nbsp;
	<button type="button" onClick="sakje();" id="btn2">삭제</button>&nbsp;
	<button type="button" onClick="location.href='${path}/product/list'" id="btn3">목록</button>
</div>

<form name="sakjeForm">
<input type="hidden" name="productCode" value="${dto.productCode }">
</form>

</div>

<script>
$(document).ready(function(){
	var content = $("#content").text().replace(/(?:\r\n|\r|\n)/g,'<br/>');
	$("#content").html(content);
});

function sujung(){
	location.href = "${path}/product/sujung?productCode="+${dto.productCode };
}
function sakje(){
	if(confirm('삭제할까요?')){
		document.sakjeForm.action = "${path }/product/sakjeProc";
		document.sakjeForm.method = "post";
		document.sakjeForm.submit();
	}
}
</script>

<style>
#productPage{
	border: 0px solid red; width: 900px; margin: auto; padding-top: 20px;
}
#img{
	text-align: center; margin-bottom: 20px;
}
#table{
	margin: auto; border-collapse: collapse; width: 700px;
}
#btnDiv{
	text-align: center; margin-top: 10px;
}
#btn1{
	 height: 30px; width: 60px; font-weight: bold; color: white; background-color: #880015; border: none; border-radius: 5px 5px;
}
#btn2{
	 height: 30px; width: 60px; font-weight: bold; color: white; background-color: #FF7F27; border: none; border-radius: 5px 5px;
}
#btn3{
	 height: 30px; width: 60px; font-weight: bold; color: white; background-color: #FFC90E; border: none; border-radius: 5px 5px;
}
</style>