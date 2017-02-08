<%-- 
    Document   : otnoteresult
    Created on : Jan 2, 2017, 4:56:19 PM
    Author     : Khairul
--%>

<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="../includes/js_css.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row">
    <div class="col-sm-6 col-md-6">
        <div class="thumbnail">
            <form name="followupFormUpdate" id="followupFormUpdate" class="form-horizontal" >
                <input type="hidden" value="${f.id}" id="fId" name="fId" />
                <div class="form-group">
                    <label class="control-label col-sm-6 left"  >Diagnosis :</label>
                    <div class="col-md-6">
                        <input type="text" class="form-control input-sm" name="diagnosisFoll" id="diagnosisFoll" value="${f.diagnosis}" />												 
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-6 left"  >Date of Surgery :</label>
                    <div class="col-md-6">

                        <input type="text" data-date-format="dd/mm/yyyy" data-link-field="dtp_input2" data-link-format="dd/mm/yyyy"
                               title="dd/mm/yyyy"     id="dateSurgery" name="dateSurgery"  class="form_date pointer" 
                               value="<fmt:formatDate value="${f.dateOfSurgery}" pattern="MM/dd/yyyy"/>" /> <span style="color:#A4A4A4">dd/mm/yyyy</span>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-6 left"  >Date of Follow Up :</label>
                    <div class="col-md-6">
                        <input type="text" data-date-format="dd/mm/yyyy" data-link-field="dtp_input2" data-link-format="dd/mm/yyyy"
                               title="dd/mm/yyyy"  id="dateFollow" name="dateFollow"  class="form_date pointer" 
                               value="<fmt:formatDate value="${f.dateOfFollowUp}" pattern="MM/dd/yyyy"/>" /> <span style="color:#A4A4A4">dd/mm/yyyy</span>										 
                    </div>
                </div>
                <div>
                    Comment :
                    <textarea class="form-control" id="comment" name="comment" rows="2" placeholder="Comment">${f.comment}</textarea>
                </div>
                <br>
                <div>
                    Subsequent Plan :
                    <textarea class="form-control" id="subsequentPlan" name="subsequentPlan" rows="2" placeholder="Subsequent Plan">${f.subsequentPlan}</textarea>
                </div>
            </form>
        </div>
    </div>

    <div class="col-sm-6 col-md-6">
        <div class="thumbnail">
            <form  id="picFormUpdateFollUp" name="picFormUpdateFollUp" enctype="multipart/form-data">  
                <input type="file" id="imgInpEdit1" name="imgInpEdit1" style="display: ;" /><br>
                <img id="imgEdit1" class="example-image1" src="${pageContext.request.contextPath}/imageFolder/${f.imgNameOne}" 
                     alt="Selected Picture" width="70px;" height="70px;" />
                <br><br>
                <input type="file" id="imgInpEdit2" name="imgInpEdit2" style="display:  ;" /><br>
                <img id="imgEdit2" class="example-image1" src="${pageContext.request.contextPath}/imageFolder/${f.imgNameTwo}" 
                     alt="Selected Picture" width="70px;" height="70px;" />
                <br><br>
            </form>  
        </div>
        <button onclick="updateFollowup(${f.id});"  class="btn btn-primary" data-dismiss="modal" >
            <span class="glyphicon glyphicon-save slide"></span>&nbsp;<span>Save</span>
        </button>
    </div>

</div>

