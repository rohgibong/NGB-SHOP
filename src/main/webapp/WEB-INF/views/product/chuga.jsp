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

<form name="DirForm">
<table id="table" border="1">
	<tr>
		<td width="100px" align="center">상품이름</td>
		<td><input type="text" name="productName"></td>
	</tr>
	<tr>
		<td align="center">상품상세이름</td>
		<td><input type="text" name="productDetailName"><br><a style="font-size: 12px;">리스트에서 보여질 이름 ex)이름, 상품코드, 색상</a></td>
	</tr>
	<tr>
		<td align="center">상품가격</td>
		<td>
			<input type="text" name="productPrice" style="width: 100px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
			<a id="fontId">원</a>
		</td>
	</tr>
	<tr>
		<td align="center">상품설명</td>
		<td><textarea name="productDescription" style="width: 300px; height: 100px;"></textarea></td>
	</tr>
	<tr>
		<td align="center">제조사</td>
		<td><input type="text" name="vendorName"></td>
	</tr>
	<tr>
		<td align="center">카테고리</td>
		<td>
			<select name="categoryCode">
				<option value="0">--선택--</option>
				<c:forEach var="cateDto" items="${categoryList }">
					<option value="${cateDto.categoryCode }">${cateDto.categoryName }</option>
				</c:forEach>
			</select> &nbsp;
			<button type="button" onClick="chugaCate();">카테고리 추가</button> <a style="font-size: 11px;">(추가 후 새로고침)</a>
		</td>
	</tr>
	<tr>
		<td align="center">배송기간</td>
		<td>
			<input type="text" name="deliveryPeriod" value="1" style="width: 30px;" maxlength="2" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
			<a id="fontId">일</a>
		</td>
	</tr>
	<tr>
		<td align="center">배송비</td>
		<td>
			<input type="text" name="deliveryPrice" value="0" style="width: 70px;" maxlength="5" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
			<a id="fontId">원</a>
		</td>
	</tr>
	<tr>
		<td align="center">배송지역</td>
		<td>
			<select name="deliveryArea">
				<option value="국내">국내</option>
				<option value="해외">해외</option>
			</select>
			<a id="fontId">배송</a>
		</td>
	</tr>
	<tr>
		<td align="center">제품사진</td>
		<td>
			<input type="file" name="file">
		</td>
	</tr>
	<tr>
		<td align="center">사용</td>
		<td>
			<input type="radio" name="useable" value="O" checked> O &nbsp;
			<input type="radio" name="useable" value="X"> X
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<button type="button" onClick="save();">등록하기</button>
			&nbsp;
			<button type="button" onClick="location.href='${path}/product/list'">목록으로</button>
		</td>
	</tr>
</table>
</form>

</div>

<script>
function chugaCate(){
	window.open("${path}/category/chuga", "chugaCate", "width=700, height=300, toolbar=no, menubar=no, scrollbars=no, resizable=yes");
}

function save(){
	if(document.DirForm.productName.value == ''){
		alert("상품이름을 입력해주세요.");
		document.DirForm.productName.focus();
		return;
	}
	if(document.DirForm.productPrice.value == ''){
		alert("상품가격을 입력해주세요.");
		document.DirForm.productPrice.focus();
		return;
	}
	if(document.DirForm.productPrice.value <= 0){
		alert("상품가격을 정확하게 입력해주세요.");
		document.DirForm.productPrice.focus();
		return;
	}
	if(document.DirForm.productDescription.value == ''){
		alert("상품설명을 입력해주세요.");
		document.DirForm.productDescription.focus();
		return;
	}
	if(document.DirForm.vendorName.value == ''){
		alert("제조사를 입력해주세요.");
		return;
	}
	if(document.DirForm.categoryCode.value == 0){
		alert("카테고리를 선택해주세요.");
		return;
	}
	if(document.DirForm.file.value == ''){
		alert('사진을 등록해주세요.');
		return;
	}
	if(document.DirForm.deliveryPeriod.value == ''){
		alert("배송기간을 입력해주세요.");
		document.DirForm.deliveryPeriod.focus();
		return;
	}
	if(document.DirForm.deliveryPeriod.value <= 0){
		alert("배송기간을 정확하게 입력해주세요.");
		document.DirForm.deliveryPeriod.focus();
		return;
	}
	if(document.DirForm.deliveryPrice.value == ''){
		alert("배송비를 입력해주세요.");
		document.DirForm.deliveryPrice.focus();
		return;
	}
	if(document.DirForm.deliveryPrice.value < 0){
		alert("배송비를 정확하게 입력해주세요.");
		document.DirForm.deliveryPrice.focus();
		return;
	}
	if(confirm('저장할까요?')){
		document.DirForm.enctype="multipart/form-data";
		document.DirForm.action = "${path }/product/chugaProc";
		document.DirForm.method = "post";
		document.DirForm.submit();
	}
}
</script>

<style>
#productPage{
	border: 0px solid red; width: 700px; margin: auto; padding-top: 20px;
}
#img{
	text-align: center; margin-bottom: 20px;
}
#table{
	margin: auto; border-collapse: collapse; width: 500px;
}
#fontId{
	font-size: 13px;
}
</style>