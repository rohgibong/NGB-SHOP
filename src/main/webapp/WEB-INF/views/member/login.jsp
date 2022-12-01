<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
    
<div id="loginPage">

<div id="img">
<a href="${path }">
	<img src="${path }/attach${path}/logo/ngbshop.png" width='230' height='45'>
</a>
</div>

<form name="DirForm" id="DirForm">
<input type="hidden" name="referer" id="referer" value="${referer }">
<table id="table">
	<tr>
		<td>
			<input type="text" name="id" id="id" placeholder="아이디"><br>
			<label id="label_id"></label>
		</td>
	</tr>
	<tr>
		<td>
			<input type="password" name="passwd" id="passwd" placeholder="비밀번호"><br>
			<label id="label_passwd"></label>
		</td>
	</tr>
</table>
</form>

<div id="searchIDPWForm">
	<a href="${path }/member/searchIdPw" id="searchIdPw">
		아이디/비밀번호 찾기
	</a>
</div>

<div id="loginBtnDiv">
	<button id="loginBtnId" type="button" onClick="login();">
		로그인
	</button>
</div>

<div id="hrDiv">
	<hr>
</div>

<div id="chugaBtnDiv">
	<button id="chugaBtnId" type="button" onClick="location.href='${path }/member/memberJoinForm';">
		회원가입
	</button>
</div>

<div id="bottom">
	Copyright 1900-2022 by localhost Co.LTD All Rights Reserved.
</div>

</div>


<script>
function login(){
var errCounter = 0;
	if(document.DirForm.id.value == ''){
		$("#label_id").html("아이디를 입력해주세요.");
		$("#label_id").css('color', 'red');
		$("#label_id").css('font-size', '8px');
		errCounter++;
	} else {
		$("#label_id").html("");
	}
	if(document.DirForm.passwd.value == ''){
		$("#label_passwd").html("비밀번호를 입력해주세요.");
		$("#label_passwd").css('color', 'red');
		$("#label_passwd").css('font-size', '8px');
		errCounter++;
	} else {
		$("#label_passwd").html("");
	}
	
	if(errCounter > 0){
		return;
	} else {
		document.DirForm.action = "${path }/member/loginProc";
		document.DirForm.method = "post";
		document.DirForm.submit();
	}
	
}
</script>


<style>
#referer{
	width: 400px;
}
#loginPage{
	border: 0px solid red; width: 380px; margin: auto; padding-top: 20px;
}
#img{
	text-align: center; margin-bottom: 20px;
}
#DirForm{
	margin-bottom: 0px;
}
#table{
	margin: auto; border-spacing: 10px;
}
#id, #passwd{
	height: 35px; width: 350px; padding: 0px 10px;
}
#searchIDPWForm{
	text-align: right; margin-right: 10px;
}
#searchIdPw{
	text-decoration: none; color: #5882FA; font-size: 13px;
}
#login{
	text-align: center;
}
#loginBtnDiv {
	text-align: center; padding-top: 10px;
}
#loginBtnId{
	 height: 50px; width: 350px; font-size: 15px; font-weight: bold; color: white; background-color: #0074E9; border: none;
	 cursor: pointer;
}
#hrDiv{
	width: 350px; margin: auto;
}
#chugaBtnDiv {
	text-align: center;
}
#chugaBtnId{
	 height: 50px; width: 350px; font-size: 15px; font-weight: bold; color: #0074E9; background-color: white; border-color: #CCCCCC;
	 cursor: pointer;
}
#bottom{
	text-align: center; font-size: 12px; padding-top: 15px;
}
</style>