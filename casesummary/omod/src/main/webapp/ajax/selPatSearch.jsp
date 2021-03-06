<%-- 
    Document   : otnoteresult
    Created on : Jan 2, 2017, 4:56:19 PM
    Author     : Khairul
--%>

<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="../includes/js_css.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
    <c:when test="${not empty listSelPat}"> 
        <table class="table table-bordered table-hover" style="cursor:pointer; font-size:13px;">
            <tr>
                <th >#</th>
                <th>Patient Name</th>
                <th >ID</th>
                <th >Diagnosis</th>
                <th >Presenter</th>
                <th >Contact No</th>
                <th > Status </th>
                <th > Pres. Date </th>
            </tr>
            <tbody>
                <c:forEach items="${listSelPat}" var="sp" varStatus="index" >
                    <tr onclick="selectPatientSingle(${sp.patientId.personId},${sp.id});">
                        <td>${index.count}</td>
                        <td> ${sp.patientId.givenName} ${sp.patientId.middleName} ${sp.patientId.familyName}</td>
                        <td> ${sp.patientId.patientIdentifier.identifier}</td>
                        <td>${sp.diagnosis} </td>
                        <td>${sp.nameOfPresenter} </td>
                        <td>${sp.contactNo} </td>
                        <td>
                            <c:if test="${sp.status eq 'true'}" >
                                <i class="fa fa-check fa-2x green" aria-hidden="true"></i>
                            </c:if>
                            <c:if test="${sp.status ne 'true'}" >
                                <i class="glyphicon glyphicon-eye-close fa-2x" aria-hidden="true"> </i>
                            </c:if>
                        </td>
                        <td> <fmt:formatDate value="${sp.presentationDate}" pattern="MM/dd/yyyy"/> </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <span style="color:red">No Patient Found.</span>
    </c:otherwise>
</c:choose>
