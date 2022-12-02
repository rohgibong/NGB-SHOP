<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../_include/inc_header.jsp" %>

<c:if test="${memberNo != 1}">
	<script>
		location.href="${path }/member/warning";
	</script>
</c:if>

<div id="productPage">

<div id="img">
<a href="${path }">
	<img src="${path }/attach${path}/logo/ngbshop.png" width='230' height='45'>
</a>
</div>
${totalRecord }건 ${pageNumber } / ${map.totalPage }

<table id="table" border="1">
	<tr>
		<th width="30px">No</th>
		<th>상품이름</th>
		<th>상품가격</th>
		<th>제조사</th>
		<th>카테고리</th>
		<th width="40px">사용</th>
		<th width="90px">등록일</th>
		<th width="120px">비고</th>
	</tr>
	<c:if test="${list.size() == 0 }">
		<tr>
			<td colspan="8" align="center" height="200">등록된 상품이 없습니다.</td>
		</tr>
	</c:if>
	<c:if test="${pageNumber == 1 }">
		<c:set var="number" value="1" />
	</c:if>
	<c:if test="${pageNumber != 1 }">
		<c:set var="number" value="${(pageNumber-1) * 30 + 1 }" />
	</c:if>
	<c:forEach var="productDto" items="${list }">
		<tr align="center">
			<td>
				<font style="font-weight: bold;">${number }</font>
				<c:set var="number" value="${number + 1 }" />
			</td>
			<td>
				<a href="#" onClick="move('view', '${productDto.productCode}');">${productDto.productName }</a>
			</td>
			<td>
				<fmt:formatNumber value="${productDto.productPrice }" pattern="#,###" />원
			</td>
			<td>
				${productDto.vendorName }
			</td>
			<td>
				<c:forEach var="categoryDto" items="${categoryList }">
					<c:if test="${productDto.categoryCode == categoryDto.categoryCode }">
						${categoryDto.categoryName }
					</c:if>
				</c:forEach>
			</td>
			<td>
				${productDto.useable }
			</td>
			<td>
				${productDto.regiDate }
			</td>
			<td align="center">
			<a href="#" onClick="move('sujung', '${productDto.productCode }');">[수정]</a>
			/
			<a href="#" onClick="sakje('${productDto.productCode}');">[삭제]</a>
			</td>
		</tr>
	</c:forEach>
	
</table>

<div id="bottomDiv">
	<form name="searchForm">
	<select name="searchGubun" id="searchGubun">
		<c:if test="${searchGubun == 17}">
			<option value="0">전체</option>
			<c:forEach var="categoryDto" items="${categoryList }">
				<option value="${categoryDto.categoryCode }">${categoryDto.categoryName }</option>
			</c:forEach>
		</c:if>
		<c:if test="${searchGubun != 17}">
			<c:if test="${searchGubun == 0}">
				<option value="0" selected>전체</option>
			</c:if>
			<c:if test="${searchGubun != 0}">
				<option value="0">전체</option>
			</c:if>
			<c:forEach var="categoryDto" items="${categoryList }">
			<c:if test="${searchGubun == categoryDto.categoryCode }">
				<option value="${categoryDto.categoryCode }" selected>${categoryDto.categoryName }</option>
			</c:if>
			<c:if test="${searchGubun != categoryDto.categoryCode }">
				<option value="${categoryDto.categoryCode }">${categoryDto.categoryName }</option>
			</c:if>
			</c:forEach>
		</c:if>
	</select>
	&nbsp;
	<input type="text" name="searchData" id="searchData" value="${searchData }" style="width: 150px;">
	&nbsp;
	<button type="button" onClick="search();" id="searchBtn">검색</button>
	<c:if test="${searchGubun != 17 }">
		<button type="button" onClick="list();" id="listBtn">목록</button>
	</c:if>
	<button type="button" onClick="move('chuga', '');" id="chugaBtn">추가</button>
	</form>
	
</div>

<c:if test="${productCounter > 0 }">
<div id="pageNumberDiv">

