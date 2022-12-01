<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

<c:set var="imsiNo" value="${dto.memberCode }" />
<c:if test="${imsiNo != memberNo || !(imsiNo > 0) }">
	<script>
		location.href="${path }";
	</script>
</c:if>

<div id="changePage">

<div id="captionDiv">
	<h1>회원정보 수정</h1>
</div>

<form name="DirForm" id="DirForm">
<input type="hidden" name="id" id="id" value="${dto.id }">
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
			<a id="contentCaption">이름</a>
		</td>
		<td id="tdId2">
			<a id="contentId">${dto.name }</a>
		</td>
	</tr>
	<tr>
		<td id="tdId">
			<a id="contentCaption">비밀번호</a>
		</td>
		<td id="tdId2">
			<button type="button" onClick="changePw();" id="buttonId1">비밀번호변경</button>
		</td>
	</tr>
	<tr>
		<td id="tdId">
			<a id="contentCaption">휴대폰 번호</a>
		</td>
		<td id="tdId2">
			<input type="text" name="phone1" id="phone1" value="${dto.phone1 }" maxlength="3" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
			<a id="hyphen">-</a>
			<input type="text" name="phone2" id="phone2" value="${dto.phone2 }" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');">
			<a id="hyphen">-</a>
			<input type="text" name="phone3" id="phone3" value="${dto.phone3 }" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"><br>
			<label id="label_phone"></label>
		</td>
	</tr>
	<tr>
		<td id="tdId">
			<a id="contentCaption">이메일</a>
		</td>
		<td id="tdId2">
		<div id="emailDiv">
			<input type="text" name="email1" id="email1" value="${dto.email1 }" onChange="changeEmail();">
			@
		</div>
			<input type="text" name="email2" id="email2" value="${dto.email2 }" placeholder="이메일주소" onChange="changeEmail();">			
			<select name="emailOption" id="emailOption" class="select" onChange="setEmail(this.value);">
			<c:choose>
				<c:when test="${dto.email2 == 'gmail.com'}">
					<option value="gmail.com" selected>gmail.com</option>
					<option value="naver.com">naver.com</option>
					<option value="daum.net">daum.net</option>
					<option value="nate.com">nate.com</option>
					<option value="o">직접입력</option>
				</c:when>
				<c:when test="${dto.email2 == 'naver.com'}">
					<option value="gmail.com">gmail.com</option>
					<option value="naver.com" selected>naver.com</option>
					<option value="daum.net">daum.net</option>
					<option value="nate.com">nate.com</option>
					<option value="o">직접입력</option>
				</c:when>
				<c:when test="${dto.email2 == 'daum.net'}">
					<option value="gmail.com">gmail.com</option>
					<option value="naver.com">naver.com</option>
					<option value="daum.net" selected>daum.net</option>
					<option value="nate.com">nate.com</option>
					<option value="o">직접입력</option>
				</c:when>
				<c:when test="${dto.email2 == 'nate.com'}">
					<option value="gmail.com">gmail.com</option>
					<option value="naver.com">naver.com</option>
					<option value="daum.net">daum.net</option>
					<option value="nate.com" selected>nate.com</option>
					<option value="o">직접입력</option>
				</c:when>
				<c:otherwise>
					<option value="gmail.com">gmail.com</option>
					<option value="naver.com">naver.com</option>
					<option value="daum.net">daum.net</option>
					<option value="nate.com">nate.com</option>
					<option value="o" selected>직접입력</option>
				</c:otherwise>
			</c:choose>
			</select>
			<input type="button" onClick="emailCheck();" value="인증번호전송" id="emailChkBtn">
			<label id="label_email"></label>
			<div id="checkDiv">
				<input type="text" name="checkCode" id="checkCode" placeholder="인증번호">
				<input type="button" onClick="codeCheck();" value="인증번호확인" id="checkCodeBtn"><br>
				<label id="label_email2"></label>
			</div>
			<input type="hidden" name="randomCode" id="randomCode">
			<input type="hidden" name="correctCode">
		</td>
	</tr>
	<tr>
		<td id="tdId">
			<a id="contentCaption">주소</a>
		</td>
		<td id="tdId2">
			<div id="jusoDiv1">
				<input type="text" id="sample6_postcode" placeholder="우편번호" name="juso1" value="${dto.juso1 }" readonly>&nbsp;
				<input type="button" onClick="sample6_execDaumPostcode()" value="우편번호 찾기" id="buttonId1"><br>
			</div>
			<div id="jusoDiv2">
				<input type="text" id="sample6_address" placeholder="주소" name="juso2" value="${dto.juso2 }" readonly><br>
			</div>
			<div id="jusoDiv3">
				<input type="text" id="sample6_detailAddress" placeholder="상세주소" name="juso3" value="${dto.juso3 }">
				<input type="text" id="sample6_extraAddress" placeholder="참고항목" name="juso4" value="${dto.juso4 }" readonly><br>
			<label id="label_address"></label>
			</div>
		</td>
	</tr>
