<%-- 
    Document   : selectedPatient
    Created on : Dec 29, 2016, 10:09:32 AM
    Author     : Khairul
--%>

<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/headerMinimal.jsp"%>
<%@ include file="../includes/js_css.jsp"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
    <head>  
        <title>Selected Patient List</title>  
        <style>
            .form-horizontal .control-label{
                font-size:14px;
                font-weight:normal;

            }
            .form-control{color:black;}

            body {
                padding : 10px ;

            }
            #exTab2 h3 {
                color : white;
                background-color: #428bca;
            }
        </style>

        <script>
            var myApp = angular.module("myApp", []);
            myApp.controller('UserController', ['$scope', '$http', function($scope, $http) {

                    $scope.IsVisible = false;
                    $scope.ShowHide = function(index) {
                        $scope.IsVisible = $scope.IsVisible ? false : true;

                    };

                }]);

            if (SESSION.checkSession()) {
                $(document).ready(function() {

                    $(".sailentfet").click(function() { // Click to only happen on announce links
                        $("#patientId").val($(this).data('id'));
                        $('#sailentFeature').modal({backdrop: 'static', keyboard: false});
                        $('#sailentFeature').modal('show');
                    });

                    $(".slide").click(function() { // Click to only happen on announce links
                        $("#patientId1").val($(this).data('id'));
                        $('#slideForm').modal({backdrop: 'static', keyboard: false});
                        $('#slideForm').modal('show');
                    });

                });
            }

            function saveSailent(patientId) {

                var sailentFet = $("#sailentFet").val();
                var pid = $("#patientId").val();
                alert(pid);

                if (sailentFet == "" || sailentFet == null) {
                    return false;
                    $("#sailentFet").focus();
                }
                $.ajax({
                    // url: getContextPath() + "/module/casesummary/selectPatientSave.htm",
                    //type: "POST",
                    //dataType: 'json',
                    data: {
                        patientId: patientId,
                    },
                    success: function() {
                        alert("Successfully Added!!!");
                        window.location = "selectedPatient.htm";
                    },
                    error: function() {
                    }
                });
            }
        </script>
    </head>

    <body ng-app="myApp"  class="ng-cloak tdn" >
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
            <div class="panel panel-success" ng-controller="UserController">
                <div class="panel-heading">Selected Patient</div>
                <div class="panel-body"> 

                    <table class="table table-striped" style="font-size:12px;" >
                        <thead>
                            <tr>
                                <th>Patient Id</th>
                                <th>Patient Name</th>
                                <th>Age</th>
                                <th>Gender</th>
                                <th>Admitted Ward</th>
                                <th>Adm. Bed</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td> ${sp.patientId.patientIdentifier.identifier}</td>
                                <td> ${sp.patientId.givenName} ${sp.patientId.middleName} ${sp.patientId.familyName}</td>
                                <td>  ${age} </td>
                                <td> ${sp.patientId.gender} </td>
                                <td> ${sp.admittedWard} </td>
                                <td> ${sp.admittedBed} </td>
                            </tr>						
                        </tbody>					 
                    </table>



                    <hr></hr>

                    <div id="exTab2"  >	
                        <ul class="nav nav-tabs">
                            <li class="active">
                                <a  href="#1" data-toggle="tab">Salient Feature </a>
                            </li>
                            <li><a href="#2" data-toggle="tab">Add Slide</a>
                            </li>
                            <li><a href="#3" data-toggle="tab">OT Note</a>
                            </li>
                        </ul>

                        <div class="tab-content ">
                            <div class="tab-pane active" id="1"> <!-- sailent feature -->
                                <br>
                                <form name="sailentForm" id="sailentForm" class="form-horizontal">
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <textarea class="form-control" rows="8" name="sailentFet" id="sailentFet" placeholder="Add Salient Feature"required ></textarea>
                                            <div class="has-error" ng-show="myForm.$dirty">
                                                <span ng-show="myForm.doctorName.$error.required">This is a required field</span>
                                                <span ng-show="myForm.doctorName.$erength">Minimum length required is 3</span>
                                                <span ng-show="myForm.doctorName.$invalid">This field is invalid </span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <button onclick="savePatient('${ps.patientId}')"  class="btn btn-primary" >
                                                <span class="glyphicon glyphicon-save"></span>&nbsp;<span>Save</span>
                                            </button>
                                        </div>
                                    </div>
                                </form>

                            </div>

                            <div class="tab-pane" id="2"> <!-- Slide -->
                                <br>
                                <form name="myForm" id="myForm" class="form-horizontal">

                                    <div class="form-group">
                                        <label class="control-label col-sm-2"  >Diagnosis :</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="diagnosis" data-ng-model="data.doctorName" required ng-minlength="3"/>
                                            <div class="has-error" ng-show="myForm.$dirty">
                                                <span ng-show="myForm.doctorName.$error.required">This is a required field</span>
                                                <span ng-show="myForm.doctorName.$erength">Minimum length required is 3</span>
                                                <span ng-show="myForm.doctorName.$invalid">This field is invalid </span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <button onclick="savePatient('${ps.patientId}')"  class="btn btn-primary" >
                                                <span class="glyphicon glyphicon-save"></span>&nbsp;<span>Save</span>
                                            </button>
                                        </div>
                                    </div>


                                </form>
                            </div>

                            <div class="tab-pane" id="3"> <!-- ot note -->
                                <br>
                                <form name="myForm" id="myForm" class="form-horizontal">

                                    <div class="form-group">
                                        <label class="control-label col-sm-3"  >Doctor Name :</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="doctorName" data-ng-model="data.doctorName" required ng-minlength="3"/>
                                            <div class="has-error" ng-show="myForm.$dirty">
                                                <span ng-show="myForm.doctorName.$error.required">This is a required field</span>
                                                <span ng-show="myForm.doctorName.$erength">Minimum length required is 3</span>
                                                <span ng-show="myForm.doctorName.$invalid">This field is invalid </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-sm-3"  >Designation</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" data-ng-model="data.designation"  name="designation" />
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <button onclick="savePatient('${ps.patientId}')"  class="btn btn-primary" >
                                                <span class="glyphicon glyphicon-save"></span>&nbsp;<span>Save</span>
                                            </button>
                                        </div>
                                    </div>


                                </form>
                            </div>
                        </div> <!-- tab content -->
                    </div> <!-- main tab div -->



                </div>
            </div>

        </div>  

        <!-- modal for sailent feature -->
        <div class="modal fade" id="sailentFeature" role="dialog"  >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h2 class="modal-title"> Salient Feature </h2>
                    </div>
                    <div class="modal-body" ng-controller="UserController">
                        <form name="myForm" id="myForm" class="form-horizontal">
                            <input type=" " value="" id="patientId" ng-model="patientId" />
                            <div class="form-group">

                                <div class="col-sm-12">
                                    <textarea class="form-control" rows="8" name="sailentFet" id="sailentFet" placeholder="Add Salient Feature"required ></textarea>
                                    <div class="has-error" ng-show="myForm.$dirty">
                                        <span ng-show="myForm.doctorName.$error.required">This is a required field</span>
                                        <span ng-show="myForm.doctorName.$erength">Minimum length required is 3</span>
                                        <span ng-show="myForm.doctorName.$invalid">This field is invalid </span>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <div class="col-sm-8 left ">
                                    <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="vm.clear()">
                                        <span class="glyphicon glyphicon-ban-circle"></span>&nbsp;<span>Close</span>
                                    </button>
                                    <button onclick="saveSailent()"  class="btn btn-primary" data-dismiss="modal" ng-disabled="myForm.$invalid">
                                        <span class="glyphicon glyphicon-save"></span>&nbsp;<span>Save</span>
                                    </button>
                                </div>
                            </div> 

                        </form>
                    </div>
                    <!-- <button type="submit" class="btn btn-default" ng-click="submit()"  >Save</button>  -->
                </div>
            </div>
        </div>

        <div class="modal fade" id="slideForm" role="dialog" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h2 class="modal-title">Add Slide</h2>
                    </div>
                    <div class="modal-body" ng-controller="UserController">

                        <form name="myForm" id="myForm" class="form-horizontal">
                            <input type=" " value="" id="patientId1" ng-model="patientId" />
                            <div class="form-group">
                                <label class="control-label col-sm-3"  >Doctor Name :</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="doctorName" data-ng-model="data.doctorName" required ng-minlength="3"/>
                                    <div class="has-error" ng-show="myForm.$dirty">
                                        <span ng-show="myForm.doctorName.$error.required">This is a required field</span>
                                        <span ng-show="myForm.doctorName.$erength">Minimum length required is 3</span>
                                        <span ng-show="myForm.doctorName.$invalid">This field is invalid </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-3"  >Designation</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" data-ng-model="data.designation"  name="designation" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-3"  >Course</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control"  data-ng-model="data.course"  name="course" required ng-minlength="3" />
                                    <div class="has-error" ng-show="myForm.$dirty">
                                        <span ng-show="myForm.doctorName.$error.required">This is a required field</span>
                                        <span ng-show="myForm.course.$erength">Minimum length required is 3</span>
                                        <span ng-show="myForm.course.$invalid">This field is invalid </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-3"  >Session</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" data-ng-model="data.session"   name="session" />
                                </div>
                            </div>
                            <div class="modal-footer">
                                <div class="col-sm-8 left ">
                                    <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="vm.clear()">
                                        <span class="glyphicon glyphicon-ban-circle"></span>&nbsp;<span>Close</span>
                                    </button>
                                    <button data-ng-click="submit()"  class="btn btn-primary" data-dismiss="modal" ng-disabled="myForm.$invalid">
                                        <span class="glyphicon glyphicon-save"></span>&nbsp;<span>Save</span>
                                    </button>
                                </div>
                            </div> 
                        </form>
                    </div>
                    <!-- <button type="submit" class="btn btn-default" ng-click="submit()"  >Save</button>  -->
                </div>
            </div>
        </div>

    </body>
    <%@ include file="/WEB-INF/template/footer.jsp"%>
</html>