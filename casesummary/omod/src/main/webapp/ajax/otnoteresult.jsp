<%-- 
    Document   : otnoteresult
    Created on : Jan 2, 2017, 4:56:19 PM
    Author     : Khairul
--%>

<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="../includes/js_css.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
OT List :
<table class="table table-bordered" style="font-size:12px;">
    <tr>
        <td >#</td>
        <td >Date</td>
        <td >Time</td>
        <td >Name of OT</td>
        <td >Name of Surgeon</td>
        <td >Type of Anesthe.</td>
    </tr>

    <tbody>
        <c:forEach items="${listOtNote}" var="ot" varStatus="index" >
            <tr>
                <td>${index.count}</td>
                <td><fmt:formatDate value="${ot.date}" pattern="MM/dd/yyyy"/></td>
                <td >${ot.time}</td>
                <td  >${ot.nameOfOt}</td>
                <td >${ot.nameOfSurgeon}</td>
                <td >${ot.typeAnesthesia}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
