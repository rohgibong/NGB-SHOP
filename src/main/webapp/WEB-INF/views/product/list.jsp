<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>

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
		<th width="30px">No</th>
		<th>상품이름</th>
		<th>상품가격</th>
		<th>제조사</th>
		<th>카테고리</th>
		<th width="40px">사용</th>
		<th width="90px">등록일</th>
		<th width="120px">비고</th>
	</tr>
	<c:if test="${list.size() == 0 }">
		<tr>
			<td colspan="8" align="center" height="200">등록된 상품이 없습니다.</td>
		</tr>
	</c:if>
	
	<c:set var="number" value="${list.size() }" />
	<c:forEach var="productDto" items="${list }">
		<tr align="center">
			<td>
				<font style="font-weight: bold;">${number }</font>
				<c:set var="number" value="${number - 1 }" />
			</td>
			<td>
				<a href="#" onClick="move('view', '${productDto.productCode}');">${productDto.productName }</a>
			</td>
			<td>
				<fmt:formatNumber value="${productDto.productPrice }" pattern="#,###" />원
			</td>
			<td>
				${productDto.vendorName }
			</td>
			<td>
				<c:forEach var="categoryDto" items="${categoryList }">
					<c:if test="${productDto.categoryCode == categoryDto.categoryCode }">
						${categoryDto.categoryName }
					</c:if>
				</c:forEach>
			</td>
			<td>
				${productDto.useable }
			</td>
			<td>
				${productDto.regiDate }
			</td>
			<td align="center">
			<a href="#" onClick="move('sujung', '${productDto.productCode }');">[수정]</a>
			/
			<a href="#" onClick="sakje('${productDto.productCode}');">[삭제]</a>
			</td>
		</tr>
	</c:forEach>
	
</table>

<div id="btnDiv">
	<button type="button" onClick="move('chuga', '');" id="chugaBtn">추가</button>
</div>

</div>

<form name="sakjeForm">
<input type="hidden" name="productCode">
</form>

<script>
function move(value1, value2){
	location.href = "${path}/product/"+value1+"?productCode="+value2;
}
function sakje(value1){
	if(confirm('삭제할까요?')){
		document.sakjeForm.productCode.value = value1;
		document.sakjeForm.action = "${path }/product/sakjeProc";
		document.sakjeForm.method = "post";
		document.sakjeForm.submit();
	}
}
</script>

<style>
#productPage{
	width: 1200px; margin: auto; padding-top: 20px;
}
#img{
	text-align: center; margin-bottom: 20px;
}
#table{
	margin: auto; border-collapse: collapse; width: 1200px;
}
#btnDiv{
	text-align: right; margin-top: 10px;
}
#chugaBtn{
	height: 30px; width: 60px;
	font-weight: bold; color: white;
	background-color: #0074E9;
	border: none; border-radius: 5px 5px;
}

</style>