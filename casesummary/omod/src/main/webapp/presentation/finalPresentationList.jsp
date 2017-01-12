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
                    <th  width="10%;">Status</th>
                    <th  width="10%;">Reschedule</th>
                </tr>
            </thead> 
            <tbody>
                <c:forEach items="${listSelPat}" var="patient" varStatus="index">
                    <c:if test="${patient.status eq 'true'}" >
                        <tr title="${patient.id}, ${patient.patientId.givenName}" >
                            <td onclick="goPresentation('${patient.id}');" class="green">${index.count}</td>
                            <td onclick="goPresentation('${patient.id}');" class="green"> ${patient.nameOfPresenter} </td>
                            <td onclick="goPresentation('${patient.id}');" class="green"> ${patient.unit} </td>
                            <td onclick="goPresentation('${patient.id}');" class="green"> ${patient.diagnosis} </td>
                            <td onclick="goPresentation('${patient.id}');" align="center">  <i class="fa fa-check fa-2x green" aria-hidden="true"></i> </td>
                            <td> 
                                <input type="button" onclick="modalClick('${patient.id}');" value="Reschedule" class="btn btn-warning" /> 
                            </td>
                        </tr>
                    </c:if>

                    <c:if test="${patient.status ne 'true'}" >
                        <tr title="${patient.id}, ${patient.patientId.givenName}" >
                            <td onclick="goPresentation('${patient.id}');">${index.count}</td>
                            <td onclick="goPresentation('${patient.id}');" > ${patient.nameOfPresenter} </td>
                            <td onclick="goPresentation('${patient.id}');"> ${patient.unit} </td>
                            <td onclick="goPresentation('${patient.id}');"> ${patient.diagnosis} </td>
                            <td onclick="goPresentation('${patient.id}');" align="center"> <i class="glyphicon glyphicon-eye-close fa-2x" aria-hidden="true"> </i> 	</td> 
                            <td> 
                                <input type="button" onclick="modalClick('${patient.id}');" value="Reschedule" class="btn btn-warning" /> 
                            </td>
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