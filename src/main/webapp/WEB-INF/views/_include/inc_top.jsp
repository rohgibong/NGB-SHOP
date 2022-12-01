<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>

<div style="width: 1200px; margin: auto;">
	<c:choose>
		<c:when test="${sessionScope.sessionNo == '' || sessionScope.sessionNo == null }">
			<a href="${path }/member/login" style="text-decoration: none; color: black;">로그인</a> &nbsp;
			<a href="${path }/member/memberJoinForm" style="text-decoration: none; color: black;">회원가입</a>
			<c:set var="imsiMemberNo" value="${imsiMemberNo = 0 }" />
		</c:when>
		<c:otherwise>
			<c:if test="${sessionScope.sessionNo == 1}">
				<button type="button" onClick="location.href='${path}/product/list';">상품관리</button> &nbsp;
				<button type="button" onClick="location.href='${path}/category/list';">카테고리관리</button> &nbsp;
				<button type="button" onClick="location.href='${path}/member/list';">회원관리</button> &nbsp;
				<a style="font-weight: bold; color: red;">(관리자)</a>
			</c:if>
			${sessionScope.sessionName }(${sessionScope.sessionId })님 &nbsp;
			<button type="button" onClick="logout();">로그아웃</button>
			<c:set var="imsiMemberNo" value="${sessionScope.sessionNo }" />
		</c:otherwise>
	</c:choose>
</div>

<form name="userForm">
	<input type="hidden" name="memberCode" id="memberCode" value="${sessionScope.sessionNo }">
	<input type="hidden" name="id" id="id" value="${sessionScope.sessionId }">
</form>

<script>
function logout(){
	$.ajax({
		type: "post",
		url: "${path }/member/logout",
		success : function(){
			location.reload();
		}
	});
	
}
</script>