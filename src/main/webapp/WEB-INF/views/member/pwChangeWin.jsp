<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
var msg = "<c:out value='${msg}'/>";
var path = "<c:out value='${path}'/>";

if(msg != ''){
	alert(msg);
}
</script>

<div id="pwChangePage">

<div id="img">
<a href="${path }">
	<img src="${path }/attach${path}/logo/ngbshop.png" width='230' height='45'>
</a>
</div>

<div id="changeMsgForm">
	<a id="changeMsg">비밀번호를 변경해주세요</a>
</div>

<form name="DirForm">
<input type="hidden" name="memberCode" value="${memberCode }">
<table id="table">
		<tr>
			<td>
				<input type="text" name="id" id="id" value="${id }" readonly>
			</td>
		</tr>
		<tr>
			<td>
				<input type="password" name="passwd" id="passwd" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" placeholder="비밀번호 (4자리 이상, 숫자만)"><br>
			<label id="label_passwd"></label>
			</td>
		</tr>
		<tr>
			<td>
				<input type="password" name="passwdChk" id="passwdChk" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" placeholder="비밀번호 확인"><br>
			<label id="label_passwdChk"></label>
			</td>
		</tr>
</table>
</form>

<div id="changePwDiv">
	<button id="changePwBtn" type="button" onClick="change();">
		비밀번호 변경
	</button>
</div>

</div>

<script>
function change(){
var errCounter = 0;
	if(document.DirForm.passwd.value == ''){
		$("#label_passwd").html("비밀번호를 입력해주세요.");
		$("#label_passwd").css('color', 'red');
		$("#label_passwd").css('font-size', '8px');
		errCounter++;
	} else {
		$("#label_passwd").html("");
	}
	if(document.DirForm.passwd.value != '' && document.DirForm.passwd.value.length < 4){
		$("#label_passwd").html("비밀번호가 너무 짧습니다.");
		$("#label_passwd").css('color', 'red');
		$("#label_passwd").css('font-size', '8px');
		errCounter++;
	} else if(document.DirForm.passwd.value != '' && document.DirForm.passwd.value.length >= 4){
		if(document.DirForm.passwd.value.length > 12){
			$("#label_passwd").html("비밀번호가 너무 깁니다.");
			$("#label_passwd").css('color', 'red');
			$("#label_passwd").css('font-size', '8px');
			errCounter++;
		} else {
			$("#label_passwd").html("");
		}
	}
	if(document.DirForm.passwdChk.value == ''){
		$("#label_passwdChk").html("비밀번호 확인을 입력해주세요.");
		$("#label_passwdChk").css('color', 'red');
		$("#label_passwdChk").css('font-size', '8px');
		errCounter++;
	} else {
		$("#label_passwdChk").html("");
	}
	if((document.DirForm.passwd.value != '' && document.DirForm.passwdChk.value != '') && (document.DirForm.passwd.value != document.DirForm.passwdChk.value)){
		$("#label_passwdChk").html("비밀번호와 비밀번호 확인이 일치하지 않습니다.<br>확인 후 다시 입력해주세요.");
		$("#label_passwdChk").css('color', 'red');
		$("#label_passwdChk").css('font-size', '8px');
		errCounter++;
	}
	
	if(errCounter > 0){
		return;
	}
	
	if(confirm('비밀번호를 변경하시겠습니까?')){
		document.DirForm.action = "${path}/member/pwChangeProcWin";
		document.DirForm.method = "post";
		document.DirForm.submit();
	}
}


</script>

<style>
#pwChangePage{
	border: 0px solid red; width: 500px; margin: auto; padding-top: 20px;
}
#img{
	text-align: center; margin-bottom: 20px;
}
#changeMsgForm{
	padding-left: 75px;
}
#changeMsg{
	font-weight: bold; font-size: 15px;
}
#table{
	margin: auto; border-spacing: 10px;
}
#id, #passwd, #passwdChk{
	height: 35px; width: 350px; padding: 0px 10px;
}
#changePwDiv {
	text-align: center;
}
#changePwBtn{
	 height: 50px; width: 350px; font-size: 15px; font-weight: bold; color: #0074E9; background-color: white; border-color: #CCCCCC;
}
</style>