<c:if test="${map.startPage > map.pageSize }">
	<a class="nextPage" onClick="goPage('${map.startPage - map.pageSize }');">&lt;&lt;</a>
</c:if>
<c:if test="${map.startPage <= map.pageSize }">
	<a class="nextPage" onClick="goPage('${map.startPage }');">&lt;&lt;</a>
</c:if>
<c:if test="${map.startPage != pageNumber }">
	<a class="nextPage" onClick="goPage('${pageNumber - 1}');">&lt;</a>
</c:if>
<c:if test="${map.startPage == pageNumber }">
	<a class="nextPage" onClick="goPage('${pageNumber}');">&lt;</a>
</c:if>

<c:forEach var="i" begin="${map.startPage }" end="${map.lastPage }" step="1">
	<c:if test="${i == pageNumber }">
		<a class="selectedNumber" onClick="goPage('${i}');">${i}</a>
	</c:if>
	<c:if test="${i != pageNumber }">
		<a class="nonSelectedNumber" onClick="goPage('${i}');">${i}</a>
	</c:if>
</c:forEach>

<c:if test="${map.lastPage != pageNumber }">
	<a class="nextPage" onClick="goPage('${pageNumber + 1}');">&gt;</a>
</c:if>
<c:if test="${map.lastPage == pageNumber }">
	<a class="nextPage" onClick="goPage('${pageNumber}');">&gt;</a>
</c:if>
<c:if test="${map.lastPage < map.totalPage }">
	<a class="nextPage" onClick="goPage('${map.startPage + map.pageSize }');">&gt;&gt;</a>
</c:if>
<c:if test="${map.lastPage >= map.totalPage }">
	<a class="nextPage" onClick="goPage('${map.lastPage }');">&gt;&gt;</a>
</c:if>

</div>
</c:if>

</div>

<form name="sakjeForm">
<input type="hidden" name="productCode">
</form>

<script>
function move(value1, value2){
	location.href = "${path}/product/"+value1+"?productCode="+value2;
}
function sakje(value1){
	if(confirm('삭제할까요?')){
		document.sakjeForm.productCode.value = value1;
		document.sakjeForm.action = "${path }/product/sakjeProc";
		document.sakjeForm.method = "post";
		document.sakjeForm.submit();
	}
}
function goPage(value1){
 	location.href='${path }/product/list?pageNumber='+value1+'&searchGubun=${searchGubun}&searchData=${searchData}';
}
function search(){
	document.searchForm.action = '${path}/product/list';
	document.searchForm.method = 'post';
	document.searchForm.submit();
}
function list(){
	location.href='${path}/product/list'
}
</script>

<style>
#productPage{
	width: 1200px; margin: auto; padding-top: 20px;
}
#img{
	text-align: center; margin-bottom: 20px;
}
#table{
	margin: auto; border-collapse: collapse; width: 1200px;
}
#bottomDiv{
	margin-top: 10px;
}
#chugaBtn{
	height: 30px; width: 60px;
	font-weight: bold; color: white;
	background-color: #0074E9;
	border: none; border-radius: 5px 5px;
	float: right;
}
#pageNumberDiv{
	text-align: center;
	height: 70px;
	line-height: 70px;
}
.selectedNumber{
	padding: 5px 10px;
	border: 1px solid #0074E9;
	font-size: 14px; font-weight: bold;
	color: #0074E9;
}
.selectedNumber:hover, .nonSelectedNumber:hover, .nextPage:hover{
	text-decoration: underline;
	cursor: pointer;
}
.nonSelectedNumber{
	padding: 5px 10px;
	font-size: 14px; font-weight: bold;
	color: #555555;
}
.nextPage{
	padding: 5px 10px;
	background-color: #FCFCFC;
	border: 1px solid #CCCCCC;
	font-size: 14px; font-weight: bold;
	color: #CCCCCC;
}
#searchDiv{
	width: 500px;
	border: 1px solid red;
}

</style>