</table>
<div id="deleteDiv">
	<button type="button" onClick="sakje();" id="deleteBtn">회원탈퇴</button>
</div>
<div id="btnDiv">
	<button type="button" onClick="sujung();" id="buttonId2">수정하기</button> &nbsp;
	<button type="button" onClick="location.href='${path }'" id="buttonId3">나가기</button>
</div>
</form>

</div>

<script>
$(document).ready(function(){
	var imsi = $("#emailOption").val();
	if(imsi == 'o'){
		$('#email2').css('display', 'block');
	}
});
function changePw(){
	var memberCode = $("#memberCode").val();
	var id = $("#id").val();
	var formName = document.DirForm;
	var url = "${path}/member/pwChangeWin";
	window.open("", "DirForm", "width=700, height=400, toolbar=no, menubar=no, scrollbars=no, resizable=yes");
	formName.action = url;
	formName.method = "post";
	formName.target = "DirForm";
	formName.memberCode = memberCode;
	formName.id = id;
	formName.submit();
}

function setEmail(value1){
	if(value1 == 'o'){
		$('#email2').css('display', 'block');
		document.DirForm.correctCode.value = 'X';
	} else {
		$('#email2').css('display', 'none');
		document.DirForm.correctCode.value = 'X';
	}
}
function changeEmail(){
	document.DirForm.correctCode.value = 'X';
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
		document.DirForm.correctCode.value = 'X';
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

function sujung(){
var errCounter = 0;
	if(document.DirForm.email1.value == '' || document.DirForm.email2.value == ''){
		$("#label_email").html("이메일을 입력해주세요.");
		$("#label_email").css('color', 'red');
		$("#label_email").css('font-size', '8px');
		errCounter++;
	}
	if((document.DirForm.email1.value != '' && document.DirForm.email2.value != '') && document.DirForm.correctCode.value != ''){
		if(document.DirForm.randomCode.value == ''){
			$("#label_email").html("이메일 인증을 해주세요.");
			$("#label_email").css('color', 'red');
			$("#label_email").css('font-size', '8px');
			errCounter++;
		}
		if(document.DirForm.correctCode.value == 'X'){
			$("#label_email2").html("인증번호 확인을 해주세요.");
			$("#label_email2").css('color', 'red');
			$("#label_email2").css('font-size', '8px');
			errCounter++;
		}
	}
	if(document.DirForm.phone1.value == '' || document.DirForm.phone2.value == '' || document.DirForm.phone3.value == ''){
		$("#label_phone").html("전화번호를 입력해주세요.");
		$("#label_phone").css('color', 'red');
		$("#label_phone").css('font-size', '8px');
		errCounter++;
	} else {
		$("#label_phone").html("");
	}
	if((document.DirForm.phone1.value != '' && document.DirForm.phone2.value != '' && document.DirForm.phone3.value != '') && 
		(document.DirForm.phone1.value > 19 || document.DirForm.phone1.value < 10 || document.DirForm.phone2.value.length < 3 || document.DirForm.phone3.value.length < 4)){
		$("#label_phone").html("전화번호를 정확하게 입력해주세요.");
		$("#label_phone").css('color', 'red');
		$("#label_phone").css('font-size', '8px');
		errCounter++;
	} else if ((document.DirForm.phone1.value != '' && document.DirForm.phone2.value != '' && document.DirForm.phone3.value != '') &&
			(document.DirForm.phone1.value <= 19 && document.DirForm.phone1.value >= 10 && document.DirForm.phone2.value.length >= 3 && document.DirForm.phone3.value.length == 4)) {
		$("#label_phone").html("");
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
	if(confirm('수정 하시겠습니까?')){
		if(document.DirForm.emailOption.value != 'o'){
			document.DirForm.email2.value = document.DirForm.emailOption.value;
		}
		document.DirForm.action = "${path}/member/sujungProc";
		document.DirForm.method = "post";
		document.DirForm.submit();
	}
}
function sakje(){
	if(confirm('회원탈퇴를 하시겠습니까?')){
		document.DirForm.action = "${path}/member/sakjeProc";
		document.DirForm.method = "post";
		document.DirForm.submit();
	}
}
</script>

<style>
#changePage{
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
#table{
	margin: auto; border-collapse: collapse; width: 1020px;
}
td{
	border-top: 1px solid #666666; border-bottom: 1px solid #666666;
}
th{
	border-bottom: 1px solid #666666;
}
td:first-child{
	border-right: 1px solid #666666;
}
#tdId{
	width: 130px; height: 50px; text-align: center; background-color: #EEF1F8; color: #666666;
}
#tdId2{
	padding-left: 30px;
}
#contentCaption{
	font-size: 12px; font-weight: bold;
}
#contentId{
	font-size: 14px; color: #666666; font-weight: bold;
}
#phone1, #phone2, #phone3{
	height: 25px; width: 50px; text-align: center;
}
#phone2, #phone3{
	width: 60px;
}
#emailDiv{
	float: left;
	margin-right: 5px;
}
#email1, #email2, #sample6_postcode, #sample6_address, #sample6_detailAddress, #sample6_extraAddress{
	height: 25px; width: 130px; padding-left: 5px;
}
#email2{
	display: none; float: left; margin-right: 5px;
}
.select {
  height: 25px; width: 150px; padding: 0px 10px 0px 5px; float: left; margin-right: 5px;
}
#emailChkBtn{
 	margin-right: 5px;
}
#checkDiv{
	display: none;
	border: 1px solid white;
}
#checkCodeBtn{
	margin-top: 5px;
}
#sample6_address{
	width: 335px;
}
#sample6_extraAddress{
	width: 200px;
}
#jusoDiv1{
	padding-top: 10px;
}
#jusoDiv2, #jusoDiv3{
	padding-top: 5px;
}
#jusoDiv3{
	padding-bottom: 10px;
}
#deleteDiv{
	height: 30px; width: 100%;
	text-align: right;
}
#deleteBtn{
	margin-right: 40px;
	margin-top: 5px;
	font-size: 10px;
	height: 20px;
	background-color: white;
	border: 1px solid #666666;
	cursor: pointer;
}
#btnDiv{
	text-align: center;
}
#buttonId1, #buttonId2, #buttonId3{
	color: #666666; font-weight: bold; height: 25px;
}
#buttonId2{
	height: 30px; width: 70px; color: white; background-color: #0074E9; border: none; border-radius: 5px 5px;
}
#buttonId3{
	height: 30px; width: 70px; color: white; background-color: #92959F; border: none; border-radius: 5px 5px;
}
#menu{
	width: 1100px; margin:auto;
}
#body{
	background-color: #EBEBEB;
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