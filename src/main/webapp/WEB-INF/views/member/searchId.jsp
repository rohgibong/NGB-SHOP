<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

<div id="searchPage">

<div id="img">
<a href="${path }">
	<img src="${path }/attach${path}/logo/ngbshop.png" width='230' height='45'>
</a>
</div>

<div id="searchGubunForm">
	<input type="radio" name="searchGubun" value="usePhone" checked> 휴대폰 번호로 찾기 &nbsp;
	<input type="radio" name="searchGubun" value="useEmail"> 이메일로 찾기
</div>


<div id="usePhoneForm" style="display:block;">
	<form name="phoneForm">
	<table id="phoneTable">
		<tr>
			<td>
				<input type="text" name="name" id="name" placeholder="이름"><br>
				<label id="label_name"></label>
			</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="phone1" id="phone1" placeholder="010" maxlength="3" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
				<a id="hyphen">-</a>
				<input type="text" name="phone2" id="phone2" placeholder="0000" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
				<a id="hyphen">-</a>
				<input type="text" name="phone3" id="phone3" placeholder="0000" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
				<input type="button" onClick="phoneCheck();" value="인증번호전송" id="phoneChkBtn">
				<br>
				<label id="label_phone"></label>
				<div id="checkDiv2">
					<br>
					<input type="text" name="checkCode2" id="checkCode2" placeholder="인증번호">
					<input type="button" onClick="codeCheck2();" value="인증번호확인" id="checkCodeBtn2"><br>
					<label id="label_phone2"></label>
				</div>
				<input type="hidden" name="randomCode2" id="randomCode2">
				<input type="hidden" name="correctCode2">
			</td>
		</tr>
	</table>
	
	<div id="usePhoneSearch">
		<button id="upsButton" type="button" onClick="usePhoneSearch();">
			아이디 찾기
		</button>
	</div>
	
	<div id="goLogin">
		<a href="${path }/member/login" id="login">
			로그인
		</a>
		<a href="${path }/member/searchPw" id="searchPw">
			비밀번호 찾기
		</a>
	</div>
	
	</form>
</div>

<div id="useEmailForm" style="display:none;">
	<form name="emailForm">
	<table id="emailTable">
		<tr>
			<td>
				<input type="text" name="name" id="name" placeholder="이름"><br>
				<label id="label_name2"></label>
			</td>
		</tr>
		<tr>
			<td>
			<input type="text" name="email1" id="email1" placeholder="이메일">
			@
			<div id="emailWriteDiv">
				<input type="text" name="email2" id="email2" placeholder="이메일주소"><br>
			</div>
			<div id="emailSelectDiv">
				<select name="emailOption" id="emailOption" class="select" onChange="setEmail(this.value);">
					<option value="x">--선택--</option>
					<option value="gmail.com">gmail.com</option>
					<option value="naver.com">naver.com</option>
					<option value="daum.net">daum.net</option>
					<option value="nate.com">nate.com</option>
					<option value="o">직접입력</option>
				</select>
				<input type="button" onClick="emailCheck();" value="인증번호전송" id="emailChkBtn">
			</div>
			<br>
			<label id="label_email"></label>
			<div id="checkDiv">
				<br>
				<input type="text" name="checkCode" id="checkCode" placeholder="인증번호">
				<input type="button" onClick="codeCheck();" value="인증번호확인" id="checkCodeBtn"><br>
				<label id="label_email2"></label>
			</div>
			<input type="hidden" name="randomCode" id="randomCode">
			<input type="hidden" name="correctCode">
			</td>
		</tr>
	</table>
	
	<div id="useEmailSearch">
		<button id="uesButton" type="button" onClick="useEmailSearch();">
			아이디 찾기
		</button>
	</div>
	
	<div id="goLogin">
		<a href="${path }/member/login" id="login">
			로그인
		</a>
		<a href="${path }/member/searchPw" id="searchPw">
			비밀번호 찾기
		</a>
	</div>
	
	</form>

</div>


</div>

<script>
$('input[type=radio][name=searchGubun]').on('click', function(){
	var chkValue = $('input[type=radio][name=searchGubun]:checked').val();
	if(chkValue=='usePhone'){
		$('#usePhoneForm').css('display', 'block');
		$('#useEmailForm').css('display', 'none');
	} else if(chkValue=='useEmail') {
		$('#usePhoneForm').css('display', 'none');
		$('#useEmailForm').css('display', 'block');
	}
});

function setEmail(value1){
	if(value1 == 'o'){
		$('#emailWriteDiv').css('display', 'block');
		$('#emailChkBtn').css('margin-right', '7px');
	} else {
		$('#emailWriteDiv').css('display', 'none');
		$('#emailChkBtn').css('margin-right', '0px');
	}
}

