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
                text-align:left;
                padding-left:30px;
                color:black;
            }
            .form-control{color:black;}
            body {
                padding : 10px ;
            }
            #exTab2 h3 {
                color : white;
                background-color: #428bca;
            }
            .nav-tabs {background-color:;}
        </style>

        <script>
            var myApp = angular.module("myApp", []);
            myApp.controller('UserController', ['$scope', '$http', function($scope, $http) {

                    $scope.IsVisible = false;
                    $scope.ShowHide = function(index) {
                        $scope.IsVisible = $scope.IsVisible ? false : true;
                    };
                    $scope.sf = "${sf.sailentFeature}";
                }]);

            if (SESSION.checkSession()) {
                $(document).ready(function() {
                    jQuery('#otDate').datepicker({yearRange: 'c-30:c+30', dateFormat: 'dd/mm/yy', changeMonth: true, changeYear: true});

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


                    function readURL(input) {
                        if (input.files && input.files[0]) {
                            var reader = new FileReader();
                            reader.onload = function(e) {
                                $('#view')
                                        .attr('src', e.target.result)
                                        .width(150)
                                        .height(100);
                            }
                            reader.readAsDataURL(input.files[0]);
                        }
                    }


                    function readURLTwo(input) {
                        if (input.files && input.files[0]) {
                            var reader = new FileReader();
                            reader.onload = function(e) {
                                $('#view1')
                                        .attr('src', e.target.result)
                                        .width(150)
                                        .height(100);
                            }
                            reader.readAsDataURL(input.files[0]);
                        }
                    }

                    $("#imgInp").change(function() {
                        readURL(this);
                    });

                    $("#imgInp1").change(function() {
                        readURLTwo(this);
                    });

                });
            }

            function saveSailent(id) {
                var sailentFeat = $("#sailentFet").val();
                //alert(id);
                if (sailentFeat == "" || sailentFeat == null) {
                    return false;
                    $("#sailentFet").focus();
                }
                $.ajax({
                    url: getContextPath() + "/module/casesummary/sailentFeatSave.htm",
                    type: "POST",
                    //dataType: 'json',
                    data: {
                        id: id,
                        sailentFeat: sailentFeat
                    },
                    success: function() {
                        alert("Successfully Added Salient Feature!!!");
                    },
                    error: function() {
                        alert("Successfully Added Salient Feature!!!");
                    }
                });
            }
            ;

            function saveOtNote(id) {
                var date = $("#otDate").val();
                var time = $("#otTime").val();
                var nameOfOt = $("#nameOfOt").val();
                var procDet = $("#procedureDetail").val();
                var patientId = $("#patientId").val();
                $.ajax({
                    url: getContextPath() + "/module/casesummary/otNoteSave.htm",
                    type: "POST",
                    dataType: 'json',
                    data: {
                        id: id,
                        date: date,
                        time: time,
                        nameOfOt: nameOfOt,
                        procDet: procDet
                    },
                    success: function() {
                        alert("Successfully Added Ot Note!");
                        //window.location = "selectedPatientSingle.htm?patientId="+patientId;
                    },
                    error: function() {
                        alert("Successfully Added Ot Note!!!");
                        $("#otDate").val("");
                        $("#otTime").val("");
                        $("#nameOfOt").val("");
                        $("#procedureDetail").val("");
                        getResult(patientId);

                    }
                });
            }
            ;

            function saveSlide(id) {
                var diagnosis = $("#diagnosis").val();
                var plan = $("#plan").val();

                var patientId = $("#patientId").val();
                $.ajax({
                    url: getContextPath() + "/module/casesummary/slideSave.htm",
                    type: "POST",
                    dataType: 'json',
                    data: {
                        id: id,
                        diagnosis: diagnosis,
                        plan: plan
                    },
                    success: function() {
                        alert("Successfully Added Slide!");
                        //window.location = "selectedPatientSingle.htm?patientId="+patientId;
                    },
                    error: function() {
                        alert("Successfully Added Slide !!!");

                        //  $("#nameOfOt").val("");
                        // $("#procedureDetail").val("");
                        //  getResult(patientId);

                    }
                });
            }
            ;

            function getResult(patientId) {
                jQuery("#defaultResult").hide();
                jQuery.ajax({
                    type: "GET",
                    url: getContextPath() + "/module/casesummary/otnoteajax.htm",
                    data: ({
                        patientId: patientId
                    }),
                    success: function(data) {
                        jQuery("#viewResult").html(data);
                    },
                });
            }
            ;
        </script>
    </head>

    <body ng-app="myApp"  class="ng-cloak tdn" >
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
                                    <input type="hidden" id="id" name="id" value="${sp.id}" />
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <textarea class="form-control" rows="8" name="sailentFet" id="sailentFet" placeholder="Add Salient Feature"required >{{sf}}</textarea>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <button onclick="saveSailent('${sp.id}')"  class="btn btn-primary" >
                                                <span class="glyphicon glyphicon-save"></span>&nbsp;<span>Save</span>
                                            </button>
                                        </div>
                                    </div>
                                </form>

                            </div>

                            <div class="tab-pane" id="2"> <!-- Slide -->
                                <br>
                                <form name="myForm" id="myForm" class="form-horizontal">
                                    <div class="container">
                                        <div class="row">
                                            <div class="col-sm-5">
                                                <div class="form-group">
                                                    <div>
                                                        <label>Diagnosis :</label>
                                                        <input type="text" class="form-control" name="diagnosis"  id="diagnosis" required ng-minlength="3"/>
                                                        <div class="has-error" ng-show="myForm.$dirty">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-1"></div>
                                            <div class="col-sm-2">
                                                <input type="file" id="imgInp" style="display: none;" /><br>
                                                <button class="btn btn-info" onclick="document.getElementById('imgInp').click();" />Browse..
                                                <i class="fa fa-file-image-o" aria-hidden="true"></i>
                                                </button>
                                            </div>

                                            <div class="col-sm-2"> <br>
                                                <img id="view" src="#" alt="Selected Picture" />
                                            </div>	
                                        </div>

                                        <div class="row">
                                            <div class="col-sm-5">
                                                <div class="form-group">
                                                    <div>
                                                        <label>Plan :</label>
                                                        <textarea class="form-control" id="plan" name="plan" rows="6" placeholder="Message"></textarea>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-1"></div>
                                            <div class="col-sm-2">
                                                <input type="file" id="imgInp1" style="display: none;" /><br>
                                                <button class="btn btn-info" onclick="document.getElementById('imgInp1').click();" />Browse..
                                                <i class="fa fa-file-image-o" aria-hidden="true"></i>
                                                </button>
                                            </div>

                                            <div class="col-sm-2"> <br>
                                                <img id="view1" src="#" alt="Selected Picture" />
                                            </div>

                                        </div>

                                    </div>

                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <button onclick="saveSlide('${sp.id}')"  class="btn btn-primary" >
                                                <span class="glyphicon glyphicon-save"></span>&nbsp;<span>Save</span>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <div class="tab-pane" id="3"> <!-- ot note -->

                                <form name="otForm" id="otForm" class="form-horizontal">
                                    <br>
                                    <div class="row">
                                        <div class="col-sm-6"> <!-- first column -->
                                            <div class="form-group">
                                                <label class="control-label col-sm-3 left"  >Date :</label>
                                                <div class="col-sm-5">
                                                    <input type="text" class="form-control input-sm" name="otDate" id="otDate" required ng-minlength="3"/>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="control-label col-sm-3"  >Time :</label>
                                                <div class="col-sm-5">
                                                    <input type="text" class="form-control input-sm" name="otTime" id="otTime" required ng-minlength="3"/>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="control-label col-sm-3 left"  >Name of OT :</label>
                                                <div class="col-sm-7">
                                                    <input type="text" class="form-control input-sm" name="nameOfOt" id="nameOfOt" required ng-minlength="3"/>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- sdfffffffffffffffffffffff -->
                                        <div class="col-sm-6"> <!-- second column -->
                                            Procedure Detail
                                            <textarea class="form-control" rows="8" name="procedureDetail" id="procedureDetail" placeholder="Add Salient Feature" required > </textarea>
                                        </div>
                                    </div>
                                    <input type="hidden" id="patientId" value="${sp.patientId.personId}" />
                                    <div class="form-group">
                                        <div class="col-sm-10">
                                            <button onclick="saveOtNote('${sp.id}')"  class="btn btn-primary" >
                                                <span class="glyphicon glyphicon-plus"></span>&nbsp;<span>Add</span>
                                            </button>
                                        </div>
                                    </div>
                                </form>

                                <div class="panel-body" id="defaultResult"> 
                                    <c:if test="${ not empty listOtNote}">
                                        OT List :
                                        <table class="table table-bordered" style="font-size:12px;">
                                            <tr>
                                                <td colspan="1">#</td>
                                                <td colspan="1">Date</td>
                                                <td colspan="2">Time<td>
                                                <td colspan="2">Name of OT<td>
                                            </tr>
                                            <tbody>
                                                <c:forEach items="${listOtNote}" var="ot" varStatus="index" >
                                                    <tr>
                                                        <td>${index.count}</td>
                                                        <td><fmt:formatDate value="${ot.date}" pattern="MM/dd/yyyy"/></td>
                                                        <td colspan="2">${ot.time}</td>
                                                        <td colspan="2">${ot.nameOfOt}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table> 
                                    </c:if> 
                                </div>
                                <div id="viewResult" style="padding:4px;"></div> 
                            </div> <!-- tab content -->
                        </div> <!-- main tab div -->

                    </div>
                </div>

            </div>  

    </body>

</html>