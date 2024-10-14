<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglib.jsp"%>

<a href="${pageContext.request.contextPath }/admin/video/add">Add Video</a>

<title>Video List</title>
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
        <th>Thumbnail</th>
        <th>VideoID</th>
        <th>VideoTitle</th>
        <th>Status</th>
        <th>Action</th>
    </tr>

    <c:forEach items="${listvideo}" var="video" varStatus="STT">
        <tr>
            <td>${STT.index + 1}</td>

            <td>
                <c:if test="${video.thumbnail.substring(0,5) != 'https'}">
                    <c:url value="/image?fname=${video.thumbnail}" var="imgUrl" />
                </c:if>
                <c:if test="${video.thumbnail.substring(0,5) == 'https'}">
                    <c:url value="${video.thumbnail}" var="imgUrl" />
                </c:if>
                <img height="150" width="200" src="${imgUrl}" />
            </td>

            <td>${video.videoId}</td>
            <td>${video.videoTitle}</td>

            <td>
                <c:if test="${video.status == 1}">
                    <span>Hoạt Động</span>
                </c:if>
                <c:if test="${video.status != 1}">
                    <span>Khóa</span>
                </c:if>
            </td>

            <td>
                <a href="<c:url value='/admin/video/edit?id=${video.videoId}' />">Sửa</a> |
                <a href="<c:url value='/admin/video/delete?id=${video.videoId}' />">Xóa</a>
            </td>
        </tr>
    </c:forEach>
</table>
