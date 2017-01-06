<%-- 
    Document   : selectPatient
    Created on : Dec 26, 2016, 3:29:18 PM
    Author     : Khairul
--%>
<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/headerMinimal.jsp"%>
<%@ include file="../includes/js_css.jsp"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
    <head>  
        <title>Doctor Profile Entry Form</title>  
        <style>
            .form-horizontal .control-label{
                font-size:14px;
                font-weight:normal;
                text-align:left;
            }
            .form-control{color:black;}


        </style>

        <script>
            var myApp = angular.module("myApp", []);
            myApp.controller('UserController', ['$scope', '$http', function($scope, $http) {

                    $scope.IsVisible = false;
                    $scope.ShowHide = function() {
                        $scope.IsVisible = $scope.IsVisible ? false : true;
                    };

                    $scope.index = 1;

                    //$scope.docName=${docPro.doctorName};
                    //   $scope.docorProfile = [{doctorName: "khairul", designation: "Hasan Zamil", session: "jakir@gmail.com"}];
                }]);

            if (SESSION.checkSession()) {

                $(document).ready(function() {

                    var divs = $('.mydivs>div');
                    var now = 0; // currently shown div
                    divs.hide().first().show();
                    $("button[name=next]").click(function(e) {
                        divs.eq(now).hide();
                        now = (now + 1 < divs.length) ? now + 1 : 0;
                        divs.eq(now).show(); // show next
                    });
                    $("button[name=prev]").click(function(e) {
                        divs.eq(now).hide();
                        now = (now > 0) ? now - 1 : divs.length - 1;
                        divs.eq(now).show();
                        //console.log(divs.length, now);
                    });
                });
            }

            function mainPage() {
                // alert(patientId);
                window.location.href = openmrsContextPath + "/module/casesummary/main.form";
            }
            ;

        </script> 


    </script>
</head>

<body ng-app="myApp"  class="ng-cloak tdn">
    <!-- <nav class="navbar navbar-default navbar-fixed-top"> -->
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">     
        <div class="container">
            <div class="navbar-header" style="padding-top:12px;">
                <span> Welcome : ${u.person.givenName} ${u.person.middleName} ${u.person.familyName} </span>
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

        <div class="panel panel-info">
            <div class="panel-body"> 

                <div class="mydivs">

                    <div>
                        <div class="row"   id="div1">
                            <div class="col-sm-12"> <!-- first column -->
                                <div class="row">  1
                                    <div class="col-sm-2 col-md-2">  </div>
                                    <div class="col-sm-8 col-md-8">									 
                                        <span style="font-size:18px; text-align:center; color:green;"> Case Presentation Of <br> ${sp.unit}</span> <hr>	
                                        <table class="table">
                                            <tr> 
                                                <td> Doctor Name  </td> <td width="5%;"> : </td>  <td> ${dp.doctorName} </td>
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
                                        </table>
                                        <hr>
                                        <span style="font-size:18px; text-align:center;"> NITOR</span> 

                                    </div>
                                    <div class="col-sm-2 col-md-2"></div>
                                </div>
                            </div>   
                        </div>
                    </div>

                    <div>
                        <div class="row"   id="div2">
                            <div class="col-sm-12"> <!-- first column -->
                                <div class="row">2
                                    <div class="col-sm-2 col-md-2">  </div>
                                    <div class="col-sm-8 col-md-8">
                                        <span style="font-size:18px; text-align:center; color:green;"> Particulars 0f The Patient</span> <hr>	

                                        <table class="table">
                                            <tr> 
                                                <td> Patient Name </td> <td width="5%;"> : </td>  <td>${sp.patientId.givenName} ${sp.patientId.middleName} ${sp.patientId.familyName}</td>
                                            </tr>									
                                            <tr> 
                                                <td> Age  </td> <td width="5%;"> : </td>  <td> ${age} </td>
                                            </tr>
                                            <tr> 
                                                <td> Sex  </td> <td width="5%;"> :</td>  <td> ${sex} </td>
                                            </tr>
                                            <tr> 
                                                <td> Address </td> <td width="5%;">: </td>   <td> ${sp.address} </td>
                                            </tr>
                                            <tr> 
                                                <td> Registration No </td> <td width="5%;">: </td>   <td> ${sp.patientId.patientIdentifier.identifier} </td>
                                            </tr>
                                            <tr> 
                                                <td> Admitted Ward </td> <td width="5%;">: </td>   <td> ${sp.admittedWard} </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="col-sm-2 col-md-2"></div>
                                </div>
                            </div>   
                        </div>
                    </div>

                    <div> <!-- sailent feat -->
                        <div class="row">
                            <div class="col-sm-12 col-md-12"> 
                                <span style="font-size:18px; text-align:center; color:green;"> Salient Feature </span> <hr>
                            </div>
                            <div class="col-sm-12">
                                <div class="thumbnail">
                                    <div>
                                        ${sf.sailentFeature}
                                    </div>                                                
                                    <div class="form-group">
                                        <div>
                                            Date   
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <c:forEach items="${listSlide}" var="ls" >
                        <div>
                            <div class="row">
                                <div class="col-sm-5 col-md-5">
                                    <div class="thumbnail">
                                        <div>
                                            Diagnosis : ${ls.diagnosis}
                                        </div>                                                
                                        <div class="form-group">
                                            <div>
                                                Plan ${ls.plan}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-7 col-md-7">
                                    <div class="thumbnail">
                                        <img src="${pageContext.request.contextPath}/imageFolder/${ls.imgNameOne}" alt="first" />
                                        <br>
                                        <img src="${pageContext.request.contextPath}/imageFolder/${ls.imgNameTwo}" alt="first" />                         
                                    </div>                                         
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <div>
                        <div class="row">
                            <div class="col-sm-12 col-md-10">
                                <span style="font-size:18px; text-align:center; color:green;"> OT Note </span> <hr>
                                <table class="table">
                                    <c:forEach items="${listOtNote}" var="ot">
                                        <tr> 
                                            <td> OT Date </td> <td width="5%;"> : </td>  <td> <fmt:formatDate value="${ot.date}" pattern="MM/dd/yyyy"/> </td>
                                        </tr>									
                                        <tr> 
                                            <td> OT Time  </td> <td width="5%;"> : </td>  <td> ${ot.time} </td>
                                        </tr>
                                        <tr> 
                                            <td> Name Of OT  </td> <td width="5%;"> : </td>  <td> ${ot.nameOfOt} </td>
                                        </tr>
                                        <tr> 
                                            <td> Procedure Detail </td> <td width="5%;"> : </td>  <td> ${ot.procedureDetail} </td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div>
                        <div class="row">
                            <div class="col-sm-4 col-md-4"> </div>
                            <div class="col-sm-2 col-md-2"> <span style="font-size:20px;"> The End </span> </div>
                            <div class="col-sm-4 col-md-4"> </div>
                        </div>
                        <br><br><br><br>

                        <div class="row">
                            <div class="col-sm-4 col-md-4"> </div>
                            <div class="col-sm-2 col-md-2"> <button class="btn btn-info" onclick="mainPage()"> Home <i class="glyphicon glyphicon-home"></i> </button> </div>
                            <div class="col-sm-4 col-md-4"> </div>
                        </div>
                    </div>

                </div>	 
            </div>
        </div> 

        <div class="row col-sm-2 col-md-2">
            <button class="btn btn-success" name="prev">Previous</button>
        </div>
        <div class="row col-sm-8 col-md-8"></div>
        <div class="row col-sm-2 col-md-2">
            <button name="next" class="btn btn-success">Next </button>
        </div>

    </div>  
</body>

</html>