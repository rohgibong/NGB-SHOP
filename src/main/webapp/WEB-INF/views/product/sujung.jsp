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

<form name="DirForm">
<input type="hidden" name="productCode" value="${dto.productCode }">
<table id="table" border="1">
	<tr>
		<td width="80px" align="center">상품이름</td>
		<td><input type="text" name="productName" value="${dto.productName }"></td>
	</tr>
	<tr>
		<td width="80px" align="center">상품이름</td>
		<td><input type="text" name="productDetailName" value="${dto.productDetailName }"></td>
	</tr>
	<tr>
		<td align="center">상품가격</td>
		<td><input type="text" name="productPrice" value="${dto.productPrice }" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"></td>
	</tr>
	<tr>
		<td align="center">상품설명</td>
		<td><textarea name="productDescription" style="width: 300px; height: 100px;">${dto.productDescription }</textarea></td>
	</tr>
	<tr>
		<td align="center">제조사</td>
		<td><input type="text" name="vendorName" value="${dto.vendorName }"></td>
	</tr>
	<tr>
		<td align="center">카테고리</td>
		<td>
			<select name="categoryCode">
				<c:forEach var="cateDto" items="${categoryList }">
					<c:if test="${dto.categoryCode == cateDto.categoryCode }">
						<option value="${cateDto.categoryCode }" selected>${cateDto.categoryName }</option>
					</c:if>
					<c:if test="${dto.categoryCode != cateDto.categoryCode }">
						<option value="${cateDto.categoryCode }">${cateDto.categoryName }</option>
					</c:if>
				</c:forEach>
			</select> &nbsp;
			<button type="button" onClick="chugaCate();">카테고리 추가</button> <a style="font-size: 11px;">(추가 후 새로고침)</a>
		</td>
	</tr>
	<tr>
		<td align="center">배송기간</td>
		<td>
			<input type="text" name="deliveryPeriod" value="${dto.deliveryPeriod }" style="width: 30px;" maxlength="2" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
			<a id="fontId">일</a>
		</td>
	</tr>
	<tr>
		<td align="center">배송비</td>
		<td>
			<input type="text" name="deliveryPrice" value="${dto.deliveryPrice }" style="width: 70px;" maxlength="5" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
			<a id="fontId">원</a>
		</td>
	</tr>
	<tr>
		<td align="center">배송지역</td>
		<td>
			<select name="deliveryArea">
				<c:if test="${dto.deliveryArea == '국내' }">			
					<option value="국내" selected>국내</option>
					<option value="해외">해외</option>
				</c:if>
				<c:if test="${dto.deliveryArea == '해외' }">			
					<option value="국내">국내</option>
					<option value="해외" selected>해외</option>
				</c:if>
			</select>
			<a id="fontId">배송</a>
		</td>
	</tr>
	<tr>
		<td align="center">제품사진</td>
		<td>
			<input type="file" name="file"><br><a style="font-size: 11px;">(수정 할때만 첨부 / 첨부 안할 시 기존 사진으로 수정)</a>
			<input type="hidden" name="imsiAttach" value="${dto.attachInfo }"><br>
		</td>
	</tr>
	<tr>
		<td align="center">사용</td>
		<td>
			<c:if test="${dto.useable == 'O'}">
				<input type="radio" name="useable" value="O" checked> O &nbsp;
				<input type="radio" name="useable" value="X"> X
			</c:if>
			<c:if test="${dto.useable == 'X'}">
				<input type="radio" name="useable" value="O"> O &nbsp;
				<input type="radio" name="useable" value="X"checked> X
			</c:if>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<button type="button" onClick="sujung();">수정하기</button>
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

function sujung(){
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
	if(confirm('수정할까요?')){
		if(document.DirForm.file.value == ''){
			document.DirForm.action = "${path }/product/sujungProc";
			document.DirForm.method = "post";
			document.DirForm.submit();
		} else{
			document.DirForm.enctype="multipart/form-data";
			document.DirForm.action = "${path }/product/sujungProcAttach";
			document.DirForm.method = "post";
			document.DirForm.submit();
		}
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
</style>