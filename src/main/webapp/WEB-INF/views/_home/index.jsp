<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

<div id="top">
	<jsp:include page="../_include/inc_top.jsp" />
</div>


<div id="menu">
	<jsp:include page="../_include/inc_menu.jsp" />
</div>

<div id="body">
	<div id="content">
		<c:if test="${folderName == 'shop' && fileName != 'view' }">
			<c:if test="${fileName != 'boughtProduct' }">
				<jsp:include page="../shop/sideMenu.jsp" />
			</c:if>
		</c:if>
		<jsp:include page="../${folderName }/${fileName }.jsp" />
	</div>
</div>

<c:if test="${!(folderName == 'shop' && fileName == 'list') }">
<div id="footer">
	Copyright 1900-2022 by localhost Co.LTD All Rights Reserved.
</div>
</c:if>





</body>
<style>
#top{
	background-color: #F0F0F0; height: 30px; line-height: 30px;
	font-size: 14px; text-align: right;
	margin-top: -8px;
}
#content{
	
}
#menu{
	height: 105px;
}
#body{
	padding-top: 20px; padding-bottom: 40px;
}
#footer{
	text-align: center; height: 70px; line-height: 70px;
}
</style>
</html>