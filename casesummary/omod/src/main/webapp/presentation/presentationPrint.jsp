<%-- 
    Document   : presentationPrint
    Created on : Jan 26, 2017, 12:52:41 PM
    Author     : Khairul
--%>

<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="printDiv" >
    <table class="fs-16 trc">
        <c:if test="${preIn ne 'null'}">
            <tr style="border-bottom:1px solid #eee;"> 
                <td width="20%;"> Doctor Name  </td> <td width="5%;"> : </td>  <td width="40%;"> ${dp.doctorName} </td>
            </tr>
            <tr> 
                <td> Designation  </td> <td width="5%;"> : </td>  <td> ${dp.designation} </td>
            </tr>
            <tr> 
                <td> Course  </td> <td width="5%;"> :</td>  <td> ${dp.course} </td>
            </tr>
            <tr> 
                <td> Session </td> <td width="5%;">: </td>   <td> ${dp.session} </td>
            </tr>
        </c:if>

        <c:if test="${patIn ne 'null'}">  
            <tr height="20px;"> <td colspan="3"> </td> </tr>
            <tr style="border-bottom:1px solid #eee;"> 
                <td width="20%"> Patient Name </td> <td width="5%;"> : </td>  
                <td width="40%">${sp.patientId.givenName} ${sp.patientId.middleName} ${sp.patientId.familyName}</td>
            </tr>									
            <tr style="border-bottom:1px solid #eee;"> 
                <td> Age  </td> <td width="5%;"> : </td>  <td> ${age} </td>
            </tr>
            <tr style="border-bottom:1px solid #eee;"> 
                <td> Sex  </td> <td width="5%;"> :</td>  <td> ${sex} </td>
            </tr>
            <tr style="border-bottom:1px solid #eee;"> 
                <td> Contact No.  </td> <td width="5%;"> :</td>  <td> ${sp.contactNo} </td>
            </tr>
            <tr style="border-bottom:1px solid #eee;"> 
                <td> Address </td> <td width="5%;">: </td>   <td> ${sp.address} </td>
            </tr>
            <tr style="border-bottom:1px solid #eee;"> 
                <td> Reg. No </td> <td width="5%;">: </td>   <td> ${sp.patientId.patientIdentifier.identifier} </td>
            </tr>
            <tr style="border-bottom:1px solid #eee;"> 
                <td> Admitted Form </td> <td width="5%;">: </td>   <td> ${sp.admittedForm} </td>
            </tr>
            <tr style="border-bottom:1px solid #eee;"> 
                <td>Admission Date </td> <td width="5%;">: </td>   
                <td>
                    <fmt:formatDate value="${sp.dateOfAdmission}" pattern="dd/MM/yyyy"/>
                </td>
            </tr>
            <tr style="border-bottom:1px solid #eee;"> 
                <td> Admitted Ward </td> <td width="5%;">: </td>   <td> ${sp.admittedWard} </td>
            </tr>
            <tr style="border-bottom:1px solid #eee;"> 
                <td> Admitted Bed </td> <td width="5%;">: </td>   <td> ${sp.admittedBed} </td>
            </tr>
        </c:if>
    </table>

    <c:if test="${sf ne 'null'}">  
        <div> <!-- sailent feat -->
            <div class="row">
                <br>
                <span style="font-weight:bold"> Salient Feature : </span>

                <div class="col-sm-2 col-md-2"> 
                </div>
                <div class="col-sm-8 col-md-8 fs-18" >  
                    <div class="form-group">
                        ${sf.sailentFeature}
                    </div>                                                                                 
                </div>
                <div class="col-sm-2 col-md-2"> 
                </div>
            </div>
        </div>
    </c:if>
    <br>
    <c:if test="${sliIn ne 'null'}"> 
        <div class="row">
            <div class="col-sm-6 col-md-6 fs-18">
                <div class="thumbnail">
                    <div class="form-group">
                        <b> Diagnosis : </b> 
                        <c:forEach items="${listSlide}" var="ls" >
                            ${ls.diagnosis},
                        </c:forEach>
                    </div>                                                
                </div>
            </div>
            <br>
            <div class="col-sm-6 col-md-6 fs-18">
                <div class="thumbnail">
                    <div class="form-group">
                        <div>
                            <b>Plan : </b> 
                            <c:forEach items="${listSlide}" var="ls" >
                                ${ls.plan},
                            </c:forEach>							  
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</div>
<br> <br> 
<button style="cursor:pointer" value="Print" onClick="printDiv3();"> Print </button>

<script>
    function printDiv3() {
        var printer = window.open('left=0', 'top=0', 'width=300,height=300');
        printer.document.open("text/html");
        printer.document.write(document.getElementById('printDiv').innerHTML);
        printer.print();
        printer.document.close();
        printer.window.close();
        window.close();

        // window.location = "directbillingqueue.form";
    }
</script>