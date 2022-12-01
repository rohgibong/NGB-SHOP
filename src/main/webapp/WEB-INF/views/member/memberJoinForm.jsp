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

<div id="joinMsgForm">
	<a id="joinMsg">회원정보를 입력해주세요</a>
</div>

<form name="DirForm">
<table id="table">
	<tr>
		<td>
			<input type="text" name="id" id="id" placeholder="아이디">
			<input type="hidden" name="tempId" id="tempId" value="">
			<input type="button" onClick="idCheck();" value="아이디 찾기" id="idCheckBtn"><br>
			<label id="label_id"></label>
		</td>
	</tr>
	<tr>
		<td>
			<input type="password" name="passwd" id="passwd" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" placeholder="비밀번호 (4~12자리, 숫자만)"><br>
			<label id="label_passwd"></label>
		</td>
	</tr>
	<tr>
		<td>
			<input type="password" name="passwdChk" id="passwdChk" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');" placeholder="비밀번호 확인"><br>
			<label id="label_passwdChk"></label>
		</td>
	</tr>
	<tr>
		<td>
			<input type="text" name="name" id="name" placeholder="이름"><br>
			<label id="label_name"></label>
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
	<tr>
		<td>
			<input type="text" id="sample6_postcode" placeholder="우편번호" name="juso1" readonly>
			<input type="button" onClick="sample6_execDaumPostcode()" value="우편번호 찾기" id="searchAddBtn"><br>
		</td>
	</tr>
	<tr>
		<td>
			<input type="text" id="sample6_address" placeholder="주소" name="juso2" readonly><br>
		</td>
	</tr>
	<tr>
		<td>
			<input type="text" id="sample6_detailAddress" placeholder="상세주소" name="juso3">
			<input type="text" id="sample6_extraAddress" placeholder="참고항목" name="juso4" readonly><br>
			<label id="label_address"></label>
		</td>
	</tr>
</table>
</form>

<div id="joinBtnDiv">
	<button id="joinBtnId" type="button" onClick="join();">
		회원가입
	</button>
</div>


</div>

<script>
function idCheck(){
	var id = $("#id").val();
	if(id==''){
		$("#label_id").html("아이디를 입력하세요.");
		$("#label_id").css('color', 'red');
		$("#label_id").css('font-size', '8px');
		$("#id").focus();
		return;
	}
	
	var param = "id=" + id;
	$.ajax({
		type: "post",
		data: param,
		url: "${path }/member/idCheck",
		success : function(result){
			if(result > 0){
				$("#tempId").val('');
				$("#label_id").html("이미 사용중인 아이디입니다.");
				$("#label_id").css('color', 'red');
				$("#label_id").css('font-size', '8px');
				$("#id").focus();
			} else{
				$("#id").val(id);
				$("#tempId").val(id);
				$("#label_id").html("사용 가능한 아이디입니다.");
				$("#label_id").css('color', 'blue');
				$("#label_id").css('font-size', '8px');
			}
		}
	});
}

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
	var email1 = document.DirForm.email1.value;
	var emailOption = document.DirForm.emailOption.value;
	var email2 = document.DirForm.email2.value;
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
				$("#label_email").html("이미 사용중인 이메일입니다.");
				$("#label_email").css('color', 'red');
				$("#label_email").css('font-size', '8px');
				$("#email1").focus();
				return;
			} else {
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
			}
		}
	});
	
}

function codeCheck(){
	var inputCode = document.DirForm.checkCode.value;
	var randomCode = document.DirForm.randomCode.value;
	if(inputCode != randomCode){
		document.DirForm.correctCode.value = '';
		$("#label_email2").html("인증번호가 일치하지 않습니다.<br>인증번호는 대/소문자를 구분합니다.");
		$("#label_email2").css('color', 'red');
		$("#label_email2").css('font-size', '8px');
	} else{
		document.DirForm.correctCode.value = 'OK';
		$("#label_email2").html("인증번호 확인이 완료되었습니다.");
		$("#label_email2").css('color', 'blue');
		$("#label_email2").css('font-size', '8px');
	}
}

function phoneCheck(){
	var phone1 = document.DirForm.phone1.value;
	var phone2 = document.DirForm.phone2.value;
	var phone3 = document.DirForm.phone3.value;
	
	if(phone1=='' || phone2=='' || phone3==''){
		$("#label_phone").html("전화번호를 입력하세요.");
		$("#label_phone").css('color', 'red');
		$("#label_phone").css('font-size', '8px');
		return;
	}
	
	if((document.DirForm.phone1.value != '' && document.DirForm.phone2.value != '' && document.DirForm.phone3.value != '') && 
			(document.DirForm.phone1.value > 19 || document.DirForm.phone1.value < 10 || document.DirForm.phone2.value.length < 3 || document.DirForm.phone3.value.length < 4)){
			$("#label_phone").html("전화번호를 정확하게 입력해주세요.");
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
				$("#label_phone").html("이미 사용중인 전화번호입니다.");
				$("#label_phone").css('color', 'red');
				$("#label_phone").css('font-size', '8px');
				$("#phone1").focus();
				return;
			} else {
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
			}
		}
	});
}

function codeCheck2(){
	var inputCode = document.DirForm.checkCode2.value;
	var randomCode = document.DirForm.randomCode2.value;
	if(inputCode != randomCode){
		document.DirForm.correctCode2.value = '';
		$("#label_phone2").html("인증번호가 일치하지 않습니다.<br>인증번호는 대/소문자를 구분합니다.");
		$("#label_phone2").css('color', 'red');
		$("#label_phone2").css('font-size', '8px');
	} else{
		document.DirForm.correctCode2.value = 'OK';
		$("#label_phone2").html("인증번호 확인이 완료되었습니다.");
		$("#label_phone2").css('color', 'blue');
		$("#label_phone2").css('font-size', '8px');
	}
}

