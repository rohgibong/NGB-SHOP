<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>

<c:if test="${memberNo != 1}">
	<script>
		location.href="${path }/member/warning";
	</script>
</c:if>

<div id="catePage">

<div id="img">
<a href="${path }">
	<img src="${path }/attach${path}/logo/ngbshop.png" width='230' height='45'>
</a>
</div>

<form name="DirForm">
<table id="table" border="1">
	<tr>
		<td align="center">카테고리</td>
		<td><input type="text" name="categoryName"></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<button type="button" onClick="save();">등록하기</button>
			&nbsp;
			<button type="button" onClick="location.href='${path}/category/list'">목록으로</button>
		</td>
	</tr>
</table>
</form>

</div>

<script>
function save(){
	if(document.DirForm.categoryName.value == ''){
		alert('카테고리 이름을 입력해주세요.');
		document.DirForm.categoryName.focus();
		return;
	}
	
	if(confirm('등록할까요?')){
		document.DirForm.action = "${path }/category/chugaProc";
		document.DirForm.method = "post";
		document.DirForm.submit();
	}
}


</script>

<style>
#catePage{
	border: 0px solid red; width: 600px; margin: auto; padding-top: 20px;
}
#img{
	text-align: center; margin-bottom: 20px;
}
#table{
	margin: auto; border-collapse: collapse; width: 300px;
}
</style>