function emailCheck(){
	var email1 = document.emailForm.email1.value;
	var emailOption = document.emailForm.emailOption.value;
	var email2 = document.emailForm.email2.value;
	if(email1=='' || emailOption=='x'){
		$("#label_email").html("이메일을 입력하세요.");
		$("#label_email").css('color', 'red');
		$("#label_email").css('font-size', '8px');
		return;
	}
	if(emailOption=='o'){
		if(email2 == ''){
			$("#label_email").html("이메일을 입력하세요.");
			$("#label_email").css('color', 'red');
			$("#label_email").css('font-size', '8px');
			return;
		}
	} else {
		email2 = emailOption;
	}
	$.ajax({
		type: "post",
		data: {
			"email1" : email1,
			"email2" : email2
		},
		url: "${path }/member/emailCheck",
		success : function(result){
			if(result > 0){
				$("#label_email").html("잠시만 기다려주세요...");
				$("#label_email").css('color', 'black');
				$("#label_email").css('font-size', '8px');
				$.ajax({
					type: "post",
					data: {
						"email1" : email1,
						"email2" : email2
					},
					url: "${path }/member/noticeMail",
					success : function(result){
						$("#label_email").html("인증번호를 발송했습니다.");
						$("#label_email").css('color', 'blue');
						$("#label_email").css('font-size', '8px');
						$("#checkDiv").css('display', 'block');
						$("#randomCode").val(result);
					}
				});
			} else {
				$("#label_email").html("존재하지 않는 이메일입니다.");
				$("#label_email").css('color', 'red');
				$("#label_email").css('font-size', '8px');
				$("#email1").focus();
				return;
				
			}
		}
	});
	
}

function codeCheck(){
	var inputCode = document.emailForm.checkCode.value;
	var randomCode = document.emailForm.randomCode.value;
	if(inputCode != randomCode){
		document.emailForm.correctCode.value = '';
		$("#label_email2").html("인증번호가 일치하지 않습니다.<br>인증번호는 대/소문자를 구분합니다.");
		$("#label_email2").css('color', 'red');
		$("#label_email2").css('font-size', '8px');
	} else{
		document.emailForm.correctCode.value = 'OK';
		$("#label_email2").html("인증번호 확인이 완료되었습니다.");
		$("#label_email2").css('color', 'blue');
		$("#label_email2").css('font-size', '8px');
	}
}

function phoneCheck(){
	var phone1 = document.phoneForm.phone1.value;
	var phone2 = document.phoneForm.phone2.value;
	var phone3 = document.phoneForm.phone3.value;
	
	if(phone1=='' || phone2=='' || phone3==''){
		$("#label_phone").html("전화번호를 입력하세요.");
		$("#label_phone").css('color', 'red');
		$("#label_phone").css('font-size', '8px');
		return;
	}
	
	$.ajax({
		type: "post",
		data: {
			"phone1" : phone1,
			"phone2" : phone2,
			"phone3" : phone3
		},
		url: "${path }/member/phoneCheck",
		success : function(result){
			if(result > 0){
				$("#label_phone").html("잠시만 기다려주세요...");
				$("#label_phone").css('color', 'black');
				$("#label_phone").css('font-size', '8px');
				$.ajax({
					type: "post",
					data: {
						"phone1" : phone1,
						"phone2" : phone2,
						"phone3" : phone3
					},
					url: "${path }/member/noticeMessage",
					success : function(result){
						$("#label_phone").html("인증번호를 발송했습니다.");
						$("#label_phone").css('color', 'blue');
						$("#label_phone").css('font-size', '8px');
						$("#checkDiv2").css('display', 'block');
						$("#randomCode2").val(result);
					}
				});
			} else {
				$("#label_phone").html("존재하지 않는 전화번호입니다.");
				$("#label_phone").css('color', 'red');
				$("#label_phone").css('font-size', '8px');
				$("#phone1").focus();
				return;
			}
		}
	});
}

function codeCheck2(){
	var inputCode = document.phoneForm.checkCode2.value;
	var randomCode = document.phoneForm.randomCode2.value;
	if(inputCode != randomCode){
		document.phoneForm.correctCode2.value = '';
		$("#label_phone2").html("인증번호가 일치하지 않습니다.<br>인증번호는 대/소문자를 구분합니다.");
		$("#label_phone2").css('color', 'red');
		$("#label_phone2").css('font-size', '8px');
	} else{
		document.phoneForm.correctCode2.value = 'OK';
		$("#label_phone2").html("인증번호 확인이 완료되었습니다.");
		$("#label_phone2").css('color', 'blue');
		$("#label_phone2").css('font-size', '8px');
	}
}

