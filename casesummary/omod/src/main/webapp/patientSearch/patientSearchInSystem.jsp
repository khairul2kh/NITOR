<%-- 
    Document   : patientSearchInSystem
    Created on : Dec 26, 2016, 11:57:13 AM
    Author     : Khairul
--%>

<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="../includes/js_css.jsp"%>
 
<c:choose>
    <c:when test="${not empty listPatient}"> 
        <table class="table table-bordered table-hover" style="cursor:pointer;">
            <thead>
                <tr>
                    <th><b>S.No</b></th>
                    <th><b>Patient Id</b></th>
                    <th><b>Name</b></th>
                    <th><b>Age</b></th>
                    <th><b>Gender</b></th>
                    <th><b>Phone No</b></th>
                </tr>
            </thead> 
            <tbody>
                <c:forEach items="${listPatient}" var="patient" varStatus="varStatus">
                    <tr onclick="selectPatient('${patient.patientId}');">
                        <td> ${varStatus.count} </td>
                        <td>${patient.identifier}</td>
                        <td>${patient.givenName} ${patient.middleName}  ${patient.familyName}                         </td>
                        <td>${patient.age}</td>
                        <td><c:choose>
                                <c:when test="${patient.gender eq 'M'}">
                                    <img src="${pageContext.request.contextPath}/images/male.gif" />
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/images/female.gif" />
                                </c:otherwise>
                            </c:choose></td>
                        <td>   </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <span style="color:red">No Patient Found.</span>
    </c:otherwise>
</c:choose>