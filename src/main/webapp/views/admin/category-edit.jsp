<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/commons/taglib.jsp"%>

<form action="${pageContext.request.contextPath }/admin/category/update"
	method="post" enctype="multipart/form-data">
	<input type="text" id="categoryid" name="categoryid" value="${cate.categoryid}" hidden="hidden"><br>
	
	<label for="fname">Category Name</label><br>
	<input type="text" id="categoryname" name="categoryname" value="${cate.categoryname}"><br>
	<label for="lname">Images:</label><br>

	<c:if test="${cate.images.substring(0,5) != 'https' }">
		<c:url value="/image?fname=${cate.images }" var="imgUrl"></c:url>
	</c:if>
	<c:if test="${cate.images.substring(0,5) == 'https' }">
		<c:url value="${cate.images }" var="imgUrl"></c:url>
	</c:if>
	<img id="images" height="150" width="200" src="${imgUrl}" /> 
	<input type="file" onchange="chooseFile(this)" id="images" name="images" value="${cate.images}"><br> 
	
	<!-- Status Radio Buttons -->
    <input type="radio" id="ston" name="status" value="1" 
           <c:if test="${cate.status == 1}">checked</c:if>>
    <label for="ston">Đang hoạt động</label><br>

    <input type="radio" id="stoff" name="status" value="0" 
           <c:if test="${cate.status == 0}">checked</c:if>>
    <label for="stoff">Khóa</label><br>

    <br> 
    <input type="submit" value="Submit">
	
	<%-- <label for="lname">Status:</label><br>
	<input type="text" id="status" name="status" value="${cate.status}"><br>
	<br> <input type="submit" value="Submit"> --%>


</form>