function usePhoneSearch(){
var errCounter = 0;
	if(document.phoneForm.name.value == ''){
		$("#label_name").html("이름을 입력해주세요.");
		$("#label_name").css('color', 'red');
		$("#label_name").css('font-size', '8px');
		errCounter++;
	} else {
		$("#label_name").html("");
	}
	if(document.phoneForm.phone1.value == '' || document.phoneForm.phone2.value == '' || document.phoneForm.phone3.value == ''){
		$("#label_phone").html("전화번호를 입력해주세요.");
		$("#label_phone").css('color', 'red');
		$("#label_phone").css('font-size', '8px');
		errCounter++;
	}
	if((document.phoneForm.phone1.value != '' && document.phoneForm.phone2.value != '' && document.phoneForm.phone3.value != '') && document.phoneForm.randomCode2.value == ''){
		$("#label_phone").html("전화번호 인증을 해주세요.");
		$("#label_phone").css('color', 'red');
		$("#label_phone").css('font-size', '8px');
		errCounter++;
	}
	if((document.phoneForm.phone1.value != '' && document.phoneForm.phone2.value != '' && document.phoneForm.phone3.value != '') && document.phoneForm.correctCode2.value == ''){
		$("#label_phone2").html("인증번호 확인을 해주세요.");
		$("#label_phone2").css('color', 'red');
		$("#label_phone2").css('font-size', '8px');
		errCounter++;
	}
	
	if(errCounter > 0){
		return;
	}
	
	document.phoneForm.action = "${path}/member/searchIdUsePhone";
	document.phoneForm.method = "post";
	document.phoneForm.submit();
}

function useEmailSearch(){
var errCounter = 0;
	if(document.emailForm.name.value == ''){
		$("#label_name2").html("이름을 입력해주세요.");
		$("#label_name2").css('color', 'red');
		$("#label_name2").css('font-size', '8px');
		errCounter++;
	} else {
		$("#label_name2").html("");
	}
	if(document.emailForm.email1.value == '' || document.emailForm.emailOption.value == 'x'){
		$("#label_email").html("이메일을 입력해주세요.");
		$("#label_email").css('color', 'red');
		$("#label_email").css('font-size', '8px');
		errCounter++;
	}
	if((document.emailForm.email1.value != '' && document.emailForm.emailOption.value != 'x') && document.emailForm.randomCode.value == ''){
		$("#label_email").html("이메일 인증을 해주세요.");
		$("#label_email").css('color', 'red');
		$("#label_email").css('font-size', '8px');
		errCounter++;
	}
	if((document.emailForm.email1.value != '' && document.emailForm.emailOption.value != 'x') && document.emailForm.correctCode.value == ''){
		$("#label_email2").html("인증번호 확인을 해주세요.");
		$("#label_email2").css('color', 'red');
		$("#label_email2").css('font-size', '8px');
		errCounter++;
	}
	
	if(errCounter > 0){
		return;
	}
	
	if(document.emailForm.emailOption.value != 'o'){
		document.emailForm.email2.value = document.emailForm.emailOption.value;
	}
	
	document.emailForm.action = "${path}/member/searchIdUseEmail";
	document.emailForm.method = "post";
	document.emailForm.submit();
}

</script>

<style>
div{
	border: 0px solid red;
}
#searchPage{
	border: 0px solid red; width: 380px; margin: auto; padding-top: 20px;
}
#img{
	text-align: center; margin-bottom: 20px;
}
#searchGubunForm{
	text-align: center; margin-bottom: 10px;
}
#phoneTable, #emailTable{
	margin: auto; border-spacing: 10px;
}
#name{
	height: 35px; width: 350px; padding: 0px 10px;
}
#phone1{
	height: 35px; width: 62px; text-align: center;
}
#phone2, #phone3{
	height: 35px; width: 70px; text-align: center;
}
#hyphen{
	font-size: 20px;
}
#emailChkBtn, #phoneChkBtn{
	height: 35px; width: 100px; margin-left: 3px; 
	cursor: pointer;
}
#checkCode, #checkCode2{
	height: 35px; width: 220px; padding: 0px 10px;
}
#checkCodeBtn, #checkCodeBtn2{
	height: 35px; width: 120px; margin-left: 3px;
	cursor: pointer;
}
#checkDiv, #checkDiv2{
	display: none;
}
#email1{
	height: 35px; width: 125px; padding: 0px 10px;
}
#emailWriteDiv{
	margin-bottom: 10px;
	display: none;
	float: right;
}
#emailSelectDiv{
	float: right;
}
#email2{
	height: 35px; width: 198px; padding: 0px 10px; margin-right: 7px;
}
.select {
  height: 35px; width: 90px; padding: 5px 0px 5px 5px; outline: 0 none;
}
#usePhoneSearch, #useEmailSearch {
	text-align: center; padding-top: 10px;
}
#upsButton, #uesButton{
	 height: 50px; width: 350px;
	 font-size: 15px; font-weight: bold; color: #0074E9;
	 background-color: white; border-color: #CCCCCC;
	 cursor: pointer;
}
#goLogin{
	text-align: right; margin-right: 15px; margin-top: 5px;
}
#login, #searchPw{
	text-decoration: none; color: #5882FA; font-size: 13px; margin-left: 5px;
}
</style>