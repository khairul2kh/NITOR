<%-- 
    Document   : otnoteresult
    Created on : Jan 2, 2017, 4:56:19 PM
    Author     : Khairul
--%>

<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="../includes/js_css.jsp"%>

<div class="row">
    <div class="col-sm-6 col-md-6">
        <div class="thumbnail">
            <form name="editFormSlide" id="editFormSlide"   >
                <input type="hidden" value="${s.id}" id="sId" name="sId" />
                <div class="form-group">
                    <div class="col-sm-12">
                        <label>Diagnosis :</label>
                        <input type="text" class="form-control" name="upDiagnosis"  id="upDiagnosis" value="${s.diagnosis}"/>
                    </div>
                </div> 
                <div class="form-group">
                    <div class="col-sm-12">
                        <label>Plan :</label>
                        <textarea class="form-control" id="upPlan" name="upPlan" rows="6" placeholder="Message">${s.plan}</textarea>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="col-sm-6 col-md-6">
        <div class="thumbnail">
            <form  id="picFormUpdate" name="picFormUpdateFollUp" enctype="multipart/form-data">  
                <input type="file" id="imgInpEdit1" name="imgInpEdit1" style="display: ;" /><br>
                <img id="imgEdit1" class="example-image1" src="${pageContext.request.contextPath}/imageFolder/${s.imgNameOne}" 
                     alt="Selected Picture" width="70px;" height="70px;" />
                <br><br>
                <input type="file" id="imgInpEdit2" name="imgInpEdit2" style="display:  ;" /><br>
                <img id="imgEdit2" class="example-image1" src="${pageContext.request.contextPath}/imageFolder/${s.imgNameTwo}" 
                     alt="Selected Picture" width="70px;" height="70px;" />
                <br><br>
            </form>  
        </div>
        <button onclick="updateSlide(${s.id});"  class="btn btn-primary" data-dismiss="modal" >
            <span class="glyphicon glyphicon-save slide"></span>&nbsp;<span>Save</span>
        </button>
    </div>

</div>

