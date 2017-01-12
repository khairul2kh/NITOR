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
        <td >Date</td>         
    </tr>
    <tbody>
        <tr>
            <td>
                <input type="text" id="dateRes" name="dateRes" value= "<fmt:formatDate value="${sp.presentationDate}" pattern="MM/dd/yyyy"/>" /></td>
        </tr>
    </tbody>
</table>
