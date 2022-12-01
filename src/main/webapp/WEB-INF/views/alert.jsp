<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "./_include/inc_header.jsp" %>
<script>
var msg = "<c:out value='${msg}'/>";
var url = "<c:out value='${url}'/>";
var path = "<c:out value='${path}'/>";

alert(msg);
location.href = path+url;

</script>