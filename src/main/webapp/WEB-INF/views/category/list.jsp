<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

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

<table id="table" border="1">
	<tr>
		<th width="30px">No</th>
		<th>카테고리</th>
		<th width="90px">등록일</th>
		<th width="50px">비고</th>
	</tr>
	
	<c:if test="${list.size() == 0 }">
	<tr>
		<td colspan="5" height="200" align="center">등록된 카테고리가 없습니다.</td>
	</tr>
	</c:if>
	
	<c:set var="number" value="${list.size() }" />
	<c:forEach var="dto" items="${list }">
	<tr>
		<td align="center"><font style="font-weight: bold;">${number }</font></td>
		<c:set var="number" value="${number - 1 }" />
		<td align="center">
			<input type="text" name="imsiName" id="imsiName" value="${dto.categoryName }" onChange="sujung(this.value, ${dto.categoryCode });">
		</td>
		<td align="center">${dto.regiDate }</td>
		<td align="center">
		<a href="#" onClick="sakje('${dto.categoryCode}');">[삭제]</a>
		</td>
	</tr>
	<c:set var="num" value="${num - 1 }" />
	</c:forEach>
</table>


<form name="DirForm">
	<input type="hidden" name="categoryCode">
	<input type="hidden" name="categoryName">
</form>

<form name="chugaForm">
<table id="chugaTable" border="1">
	<tr>
		<td align="center">카테고리</td>
		<td>
			<input type="text" name="categoryName"><br>
			<label id="label_categoryName"></label>
		</td>
	</tr>
</table>

<div id="btnDiv">
	<button type="button" onClick="chuga();" id="chugaBtn">추가</button>
</div>
</form>

</div>

<script>
function chuga(){
	var categoryName = document.chugaForm.categoryName.value;
	if(categoryName ==''){
		$("#label_categoryName").html("카테고리를 입력하세요.");
		$("#label_categoryName").css('color', 'red');
		$("#label_categoryName").css('font-size', '8px');
		return;
	}
	$.ajax({
		type: "post",
		data: {
			"categoryName" : categoryName
		},
		url: "${path }/category/chugaProc",
		success : function(result){
			if(result > 0){
				location.reload();
			} else {
				$("#label_categoryName").html("카테고리 등록 중 오류 발생.");
				$("#label_categoryName").css('color', 'red');
				$("#label_categoryName").css('font-size', '8px');
			}
		}
	});
}
function sujung(value1, value2){
	if(value1 == ''){
		alert('카테고리명을 입력한 후 수정해주세요.');
		location.reload();
		return;
	}
	$.ajax({
		type: "post",
		data: {
				"categoryName" : value1,
				"categoryCode" : value2
			},
		url: "${path }/category/sujungProc",
		success : function(result){
			if(result > 0){
				location.reload();
			} else{
				alert('수정 중 오류가 발생했습니다.');
			}
		}
	});
}
function sakje(value1){
	if(confirm('삭제할까요?')){
		$.ajax({
			type: "post",
			data: {
					"categoryCode" : value1
				},
			url: "${path }/category/sakjeProc",
			success : function(result){
				if(result > 0){
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
#catePage{
	border: 0px solid red; width: 470px; margin: auto; padding-top: 20px;
}
#img{
	text-align: center; margin-bottom: 20px;
}
#table{
	margin: auto; border-collapse: collapse; width: 370px;
}
#imsiName{
	border: 0px;
	width: 170px;
	text-align: center;
}
#chugaTable{
	margin: auto; border-collapse: collapse; width: 370px;
	margin-top: 50px;
}
#btnDiv{
	text-align: right; margin-top: 10px;
}
#chugaBtn{
	margin-right: 50px; height: 30px; width: 60px;
	font-weight: bold; color: white; background-color: #0074E9;
	border: none; border-radius: 5px 5px;
}

</style>