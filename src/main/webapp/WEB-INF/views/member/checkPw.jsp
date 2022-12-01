<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

<c:set var="imsiNo" value="${dto.memberCode }" />
<c:if test="${imsiNo != memberNo || !(imsiNo > 0) }">
	<script>
		location.href="${path }/member/login";
	</script>
</c:if>
    
<div id="checkPage">

<div id="captionDiv">
	<h1>회원정보 확인</h1>
</div>

<div id="mentDiv">
	${dto.id }님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인 합니다.
</div>

<form name="DirForm" id="DirForm">
<input type="hidden" name="memberCode" id="memberCode" value="${dto.memberCode }">
<table id="table">
	<tr>
		<td id="tdId">
			<a id="contentCaption">아이디</a>
		</td>
		<td id="tdId2">
			<a id="contentId">${dto.id }</a>
		</td>
	</tr>
	<tr>
		<td id="tdId">
			<a id="contentCaption">비밀번호</a>
		</td>
		<td id="tdId2">
			<input type="password" name="passwd" id="passwd"> &nbsp; <label id="label_pw"></label>
		</td>
	</tr>
</table>
</form>

<div id="btnDiv">
	<button type="button" onClick="pwCheck();" id="chugaBtn">확인</button> &nbsp;
	<button type="button" onClick="location.href='${path }'" id="cancelBtn">취소</button>
</div>

</div>

<script>
function pwCheck(){
	var passwd = $("#passwd").val();
	var memberCode = $("#memberCode").val();
	if(passwd==''){
		$("#label_pw").html("비밀번호를 입력하세요.");
		$("#label_pw").css('color', 'red');
		$("#label_pw").css('font-size', '9px');
		$("#passwd").focus();
		return;
	}
	
	$.ajax({
		type: "post",
		data: {
				"memberCode" : memberCode,
				"passwd" : passwd
			},
		url: "${path }/member/pwCheck",
		success : function(result){
			if(result <= 0){
				$("#label_pw").html("비밀번호가 일치하지 않습니다.");
				$("#label_pw").css('color', 'red');
				$("#label_pw").css('font-size', '9px');
				$("#passwd").focus();
			} else{
				document.DirForm.action = "${path}/member/changeUserInfo";
				document.DirForm.method = "post";
				document.DirForm.submit();
			}
		}
	});
}
</script>


<style>
#menu{
	width: 1100px; margin:auto;
}
#body{
	background-color: #EBEBEB;
}
#checkPage{
	border: 1px solid #DCDCDC; background-color: white; width: 1100px; height: 800px; margin: auto; padding-top: 50px;
}
#img{
	text-align: center; margin-bottom: 20px;
}
#searchDiv{
	width: 500px;
}
#searchData{
	width: 335px;
}
#DirForm{
	margin-bottom: 0px;
}
#captionDiv{
	padding-left: 40px;
}
#mentDiv{
	padding-left: 40px; padding-bottom: 10px; font-size: 12px;
}
#table{
	margin: auto; border-collapse: collapse; width: 1020px;
}
td{
	border-top: 1px solid #666666; border-bottom: 1px solid #666666;
}
td:first-child{
	border-right: 1px solid #666666;
}
#tdId{
	width: 130px; height: 50px; text-align: center; background-color: #EEF1F8; color: #666666;
}
#tdId2{
	padding-left: 20px;
}
#contentCaption{
	font-size: 12px; font-weight: bold;
}
#contentId{
	font-size: 12px; color: #666666;
}
#passwd{
	height: 25px;
}
#btnDiv{
	text-align: center; margin-top: 30px;
}
#chugaBtn{
	height: 30px; width: 60px; font-weight: bold; color: white; background-color: #0074E9; border: none; border-radius: 5px 5px;
}
#cancelBtn{
	height: 30px; width: 60px; font-weight: bold; color: white; background-color: #92959F; border: none; border-radius: 5px 5px;
}
</style>