function join(){
var errCounter = 0;
	if(document.DirForm.id.value == ''){
		$("#label_id").html("아이디를 입력해주세요.");
		$("#label_id").css('color', 'red');
		$("#label_id").css('font-size', '8px');
		errCounter++;
	}
	if(document.DirForm.id.value != '' && document.DirForm.tempId.value == ''){
		$("#label_id").html("아이디 찾기를 해주세요.");
		$("#label_id").css('color', 'red');
		$("#label_id").css('font-size', '8px');
		errCounter++;
	}
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
	if(document.DirForm.name.value == ''){
		$("#label_name").html("이름을 입력해주세요.");
		$("#label_name").css('color', 'red');
		$("#label_name").css('font-size', '8px');
		errCounter++;
	} else {
		$("#label_name").html("");
	}
	if(document.DirForm.email1.value == '' || document.DirForm.emailOption.value == 'x'){
		$("#label_email").html("이메일을 입력해주세요.");
		$("#label_email").css('color', 'red');
		$("#label_email").css('font-size', '8px');
		errCounter++;
	}
	if((document.DirForm.email1.value != '' && document.DirForm.emailOption.value != 'x') && document.DirForm.randomCode.value == ''){
		$("#label_email").html("이메일 인증을 해주세요.");
		$("#label_email").css('color', 'red');
		$("#label_email").css('font-size', '8px');
		errCounter++;
	}
	if((document.DirForm.email1.value != '' && document.DirForm.emailOption.value != 'x') && document.DirForm.correctCode.value == ''){
		$("#label_email2").html("인증번호 확인을 해주세요.");
		$("#label_email2").css('color', 'red');
		$("#label_email2").css('font-size', '8px');
		errCounter++;
	}
	if(document.DirForm.phone1.value == '' || document.DirForm.phone2.value == '' || document.DirForm.phone3.value == ''){
		$("#label_phone").html("전화번호를 입력하세요.");
		$("#label_phone").css('color', 'red');
		$("#label_phone").css('font-size', '8px');
		errCounter++;
	}
	if((document.DirForm.phone1.value != '' && document.DirForm.phone2.value != '' && document.DirForm.phone3.value != '') && document.DirForm.randomCode2.value == ''){
		$("#label_phone").html("전화번호 인증을 해주세요.");
		$("#label_phone").css('color', 'red');
		$("#label_phone").css('font-size', '8px');
		errCounter++;
	}
	if((document.DirForm.phone1.value != '' && document.DirForm.phone2.value != '' && document.DirForm.phone3.value != '') && document.DirForm.correctCode2.value == ''){
		$("#label_phone2").html("인증번호 확인을 해주세요.");
		$("#label_phone2").css('color', 'red');
		$("#label_phone2").css('font-size', '8px');
		errCounter++;
	}
	if(document.DirForm.juso1.value == '' || document.DirForm.juso2.value == '' || document.DirForm.juso3.value == ''){
		$("#label_address").html("주소를 입력해주세요.");
		$("#label_address").css('color', 'red');
		$("#label_address").css('font-size', '8px');
		errCounter++;
	} else {
		$("#label_address").html("");
	}
	if(document.DirForm.juso4.value == ''){
		document.DirForm.juso4.value = '-';
	}
	
	if(errCounter > 0){
		return;
	}
	
	if(confirm('가입 하시겠습니까?')){
		if(document.DirForm.emailOption.value != 'o'){
			document.DirForm.email2.value = document.DirForm.emailOption.value;
		}
		document.DirForm.action = "${path }/member/memberJoinProc";
		document.DirForm.method = "post";
		document.DirForm.submit();
	}
}

</script>

<style>
#loginPage{
	border: 0px solid red; width: 380px; margin: auto; padding-top: 20px;
}
#img{
	text-align: center; margin-bottom: 20px;
}
#joinMsgForm{
	padding-left: 15px;
}
#joinMsg{
	font-weight: bold; font-size: 15px;
}
#table{
	margin: auto; border-spacing: 10px;
}
#passwd, #passwdChk, #name{
	height: 35px; width: 350px; padding: 0px 10px;
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
#emailChkBtn, #phoneChkBtn{
	height: 35px; width: 100px; margin-left: 3px; margin-bottom: 10px;
	cursor: pointer;
}
#checkDiv, #checkDiv2{
	display: none;
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
#id, #sample6_postcode, #checkCode, #checkCode2{
	height: 35px; width: 220px; padding: 0px 10px;
}
#idCheckBtn, #searchAddBtn, #checkCodeBtn, #checkCodeBtn2{
	height: 35px; width: 120px; margin-left: 3px;
	cursor: pointer;
}
#sample6_address{
	height: 35px; width: 350px; padding: 0px 10px;
}
#sample6_detailAddress{
	height: 35px; width: 213px; padding: 0px 10px;
}
#sample6_extraAddress{
	height: 35px; width: 130px; padding: 0px 10px;
}
#joinBtnDiv {
	text-align: center; padding-top: 10px;
}
#joinBtnId{
	 height: 50px; width: 350px; font-size: 15px; font-weight: bold; color: white; background-color: #0074E9; border: none;
	 cursor: pointer;
}
</style>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>