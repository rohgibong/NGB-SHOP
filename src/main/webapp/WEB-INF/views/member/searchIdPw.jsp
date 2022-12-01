<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>
    
<div id="searchPage">

<div id="img">
<a href="${path }">
	<img src="${path }/attach${path}/logo/ngbshop.png" width='230' height='45'>
</a>
</div>

<div id="idSearchDiv">
	<button id="idSearch" type="button" onClick="location.href='${path }/member/searchId';">
		아이디 찾기
	</button>
</div>

<div id="hrDiv">
	<hr>
</div>

<div id="pwSearchDiv">
	<button id="pwSearch" type="button" onClick="location.href='${path }/member/searchPw';">
		비밀번호 찾기
	</button>
</div>

<div id="goLogin">
	<a href="${path }/member/login" id="login">
		로그인
	</a>
</div>

</div>


<script>

</script>


<style>
#searchPage{
	border: 0px solid red; width: 380px; margin: auto; padding-top: 20px;
}
#img{
	text-align: center; margin-bottom: 20px;
}
#idSearchDiv {
	text-align: center; padding-top: 40px;
}
#pwSearchDiv {
	text-align: center;
}
#idSearch, #pwSearch{
	 height: 50px; width: 350px;
	 font-size: 15px; font-weight: bold;
	 color: #0074E9; background-color: white; border-color: #CCCCCC;
	 cursor: pointer;
}
#hrDiv{
	width: 350px; margin: auto;
}
#goLogin{
	text-align: right; margin-right: 15px; margin-top: 5px;
}
#login{
	text-decoration: none; color: #5882FA; font-size: 13px;
}
</style>