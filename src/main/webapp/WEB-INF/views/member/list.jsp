<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>

<c:if test="${memberNo != 1}">
	<script>
		location.href="${path }/member/warning";
	</script>
</c:if>

<div id="memberPage">

<div id="img">
<a href="${path }">
	<img src="${path }/attach${path}/logo/ngbshop.png" width='230' height='45'>
</a>
</div>

<table id="table" border="1">
	<tr>
		<th width="50px">No</th>
		<th>아이디</th>
		<th>비밀번호</th>
		<th>이름</th>
		<th width="120px">연락처</th>
		<th>주소</th>
		<th width="90px">가입일</th>
	</tr>
	<c:if test="${list.size() == 0 }">
		<tr>
			<td colspan="7" align="center" height="200">등록된 회원이 없습니다.</td>
		</tr>
	</c:if>
	
	<c:set var="number" value="${list.size()-1 }" />
	<c:forEach var="dto" items="${list }">
	<c:set var="passwd" value="${dto.passwd }" />
		<tr align="center">
			<td>
				<c:if test="${dto.memberCode == '1' }">
					<font style="font-weight: bold; color: red;">관리자</font>
				</c:if>
				<c:if test="${dto.memberCode != '1' }">
					<font style="font-weight: bold;">${number }</font>
					<c:set var="number" value="${number - 1 }" />
				</c:if>
			</td>
			<td>${dto.id }</td>
			<td>
				<c:forEach begin="1" end="${passwd.length() }" step="1">*</c:forEach>
			</td>
			<td>${dto.name }</td>
			<td>${dto.phone1 }-${dto.phone2 }-${dto.phone3 }</td>
			<td>(${dto.juso1 }) ${dto.juso2 } ${dto.juso3 } ${dto.juso4 }</td>
			<td>${dto.regiDate }</td>
		</tr>
	</c:forEach>
	
</table>

</div>


<style>
#memberPage{
	border: 0px solid red; width: 1300px; margin: auto; padding-top: 20px;
}
#img{
	text-align: center; margin-bottom: 20px;
}
#table{
	margin: auto; border-collapse: collapse; width: 1200px;
}

</style>