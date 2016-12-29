<%-- 
    Document   : selectedPatient
    Created on : Dec 29, 2016, 10:09:32 AM
    Author     : Khairul
--%>

<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/headerMinimal.jsp"%>
<%@ include file="../includes/js_css.jsp"%> 

<html>
    <head>  

        <title>Selected Patient List</title>  

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
                        window.location = "main.form";
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
                <div class="panel-heading">Selected Patient List</div>
                <div class="panel-body"> 

                    <form class="form-horizontal"  >


                    </form>
                </div>
            </div>
        </div>  
    </body>
    <%@ include file="/WEB-INF/template/footer.jsp"%>
</html>