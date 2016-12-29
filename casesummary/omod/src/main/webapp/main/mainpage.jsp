<%-- 
    Document   : main
    Created on : Dec 19, 2016, 11:00:17 AM
    Author     : Khairul
--%>
<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/headerMinimal.jsp"%>
<%@ include file="../includes/js_css.jsp"%> 

<html>
    <head>  

        <title>Doctor Profile Entry Form</title>  

        <script>
            var myApp = angular.module("myApp", []);
            myApp.controller('UserController', ['$scope', '$http', function($scope, $http) {
                    $scope.messages = [];
                    // AngularJS will populate this object with input
                    // values based on the data-ng-model mappings.


                    $scope.data = {};
                    $scope.submit = function() {
                        $http({
                            method: 'POST',
                            url: getContextPath() + '/module/casesummary/createDoctor.htm',
                            data: $scope.data
                        }).
                                success(function(data, status, headers) {
                                    //$window.location.replace(getContextPath() +'/module/casesummary/createDoctor.htm');
                                    location.reload();
                                }).
                                error(function(data, status, headers) {
                                    if (status == 400) {
                                        $scope.messages = data;
                                    } else {
                                        location.reload();
                                    }
                                });
                    };


                    $scope.IsVisible = false;
                    $scope.ShowHide = function() {
                        $scope.IsVisible = $scope.IsVisible ? false : true;
                    };

                    //$scope.docName=${docPro.doctorName};
                    //   $scope.docorProfile = [{doctorName: "khairul", designation: "Hasan Zamil", session: "jakir@gmail.com"}];
                }]);

            // setTimeout(function() {
            // $('#loadPage').modal('hide');
            // }, 2000);

            // $(window).load(function() {
            // $('#loadPage').modal('show');
            // });

            if (SESSION.checkSession()) {
                $(document).ready(function() {
                    jQuery("#searchKey").keyup(function(event) {
                        if (event.keyCode == 13) {
                            getPatientInSystem();
                        }
                    });

                    $('#myForm').formValidation({
                        framework: 'bootstrap',
                        excluded: ':disabled',
                        icon: {
                            valid: 'glyphicon glyphicon-ok',
                            invalid: 'glyphicon glyphicon-remove',
                            validating: 'glyphicon glyphicon-refresh'
                        },
                        fields: {
                            doctorName: {
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

            function updateDoc() {
                var id = $("#id").val();
                var doctorName = $("#docName").val();
                var designation = $("#designation").val();
                var course = $("#course").val();
                var session = $("#session").val();
                $.ajax({
                    url: getContextPath() + "/module/casesummary/update.form",
                    type: "POST",
                    //dataType: 'json',
                    data: {
                        id: id,
                        doctorName: doctorName,
                        designation: designation,
                        course: course,
                        session: session
                    },
                    success: function() {
                        alert("Successfully Updated!!!");
                    },
                    error: function() {
                        alert("Successfully Paid Commission!");
                        window.location = "main.form";
                    }
                });

            }

            function getPatientInSystem() {
                var searchKey = jQuery("#searchKey").val();
                jQuery.ajax({
                    type: "GET",
                    url: getContextPath() + "/module/casesummary/patientSerach.htm",
                    data: ({
                        searchKey: searchKey
                    }),
                    success: function(data) {
                        jQuery("#patientqueue").html(data);
                    },
                });
            }
            ;
            function selectPatient(patientId) {
                alert(patientId);
                window.location.href = openmrsContextPath + "/module/casesummary/selectPatient.htm?patientId=" + patientId;
            }
            ;

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
                                    <li><a role="menuitem" tabindex="-1" href="" data-toggle="modal" data-target="#doctorProfile" 
                                           data-backdrop="static" data-keyboard="false"> Add Doctor Profile</a></li>
                                    </c:if>

                                <c:if test="${not empty docPro}">
                                    <li><a role="menuitem" tabindex="-1" href="" data-toggle="modal" data-target="#doctorProfileEdit" 
                                           data-backdrop="static" data-keyboard="false"> Update Doctor Profile</a></li>
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

            <div class="panel panel-success" ng-hide = "IsVisible">
                <div class="panel-heading">Please Select Patient</div>
                <div class="panel-body"> 
                    <div class="row">
                        <div class="col-sm-3">
                            <div ng-hide="IsVisible">
                                <div class="input-group" id="seracrButton">
                                    <input type="button"  ng-click="ShowHide()" style="text-align:left;"  value="Add Patient" class="form-control btn btn-success" 
                                           data-toggle="modal" data-target="#" data-backdrop="static" data-keyboard="false" />
                                    <span class = "input-group-addon btn" ng-click="ShowHide()" data-toggle="modal" data-target="#" data-backdrop="static" data-keyboard="false">
                                        <i class="fa fa-user-o green" aria-hidden="true"></i>
                                    </span>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="panel panel-success" ng-hide = "IsVisible">
                <div class="panel-heading">Selected Patient List </div>
                <div class="panel-body"> 

                    <div class="row">
                        <div class="col-sm-3">
                            <div ng-hide="IsVisible">
                                <div class="input-group" id="seracrButton">
                                    <input type="button"    style="text-align:left;"  value="Selected Patient List" class="form-control btn btn-info" 
                                           onclick="location.href = 'selectedPatient.htm';" />
                                    <span class = "input-group-addon btn"   data-toggle="modal" data-target="#" data-backdrop="static" data-keyboard="false">
                                        <i class="glyphicon glyphicon-th-list blue" aria-hidden="true"></i>
                                    </span>
                                </div>

                            </div>
                        </div>
                    </div>

                </div>
            </div>


            <!-- Patient Search Div -->
            <div class="col-sm-14" id="patientSearch" ng-show = "IsVisible">

                <div class="panel panel-success"> <!-- panel -->
                    <div class="panel-heading text-left">Patient Search
                        <b class="pull-right text-uppercase">Search By <span style="color:red;"> {{searchKey}} </span></b>
                    </div>
                    <div class="panel-body">  <!-- panel body -->					
                        <div class="row">
                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label class="control-label" for="inputGroup">Search By Patient Id/Name </label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="searchKey" name="searchKey"
                                               placeholder="Please Enter Patient Id / Name" ng-model="searchKey"/>  

                                        <span class="input-group-addon btn btn-success" onClick="getPatientInSystem();" >
                                            <i class="fa fa-search" style="cursor:pointer;"></i>
                                        </span>
                                    </div>
                                </div>								
                                <div role="alert">
                                    <span class="error" ng-show="searchForm.searchKey.$error.minlength">
                                        Too short!</span>
                                </div>
                            </div>							 
                        </div><!-- /.row -->
                        <div id="patientqueue" style="padding:4px;"></div> 
                        <button ng-click="ShowHide()" class="btn btn-danger pull-right">Close &nbsp; <i class="glyphicon glyphicon-remove"> </i></button>
                    </div>
                </div> <!-- panel end -->

            </div>
        </div>  

        <!-- Modal Doctor Profile -->
        <div class="modal fade" id="doctorProfile" role="dialog" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h2 class="modal-title">Create Doctor Profile</h2>
                    </div>
                    <div class="modal-body" ng-controller="UserController">
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
        <!-- Modal Doctor Profile End -->

        <!-- Modal Doctor Profile Update -->
        <div class="modal fade" id="doctorProfileEdit" role="dialog" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h2 class="modal-title">Update Doctor Profile</h2>
                    </div>
                    <div class="modal-body" >
                        <form name="myForm" id="myForm" class="form-horizontal" >
                            <input type="hidden" value="${u.userId}" name="id" id="id"/>
                            <div class="form-group">
                                <label class="control-label col-sm-3"  >Doctor Name :</label>
                                <div class="col-sm-8"> 
                                    <input type="text" class="form-control" name="docName" value="${docPro.doctorName}" id="docName"  required ng-minlength="3"/>
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
                                    <input type="text" class="form-control" value="${docPro.designation}"  id="designation" name="designation" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-3"  >Course</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" value="${docPro.course}"  id="course"  name="course" required ng-minlength="3" />
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
                                    <input type="text" class="form-control" value="${docPro.session}" id="session" name="session" />
                                </div>
                            </div>
                            <div class="modal-footer">
                                <div class="col-sm-8 left ">
                                    <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="vm.clear()">
                                        <span class="glyphicon glyphicon-ban-circle"></span>&nbsp;<span>Close</span>
                                    </button>
                                    <button onclick="updateDoc()"  class="btn btn-primary" data-dismiss="modal" ng-disabled="myForm.$invalid">
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
        <!-- Modal Doctor Profile End -->

        <div class="modal fade" id="loadPage" role="dialog" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <img src="${pageContext.request.contextPath}/moduleResources/casesummary/loader.gif" id="loading-indicator" style="display: " />
                </div>
            </div>
        </div>

    </body>
    <%@ include file="/WEB-INF/template/footer.jsp"%>
</html>

