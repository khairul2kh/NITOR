<%-- 
    Document   : patientSearchInSystem
    Created on : Jan 04, 2017, 11:57:13 AM
    Author     : Khairul
--%>
<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="../includes/js_css.jsp"%>
<hr>
<c:choose>
    <c:when test="${not empty listSelPat}"> 
        <table class="table table-bordered table-hover" style="cursor:pointer; font-size:12px;">
            <thead>
                <tr>
                    <th width="5%">S.No</th>
                    <th>Presenter Name</th>
                    <th>Unit Name</th>
                    <th>Diagnosis</th>
                    <th width="10%">Status</th>
                </tr>
            </thead> 
            <tbody>
                <c:forEach items="${listSelPat}" var="patient" varStatus="index">
                    <c:if test="${patient.status eq 'true'}" >
                        <tr onclick="goPresentation('${patient.id}');">
                            <td class="green">${index.count}</td>
                            <td class="green"> ${patient.nameOfPresenter} </td>
                            <td class="green"> ${patient.unit} </td>
                            <td class="green"> ${patient.diagnosis} </td>
                            <td>  <i class="fa fa-check fa-2x green" aria-hidden="true"></i> </td>
                        </tr>
                    </c:if>
                    <c:if test="${patient.status ne 'true'}" >
                        <tr onclick="goPresentation('${patient.id}');">
                            <td>${index.count}</td>
                            <td> ${patient.nameOfPresenter} </td>
                            <td> ${patient.unit} </td>
                            <td> ${patient.diagnosis} </td>
                            <td> Not Presentation	</td>
                        </tr>
                    </c:if>
                </c:forEach>
            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <span style="color:red">No Presenter Found.</span>
    </c:otherwise>
</c:choose>