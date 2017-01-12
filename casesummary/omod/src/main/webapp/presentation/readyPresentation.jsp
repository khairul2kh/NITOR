<%-- 
    Document   : selectPatient
    Created on : Dec 26, 2016, 3:29:18 PM
    Author     : Khairul
--%>
<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/headerMinimal.jsp"%>
<%@ include file="../includes/js_css.jsp"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript"
src="${pageContext.request.contextPath}/moduleResources/casesummary/lightimage/lightbox-plus-jquery.min.js"></script>

<link type="text/css" rel="stylesheet"	
      href="${pageContext.request.contextPath}/moduleResources/casesummary/lightimage/lightbox.min.css"/>

<html>
    <head>  
        <title>Doctor Profile Entry Form</title>  
        <style>
            .form-horizontal .control-label{
                font-size:16px;
                font-weight:normal;
                text-align:left;
            }
            .form-control{color:black;}
            .fs-16 {font-size:16px;}
            .fs-18 {font-size:18px;}
            .fs-20 {font-size:20px;}
            .fs-22 {font-size:22px;}
            .trc {
                line-height: 35px;
                min-height: 25px;
                height: 25px;
            }
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
                    $("#prev").hide();
                    divs.hide().first().show();
                    $("button[name=next]").click(function(e) {
                        $("#prev").show();
                        divs.eq(now).hide();
                        now = (now + 1 < divs.length) ? now + 1 : 0;
                        divs.eq(now).show(); // show next
                        if (divs.length == now + 1) {
                            console.log(divs.length, now + 1);
                            $("#next").hide();
                        }
                    });

                    $("button[name=prev]").click(function(e) {
                        $("#next").show();
                        divs.eq(now).hide();
                        now = (now > 0) ? now - 1 : divs.length - 1;
                        divs.eq(now).show();
                        if (now == 0) {
                            console.log(divs.length, now);
                            $("#prev").hide();
                        }
                    });

                });
            }

            function mainPage() {
                // alert(patientId);
                window.location.href = openmrsContextPath + "/module/casesummary/main.form";
            }
            ;

        </script> 

    </head>

    <body ng-app="myApp"  class="ng-cloak tdn">
        <!-- <nav class="navbar navbar-default navbar-fixed-top"> -->
        <!--
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
    </nav>  -->
        <br><br>
        <!-- Main Body Start Here -->
        <div class="container theme-showcase" role="main" ng-controller="UserController">

            <div class="panel panel-info">
                <div class="panel-body"> 

                    <div class="mydivs">

                        <div>
                            <div class="row"   id="div1">
                                <div class="col-sm-12"> <!-- first slide Doctor Info-->
                                    <div class="row">								
                                        <center> 
                                            <span style="font-size:30px; text-align:center; color:green;"> Case Presentation of <br> ${sp.unit}</span> 
                                        </center>
                                        <hr>
                                        <div class="col-sm-2 col-md-2">  </div>
                                        <div class="col-sm-8 col-md-8">	

                                            <table class="table fs-18"  >
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

                                        </div>
                                        <div class="col-sm-2 col-md-2"></div>
                                    </div>
                                </div>   
                            </div>
                        </div>

                        <div>
                            <div class="row"   id="div2">
                                <div class="col-sm-12"> <!-- second slide Patient Info -->
                                    <div class="row">
                                        <center> 
                                            <span style="font-size:30px; text-align:center; color:green; padding-bottom:10px;"> Particulars of The Patient 
                                                <br> ${sp.unit}</span>	
                                        </center>
                                        <hr>
                                        <div class="col-sm-1 col-md-1">  </div>
                                        <div class="col-sm-6 col-md-6">

                                            <table class="fs-16 trc">
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
                                            </table>
                                        </div>
                                        <c:if test="${not empty sp.imageName }">
                                            <div class="col-sm-4 col-md-4">
                                                <a class="example-image-link" href="${pageContext.request.contextPath}/imageFolder/${sp.imageName}"
                                                   data-lightbox="example-1">
                                                    <img class="example-image" src="${pageContext.request.contextPath}/imageFolder/${sp.imageName}" 
                                                         alt="image-1" width="50%;"  height="auto;" /></a>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>   
                            </div>
                        </div>

                        <c:if test="${not empty sf.sailentFeature }">
                            <div> <!-- sailent feat -->
                                <div class="row">
                                    <br>
                                    <center>
                                        <span style="font-size:30px; text-align:center; color:green;"> Salient Feature </span>
                                    </center>
                                    <hr>
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

                        <c:forEach items="${listSlide}" var="ls" >
                            <div> <!-- slide with image -->
                                <div class="row">
                                    <div class="col-sm-6 col-md-6 fs-18">
                                        <div class="thumbnail">
                                            <div class="form-group">
                                                <b> Diagnosis : </b> ${ls.diagnosis}
                                            </div>                                                
                                        </div>
                                    </div>
                                    <div class="col-sm-6 col-md-6 fs-18">
                                        <div class="thumbnail">
                                            <div class="form-group">
                                                <div>
                                                    <b>Plan : </b>  <br> ${ls.plan}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-6 col-md-6">
                                        <a class="example-image-link" href="${pageContext.request.contextPath}/imageFolder/${ls.imgNameOne}"
                                           data-lightbox="example-set" >
                                            <img class="example-image1" src="${pageContext.request.contextPath}/imageFolder/${ls.imgNameOne}" 
                                                 alt="image-1" width="50%;"  height="auto;" /></a>
                                    </div>
                                    <div class="col-sm-6 col-md-6">
                                        <a class="example-image-link" href="${pageContext.request.contextPath}/imageFolder/${ls.imgNameTwo}"
                                           data-lightbox="example-set" >
                                            <img class="example-image1" src="${pageContext.request.contextPath}/imageFolder/${ls.imgNameTwo}" 
                                                 alt="image-1" width="50%;"  height="auto;" /></a>
                                    </div>
                                </div>

                            </div>
                        </c:forEach>

                        <c:if test="${not empty listOtNote }">
                            <div>
                                <div class="row"> <!-- OT Note -->
                                    <center>
                                        <span style="font-size:30px; text-align:center; color:green;"> OT Note </span>
                                    </center>
                                    <hr>
                                    <div class="col-sm-12 col-md-12">
                                        <table class="table table-bordered fs-18">
                                            <thead>
                                            <th> OT Date </th>
                                            <th> OT Time </th>
                                            <th> Name Of OT </th>
                                            <th> Procedure Detail </th>
                                            <th> Name of Surgeon </th>
                                            <th> Type of Anesthe. </th>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${listOtNote}" var="ot"  >
                                                    <tr> 
                                                        <td> <fmt:formatDate value="${ot.date}" pattern="MM/dd/yyyy"/> </td>
                                                        <td> ${ot.time} </td>                                        
                                                        <td> ${ot.nameOfOt} </td>
                                                        <td> ${ot.procedureDetail} </td>
                                                        <td> ${ot.nameOfSurgeon} </td>
                                                        <td> ${ot.typeAnesthesia} </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <c:forEach items="${listFollUp}" var="lf" >
                            <div> <!-- slide with image -->
                                <div class="row">
                                    <center>
                                        <span style="font-size:30px; text-align:center; color:green;"> Follow Up </span>
                                    </center>
                                    <hr>
                                    <div class="col-sm-6 col-md-6 fs-18">
                                        <div class="form-group">
                                            <b>Diagnosis :</b> ${lf.diagnosis}
                                        </div> 
                                        <div class="form-group">
                                            <b>Date of Surgery :</b> <fmt:formatDate value="${lf.dateOfSurgery}" pattern="MM/dd/yyyy"/>
                                        </div>
                                        <div class="form-group">
                                            <b> Date of Follow Up : </b> <fmt:formatDate value="${lf.dateOfFollowUp}" pattern="MM/dd/yyyy"/>
                                        </div>                                     
                                    </div>

                                    <div class="col-sm-6 col-md-6 fs-18">
                                        <div class="form-group">
                                            <div class="form-group">
                                                <b> Comment :</b> ${lf.comment}
                                            </div>  
                                            <div class="form-group">
                                                <b>Subsequent Plan :</b> ${lf.subsequentPlan}
                                            </div>   
                                        </div>
                                    </div>

                                </div> <!-- first row -->
                                <hr>
                                <div class="row">
                                    <c:if test="${not empty lf.imgNameOne}">
                                        <div class="col-sm-6 col-md-6">
                                            <a class="example-image-link" href="${pageContext.request.contextPath}/imageFolder/${lf.imgNameOne}"
                                               data-lightbox="example-1">
                                                <img class="example-image" src="${pageContext.request.contextPath}/imageFolder/${lf.imgNameOne}" 
                                                     alt="image-1" width="50%;"  height="auto;" /></a>
                                        </div>
                                    </c:if>

                                    <c:if test="${not empty lf.imgNameTwo}">
                                        <div class="col-sm-6 col-md-6">                                      
                                            <a class="example-image-link" href="${pageContext.request.contextPath}/imageFolder/${lf.imgNameTwo}"
                                               data-lightbox="example-1">
                                                <img class="example-image" src="${pageContext.request.contextPath}/imageFolder/${lf.imgNameTwo}" 
                                                     alt="image-1" width="50%;"  height="auto;" /></a>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>

                        <div>
                            <div class="row">
                                <div class="col-sm-4 col-md-4"> </div>
                                <div class="col-sm-2 col-md-2"> <span style="font-size:20px;"> Thanks </span> </div>
                                <div class="col-sm-4 col-md-4"> </div>
                            </div>
                        </div>
                    </div>	 
                </div>
            </div> 

            <div class="row col-sm-4 col-md-4">
                <button class="btn btn-success" id="prev" name="prev"> <i class="fa fa-backward" aria-hidden="true"></i> Previous</button>
                <button name="next" id="next" class="btn btn-success">Next <i class="fa fa-forward" aria-hidden="true"></i> </button>
            </div>
            <div class="row col-sm-2 col-md-2">
                <button class="btn btn-info" onclick="mainPage()"> <i class="fa fa-th" aria-hidden="true"></i>  Presentation List </button>
            </div>
        </div>  
    </body>

</html>