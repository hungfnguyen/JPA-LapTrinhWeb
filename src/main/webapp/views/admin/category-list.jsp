<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commons/taglib.jsp"%>

<a href="${pageContext.request.contextPath }/admin/category/add">Add Category</a>

<title>Category List</title>
<style>
table {
    width: 100%;
    border-collapse: collapse;
}

th, td {
    border: 1px solid black;
    padding: 10px;
    text-align: center;
}

th {
    background-color: #f2f2f2;
}
</style>

<table border="1" cellpadding="5" cellspacing="0" width="100%">
    <tr>
        <th>STT</th>
        <th>Images</th>
        <th>CategoryID</th>
        <th>CategoryName</th>
        <th>Status</th>
        <th>Action</th>
    </tr>

    <c:forEach items="${listcate}" var="cate" varStatus="STT">
        <tr>
            <td>${STT.index + 1}</td>

            <td>
                <c:if test="${cate.images.substring(0,5) != 'https'}">
                    <c:url value="/image?fname=${cate.images}" var="imgUrl" />
                </c:if>
                <c:if test="${cate.images.substring(0,5) == 'https'}">
                    <c:url value="${cate.images}" var="imgUrl" />
                </c:if>
                <img height="150" width="200" src="${imgUrl}" />
            </td>

            <td>${cate.categoryId}</td>
            <td>${cate.categoryname}</td>

            <td>
                <c:if test="${cate.status == 1}">
                    <span>Hoạt Động</span>
                </c:if>
                <c:if test="${cate.status != 1}">
                    <span>Khóa</span>
                </c:if>
            </td>

            <td>
                <a href="<c:url value='/admin/category/edit?id=${cate.categoryId}' />">Sửa</a> |
                <a href="<c:url value='/admin/category/delete?id=${cate.categoryId}' />">Xóa</a>
            </td>
        </tr>
    </c:forEach>
</table>
