<%-- 
    Document   : selectPatient
    Created on : Dec 26, 2016, 3:29:18 PM
    Author     : Khairul
--%>

<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/headerMinimal.jsp"%>
<%@ include file="../includes/js_css.jsp"%> 

<html>
    <head>  

        <title>Doctor Profile Entry Form</title>  

        <style>
            .form-horizontal .control-label{
                font-size:14px;
                font-weight:normal;
            }
            .form-control{color:black;}
        </style>

        <script>
            var myApp = angular.module("myApp", []);
            myApp.controller('UserController', ['$scope', '$http', function($scope, $http) {


                    //$scope.docName=${docPro.doctorName};
                    //   $scope.docorProfile = [{doctorName: "khairul", designation: "Hasan Zamil", session: "jakir@gmail.com"}];
                }]);

            if (SESSION.checkSession()) {
                $(document).ready(function() {
                    jQuery('#pdate').datepicker({yearRange: 'c-30:c+30', dateFormat: 'dd/mm/yy', changeMonth: true, changeYear: true});
                    jQuery("#searchKey").keyup(function(event) {
                        if (event.keyCode == 13) {
                            getPatientInSystem();
                        }
                    });

                    $('#selectPatientForm').formValidation({
                        framework: 'bootstrap',
                        excluded: ':disabled',
                        icon: {
                            valid: 'glyphicon glyphicon-ok',
                            invalid: 'glyphicon glyphicon-remove',
                            validating: 'glyphicon glyphicon-refresh'
                        },
                        fields: {
                            pdate: {
                                validators: {
                                    notEmpty: {
                                        message: 'The doctor Name is required'
                                    }
                                }
                            },
                            password: {
                                validators: {
                                    notEmpty: {
                                        message: 'The password is required'
                                    }
                                }
                            }
                        }
                    });
                });
            }

            function savePatient(patientId) {

                var address = $("#address").val();
                var fatherName = $("#fatherName").val();
                var diagnosis = $("#diagnosis").val();
                var icdCode = $("#icdCode").val();
                var nameOfPresenter = $("#nameOfPresenter").val();
                var pdate = $("#pdate").val();
                var award = $("#award").val();
                var abed = $("#abed").val();
                var unit = $("#unit").val();

                if (pdate == "" || pdate == null) {
                    return false;
                }

                $.ajax({
                    url: getContextPath() + "/module/casesummary/selectPatientSave.htm",
                    type: "POST",
                    //dataType: 'json',
                    data: {
                        patientId: patientId,
                        address: address,
                        fatherName: fatherName,
                        diagnosis: diagnosis,
                        icdCode: icdCode,
                        nameOfPresenter: nameOfPresenter,
                        pdate: pdate,
                        award: award,
                        abed: abed,
                        unit: unit
                    },
                    success: function() {
                        alert("Successfully Added!!!");
                        window.location = "selectedPatientSingle.htm?patientId="+patientId;
                    },
                    error: function() {


                    }
                });
            }

        </script>
    </head>

    <body ng-app="myApp"  class="ng-cloak tdn">
        <!-- <nav class="navbar navbar-default navbar-fixed-top"> -->
        <nav class="navbar navbar-default navbar-fixed-top" role="navigation">     
            <div class="container">
                <div class="navbar-header" style="padding-top:12px;">
                    <span> Welcome Mr./Ms. : ${u.person.givenName} ${u.person.middleName} ${u.person.familyName} </span>
                </div>
                <div class="navbar-collapse" uib-collapse="vm.isNavbarCollapsed" ng-switch="vm.isAuthenticated()">

                    <ul class="nav navbar-nav navbar-right">
                        <li ui-sref-active="active">
                            <a ui-sref="home" href="${pageContext.request.contextPath}/">
                                <span class="glyphicon glyphicon-home"></span>
                                <span class="hidden-sm">Home</span>
                            </a>
                        </li>
                        <li   class="dropdown pointer">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="" id="account-menu">
                                <span>
                                    <span class="glyphicon glyphicon-user"></span>
                                    <span class="hidden-sm">
                                        Account
                                    </span>
                                    <b class="caret"></b>
                                </span>
                            </a>
                            <ul class="dropdown-menu" role="menu" >
                                <c:if test="${empty docPro}">
                                    <li><a role="menuitem" tabindex="-1" href="main.form" 
                                           data-backdrop="static" data-keyboard="false"> Main </a></li>
                                    </c:if>
                                <li role="presentation" class="divider"></li>
                                <li><a role="menuitem" tabindex="-1" href='${pageContext.request.contextPath}/logout'>
                                        <span class="glyphicon glyphicon-log-out"></span>&nbsp; Log Out</a></li>
                            </ul>
                        </li>
                    </ul> 
                </div>
            </div>
        </nav> 
        <br><br><br>
        <!-- Main Body Start Here -->
        <div class="container theme-showcase" role="main" ng-controller="UserController">

            <div class="panel panel-success">
                <div class="panel-heading">Patient Information</div>
                <div class="panel-body"> 

                    <form class="form-horizontal" id="selectPatientForm" name="selectPatientForm" data-toggle="validator"  >
                        <div class="form-group">
                            <label class="control-label col-sm-2"    for="pname">Patient Name </label>
                            <label class="control-label col-sm-1"   >:</label>
                            <div class="col-sm-8"> 
                                <input type="text" style="padding-left:10px;" readonly="true" class="form-control" id="pname" name="pname" value="${ps.givenName} ${ps.middleName} ${ps.familyName}" >
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-2"     for="pid">Patient ID </label>
                            <label class="control-label col-sm-1"   >:</label>
                            <div class="col-sm-8"> 
                                <input type="text" style="padding-left:10px;" readonly="true" class="form-control" id="pid" name="pid" value="${ps.identifier}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-2"    for="age">Age </label>
                            <label class="control-label col-sm-1"   >:</label>
                            <div class="col-sm-8"> 
                                <input type="text" style="padding-left:10px;" readonly="true" class="form-control" id="age" name="age" value="${ps.age}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-2"   for="address">Address </label>
                            <label class="control-label col-sm-1"   >:</label>
                            <div class="col-sm-8"> 
                                <textarea class="form-control" rows="3" name="address" id="address" placeholder="Please Enter Address" ></textarea>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-2"   for="fname">Father's Name </label>
                            <label class="control-label col-sm-1"   >:</label>
                            <div class="col-sm-8"> 
                                <input type="text" style="padding-left:10px;" class="form-control" id="fatherName" name="fatherName">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-2"   for="diagnosis">Diagnosis </label>
                            <label class="control-label col-sm-1"   >:</label>
                            <div class="col-sm-8"> 
                                <input type="text" style="padding-left:10px;" class="form-control" id="diagnosis" name="diagnosis">
                            </div>
                        </div>

                        <div class="form-group">

                            <label class="control-label col-sm-2" for="icdcode">ICD 10 Code </label>
                            <label class="control-label col-sm-1"   >:</label>
                            <div class="col-md-2">
                                <input type="text" style="padding-left:10px;" name="icdCode"  id="icdCode" class="form-control" placeholder="ICD Code" />                  
                            </div>
                            <div class="col-md-2">
                                <input type="text" style="padding-left:10px;" name="icdCode1"  id="icdCode1" class="form-control" placeholder="ICD Code" />                  
                            </div>
                            <div class="col-md-2">
                                <input type="text" style="padding-left:10px;" name="icdCode2"  id="icdCode2" class="form-control" placeholder="ICD Code" />                  
                            </div>
                            <div class="col-md-2">
                                <input type="text" style="padding-left:10px;" name="icdCode3"  id="icdCode3" class="form-control" placeholder="ICD Code" />                  
                            </div> 

                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-2"   for="nofpre">Name of Presenter</label>
                            <label class="control-label col-sm-1"   >:</label>
                            <div class="col-sm-8"> 
                                <input type="text" style="padding-left:10px;" class="form-control" id="nameOfPresenter" name="nameOfPresenter" value="${u.person.givenName} ${u.person.middleName} ${u.person.familyName}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-2"   for="pdate">Presentation Date </label>
                            <label class="control-label col-sm-1"   >:</label>
                            <div class="col-sm-3"> 
                                <input type="text" style="padding-left:10px;" name="pdate"  id="pdate"  class="username form-control input-sm" placeholder="Enter date" required >                  

                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-2"   for="award">Admitted Ward </label>
                            <label class="control-label col-sm-1"   >:</label>
                            <div class="col-sm-8"> 
                                <input type="text" style="padding-left:10px;" class="form-control" id="award" name="award" >
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-2"   for="abed">Admitted bed </label>
                            <label class="control-label col-sm-1"   >:</label>
                            <div class="col-sm-3"> 
                                <input type="text" style="padding-left:10px;" class="form-control" id="abed" name="abed" >
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-2"   for="gender">Gender </label>
                            <label class="control-label col-sm-1"   >:</label>
                            <div class="col-sm-3"> 
                                <input type="text" style="padding-left:10px;" readonly="true" class="form-control" id="gender" name="gender" value="${ps.gender}" >
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-2"   for="unit">Unit </label>
                            <label class="control-label col-sm-1"   >:</label>
                            <div class="col-sm-3"> 
                                <input type="text" style="padding-left:10px;" class="form-control" id="unit" name="unit"   >
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-10">
                                <button onclick="savePatient('${ps.patientId}')"  class="btn btn-primary" >
                                    <span class="glyphicon glyphicon-save"></span>&nbsp;<span>Save</span>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>  
    </body>
    <%@ include file="/WEB-INF/template/footer.jsp"%>
</html>