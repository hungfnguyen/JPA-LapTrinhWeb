<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<form action="${pageContext.request.contextPath }/admin/category/insert"
	method="post" enctype="multipart/form-data">
	<label for="fname">Category Name</label><br>
	<input type="text"
		id="categoryname" name="categoryname"><br> <label
		for="lname">Images:</label><br> 
		
		<img height="150" width="200" src="" id="images" />
		<input type="file" onchange="chooseFile(this)" id="images"
		name="images"><br>

	<p>Status:</p>
	<input type="radio" id="ston" name="status" value="1" checked>
	<label for="html">Đang hoạt động</label><br> <input type="radio"
		id="stoff" name="status" value="0"> <label for="css">Khóa</label><br>
	<input type="submit" value="insert">

	<!-- <label for="lname">Status:</label><br> 
		<input type="text" id="status" name="status" ><br>
	<br> <input type="submit" value="Submit"> -->


</form>