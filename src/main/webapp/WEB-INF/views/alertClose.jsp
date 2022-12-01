<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "./_include/inc_header.jsp" %>
<script>
var msg = "<c:out value='${msg}'/>";

alert(msg);
window.close();

</script>