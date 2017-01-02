<%-- 
    Document   : otnoteresult
    Created on : Jan 2, 2017, 4:56:19 PM
    Author     : Khairul
--%>

<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="../includes/js_css.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<table class="table table-bordered" style="font-size:12px;">
    <tr>
        <td colspan="1">#</td>
        <td colspan="1">Date</td>
        <td colspan="2">Time<td>
        <td colspan="2">Name of OT<td>
    </tr>

    <tbody>
        <c:forEach items="${listOtNote}" var="ot" varStatus="index" >
            <tr>
                <td>${index.count}</td>
                <td><fmt:formatDate value="${ot.date}" pattern="MM/dd/yyyy"/></td>
                <td colspan="2">${ot.time}</td>
                <td colspan="2">${ot.nameOfOt}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
