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
            #follUpImg1, #follUpImg2  { display: none; }
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
                    jQuery('#otDate').datepicker({yearRange: 'c-30:c+30', dateFormat: 'dd/mm/yy', changeMonth: true, changeYear: true});
                    jQuery('#dateSurgery').datepicker({yearRange: 'c-30:c+30', dateFormat: 'dd/mm/yy', changeMonth: true, changeYear: true});
                    jQuery('#dateFollup').datepicker({yearRange: 'c-30:c+30', dateFormat: 'dd/mm/yy', changeMonth: true, changeYear: true});

                    $(".slide").click(function() { // Click to only happen on announce links
                        $("#slideId").val($(this).data('id'));
                        forEdit($(this).data('id'));
                        $('#slideForm').modal({backdrop: 'static', keyboard: false});
                        $('#slideForm').modal('show');
                    });


                    $(".followup").click(function() { // Click to only happen on announce links
                        $("#followId").val($(this).data('id'));
                        forEditFollow($(this).data('id'));
                        $('#followupForm').modal({backdrop: 'static', keyboard: false});
                        $('#followupForm').modal('show');
                    });

                    /// Slide 
                    function readURL(input) {
                        if (input.files && input.files[0]) {
                            var reader = new FileReader();
                            reader.onload = function(e) {
                                $('#view')
                                        .attr('src', e.target.result)
                                        .width(100)
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
                                        .width(100)
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

                    ////// End slide

                    /////// Follow up
                    function follImage1(input) {
                        if (input.files && input.files[0]) {
                            var reader = new FileReader();
                            reader.onload = function(e) {
                                $('#follView')
                                        .attr('src', e.target.result)
                                        .width(120)
                                        .height(120);
                            }
                            reader.readAsDataURL(input.files[0]);
                        }
                    }

                    function follImage2(input) {
                        if (input.files && input.files[0]) {
                            var reader = new FileReader();
                            reader.onload = function(e) {
                                $('#follView1')
                                        .attr('src', e.target.result)
                                        .width(120)
                                        .height(120);
                            }
                            reader.readAsDataURL(input.files[0]);
                        }
                    }

                    $("#follUpImg1").change(function() {
                        follImage1(this);
                    });

                    $("#follUpImg2").change(function() {
                        follImage2(this);
                    });

                    //// End Follow up

                    $('#follImgBtn1').click(function() {
                        $('#follUpImg1').click();
                    });

                    $('#follImgBtn2').click(function() {
                        $('#follUpImg2').click();
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
                var nameOfSur = $("#nameOfSur").val();
                var typeAnest = $("#typeAnest").val();
                $.ajax({
                    url: getContextPath() + "/module/casesummary/otNoteSave.htm",
                    type: "POST",
                    dataType: 'json',
                    data: {
                        id: id,
                        date: date,
                        time: time,
                        nameOfOt: nameOfOt,
                        nameOfSur: nameOfSur,
                        typeAnest: typeAnest,
                        procDet: procDet
                    },
                    success: function() {
                        alert("Successfully Added Ot Note!");
                        getResult(patientId);
                        //window.location = "selectedPatientSingle.htm?patientId="+patientId;
                    },
                    error: function() {
                        alert("Successfully Added Ot Note!!!");
                        $("#otDate").val("");
                        $("#otTime").val("");
                        $("#nameOfOt").val("");
                        $("#procedureDetail").val("");
                        $("#nameOfSur").val("");
                        $("#typeAnest").val("");
                        getResult(patientId);
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
                    error: function(data) {
                        jQuery("#viewResult").html(data);
                    }
                });
            }
            ;

            function saveSlide(id) {
                var diagnosis = $("#diagnosis").val();
                var plan = $("#plan").val();

                if (diagnosis == "" || diagnosis == null) {
                    alert("Diagnosis empty not allowed!!!");
                    $("#diagnosis").focus();
                    return false;
                }

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
                        alert("Successfully Added Slide !!!");
                        savePictures();
                    },
                    error: function() {
                        alert("Successfully Added Slide !!!");
                        $("#diagnosis").val("");
                        $("#plan").val("");
                        savePictures();
                        //  $("#picForm").submit();
                    }
                });
            }
            ;

            function savePictures() {
                $.ajax({
                    url: 'pictureSave.htm',
                    type: "POST",
                    data: new FormData(document.getElementById("picForm")),
                    enctype: 'multipart/form-data',
                    processData: false,
                    contentType: false
                }).done(function(data) {
                    location.reload();
                    jQuery('#imgInp').val("");
                    jQuery('#imgInp1').val("");
                }).fail(function(jqXHR, textStatus) {
                    //alert(jqXHR.responseText);
                    //  alert('File upload failed ...');
                    location.reload();
                    jQuery('#imgInp').val("");
                    jQuery('#imgInp1').val("");
                });
            }

            function saveFollowUp(id) {
                var diagnosisFoll = $("#diagnosisFoll").val();
                var dateSurgery = $("#dateSurgery").val();
                var dateFollup = $("#dateFollup").val();
                var comment = $("#comment").val();
                var subPlan = $("#subPlan").val();

                if (diagnosisFoll == "" || diagnosisFoll == null) {
                    alert("Diagnosis empty not allowed!!!");
                    $("#diagnosisFoll").focus();
                    return false;
                }
                $.ajax({
                    url: getContextPath() + "/module/casesummary/followUpSave.htm",
                    type: "POST",
                    dataType: 'json',
                    data: {
                        id: id,
                        diagnosisFoll: diagnosisFoll,
                        dateSurgery: dateSurgery,
                        dateFollup: dateFollup,
                        comment: comment,
                        subPlan: subPlan
                    },
                    success: function() {
                        alert("Successfully Added Slide !!!");
                    },
                    error: function() {
                        alert("Successfully Added Slide !!!");
                        $("#diagnosisFoll").val("");
                        $("#dateSurgery").val("");
                        $("#dateFollup").val("");
                        $("#comment").val("");
                        $("#subPlan").val("");
                        savePicturesFollUp();
                    }
                });
            }
            ;

            function savePicturesFollUp() {
                $.ajax({
                    url: 'pictureSaveFollUP.htm',
                    type: "POST",
                    data: new FormData(document.getElementById("picFormFollUp")),
                    enctype: 'multipart/form-data',
                    processData: false,
                    contentType: false
                }).done(function(data) {
                    location.reload();
                    jQuery('#follUpImg1').val("");
                    jQuery('#follUpImg2').val("");
                }).fail(function(jqXHR, textStatus) {
                    //alert(jqXHR.responseText);
                    //  alert('File upload failed ...');
                    location.reload();
                    jQuery('#follUpImg1').val("");
                    jQuery('#follUpImg2').val("");
                });
            }

            function forEdit(sId) {
                jQuery.ajax({
                    type: "GET",
                    url: getContextPath() + "/module/casesummary/getSlideEdit.htm",
                    data: ({
                        sId: sId
                    }),
                    success: function(data) {
                        jQuery("#slideEditDiv").html(data);
                    },
                    error: function(data) {
                    }
                });
            }
            ;

            function forEditFollow(fId) {
                jQuery.ajax({
                    type: "GET",
                    url: getContextPath() + "/module/casesummary/getFollowupEdit.htm",
                    data: ({
                        fId: fId
                    }),
                    success: function(data) {
                        jQuery("#followupEditDiv").html(data);
                    },
                    error: function(data) {
                    }
                });
            }
            ;

            function updateSlide(sId) {

                var upDiagnosis = document.getElementById("editFormSlide").elements[1].value;
                var upPlan = document.getElementById("editFormSlide").elements[2].value;

                if (upDiagnosis == "" || upDiagnosis == null) {
                    alert("Diagnosis empty not allowed!!!");
                    $("#upDiagnosis").focus();
                    return false;
                }

                $.ajax({
                    url: getContextPath() + "/module/casesummary/getSlideUpdate.htm",
                    type: "POST",
                    dataType: 'json',
                    data: {
                        sId: sId,
                        upDiagnosis: upDiagnosis,
                        upPlan: upPlan
                    },
                    success: function() {
                        alert("Successfully Update Slide !!!");
                        location.reload();
                    },
                    error: function() {
                        alert("Successfully Update Slide !!!");

                        location.reload();
                        //  $("#diagnosis").val("");
                        //$("#plan").val("");
                        updatePictures();

                    }
                });
            }
            ;

            function updatePictures() {
                $.ajax({
                    url: 'pictureUpdate.htm',
                    type: "POST",
                    data: new FormData(document.getElementById("picFormUpdate")),
                    enctype: 'multipart/form-data',
                    processData: false,
                    contentType: false
                }).done(function(data) {
                    location.reload();
                    jQuery('#imgInpEdit1').val("");
                    jQuery('#imgInpEdit2').val("");
                }).fail(function(jqXHR, textStatus) {
                    //alert(jqXHR.responseText);
                    //  alert('File upload failed ...');
                    location.reload();
                    jQuery('#imgInpEdit1').val("");
                    jQuery('#imgInpEdit2').val("");
                });
            }

            function updateFollowup(fId) {
                var diagnosisFoll = document.getElementById("followupFormUpdate").elements[1].value;
                var dateSurgery = document.getElementById("followupFormUpdate").elements[2].value;
                var dateFollow = document.getElementById("followupFormUpdate").elements[3].value;
                var comment = document.getElementById("followupFormUpdate").elements[4].value;
                var subsequentPlan = document.getElementById("followupFormUpdate").elements[5].value;

                if (diagnosisFoll == "" || diagnosisFoll == null) {
                    alert("Diagnosis empty not allowed!!!");
                    $("#diagnosisFoll").focus();
                    return false;
                }
                $.ajax({
                    url: getContextPath() + "/module/casesummary/followupUpdate.htm",
                    cache: false,
                    type: "POST",
                    dataType: 'json',
                    data: {
                        fId: fId,
                        diagnosisFoll: diagnosisFoll,
                        dateSurgery: dateSurgery,
                        dateFollow: dateFollow,
                        comment: comment,
                        subsequentPlan: subsequentPlan
                    },
                    success: function(data) {
                        alert("Successfully Update Slide !!!");
                        location.reload();
                        updatePicturesFollUp();
                    },
                    error: function(data) {
                        alert("Successfully Update Slide !!!");
                        location.reload();
                        //  $("#diagnosis").val("");
                        //$("#plan").val("");
                        updatePicturesFollUp();

                    }
                });
            }
            ;

            function updatePicturesFollUp() {
                $.ajax({
                    url: 'pictureUpdateFollUp.htm',
                    type: "POST",
                    data: new FormData(document.getElementById("picFormUpdateFollUp")),
                    enctype: 'multipart/form-data',
                    processData: false,
                    contentType: false
                }).done(function(data) {
                    location.reload();
                    jQuery('#imgInpEdit1').val("");
                    jQuery('#imgInpEdit2').val("");
                }).fail(function(jqXHR, textStatus) {
                    //alert(jqXHR.responseText);
                    //  alert('File upload failed ...');
                    location.reload();
                    jQuery('#imgInpEdit1').val("");
                    jQuery('#imgInpEdit2').val("");
                });
            }

            function modalClick() { // Click to only happen on announce links
                $('#printSelect').modal({backdrop: 'static', keyboard: false});
                $('#printSelect').modal('show');

                $('#printSelect').css({
                    width: '50%', //probably not needed
                    height: 'auto', //probably not needed 
                    top: '5%',
                    left: '25%'
                });
            }
            ;

            function check(id) {
                var presnterInfo = "null";
                var patientInof = "null";
                var slideInfo = "null";
                var otnoteInfo = "null";
                var follInfo = "null";

                if ($('#preInfo').is(":checked"))
                {
                    presnterInfo = "checked";
                    console.log(presnterInfo);
                }
                else if ($('#preInfo').attr('checked', false))
                {
                    presnterInfo = presnterInfo;
                    console.log(presnterInfo);
                }
                ////////////////
                if ($('#patInfo').is(":checked"))
                {
                    patientInof = "checked";
                    console.log(patientInof);
                }
                else if ($('#patInfo').attr('checked', false))
                {
                    patientInof = patientInof;
                    console.log(patientInof);
                }
                ////////////////
                if ($('#sliInfo').is(":checked"))
                {
                    slideInfo = "checked";
                    console.log(slideInfo);
                }
                else if ($('#sliInfo').attr('checked', false))
                {
                    slideInfo = slideInfo;
                    console.log(slideInfo);
                }
                ////////////////////////
                if ($('#otInfo').is(":checked"))
                {
                    otnoteInfo = "checked";
                    console.log(otnoteInfo);
                }
                else if ($('#otInfo').attr('checked', false))
                {
                    otnoteInfo = otnoteInfo;
                    console.log(otnoteInfo);
                }
                ////////////////////////
                if ($('#folInfo').is(":checked"))
                {
                    follInfo = "checked";
                    console.log(follInfo);
                }
                else if ($('#folInfo').attr('checked', false))
                {
                    follInfo = follInfo;
                    console.log(follInfo);
                }

                //var strWindowFeatures = "location=yes,height=570,width=820,scrollbars=yes,status=yes";
                var strWindowFeatures = "location=yes,scrollbars=yes,status=yes,fullscreen=yes";
                var URL = "presentationPrint.htm?id=" + id + "&preIn=" + presnterInfo + "&patIn=" + patientInof + "&sliIn=" + slideInfo + "&otIn=" + otnoteInfo + "&folIn=" + follInfo;
                var win = window.open(URL, "_blank", strWindowFeatures);
            }


            function viewPresentation(id) {
                var strWindowFeatures = "location=yes,scrollbars=yes,status=yes,fullscreen=yes";
                var URL = "selectPatientSlide.htm?id=" + id + "&view=" + 1;
                var win = window.open(URL, '', strWindowFeatures);

                //window.open(url, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no');
            }
        </script>
    </head>

    <body ng-app="myApp"  class="ng-cloak tdn" >
        <%@ include file="../includes/header.jsp"%> 
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
                            <li><a href="#4" data-toggle="tab">Follow Up</a>
                            </li>
                            <div style="float:right"> 

                                <a target="_blank" class="btn btn-success" onclick="viewPresentation(${sp.id})" >
                                    <i class="fa fa-eye white" aria-hidden="true"></i>
                                    <span class="white"> View Presentation </span> </a>

                                <a target="_blank" class="btn btn-warning" onclick="check(${sp.id})" >
                                    <i class="fa fa-print white" aria-hidden="true"></i>
                                    <span class="white"> Print </span> </a> 
                                <button onclick="modalClick()" class="btn btn-warning" > <i class="fa fa-print white" aria-hidden="true"></i>
                                    Print With Condition  </button>
                            </div>
                        </ul>

                        <div class="tab-content ">
                            <div class="tab-pane active" id="1"> <!-- sailent feature -->
                                <br>
                                <form name="sailentForm" id="sailentForm" class="form-horizontal">
                                    <input type="hidden" id="id" name="id" value="${sp.id}" />
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <textarea class="form-control" rows="8" name="sailentFet" id="sailentFet" placeholder="Add Salient Feature" required >
                                                ${sf.sailentFeature}
                                            </textarea>
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
                                <div class="row">
                                    <div class="col-sm-6 col-md-6">
                                        <div class="thumbnail">
                                            <form name="myForm" id="myForm"  >
                                                <div class="form-group">
                                                    <div>
                                                        <label>Diagnosis :</label>
                                                        <input type="text" class="form-control" name="diagnosis"  id="diagnosis" required ng-minlength="3"/>
                                                        <div class="has-error" ng-show="myForm.$dirty">
                                                        </div>
                                                    </div>
                                                </div> 
                                                <div class="form-group">
                                                    <div>
                                                        <label>Plan :</label>
                                                        <textarea class="form-control" id="plan" name="plan" rows="6" placeholder="Message"></textarea>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>

                                    <div class="col-sm-6 col-md-6">
                                        <div class="thumbnail">
                                            <form action="pictureSave.htm" id="picForm" name="picForm" method="post" enctype="multipart/form-data">  
                                                <input type="file" id="imgInp" name="imgInp" style="display: ;" /><br>

                                                <img id="view" src="#" alt="Selected Picture" />
                                                <br><br>
                                                <input type="file" id="imgInp1" name="imgInp1" style="display:  ;" /><br>

                                                <img id="view1" src="#" alt="Selected Picture" />
                                                <br><br>
                                            </form>  
                                        </div>
                                        <button onclick="saveSlide('${sp.id}')"  class="btn btn-primary" >
                                            <span class="glyphicon glyphicon-save slide"></span>&nbsp;<span>Save</span>
                                        </button>

                                    </div>
                                </div>

                                <div class="panel-body" id="defaultResult"> 
                                    <c:if test="${ not empty listSlide}">
                                        Slide List :
                                        <table class="table table-bordered" style="font-size:12px;">
                                            <tr>
                                                <th >#</th>
                                                <th>Diagnosis</th>
                                                <th >Plan</th>
                                                <td >Picture one</th>
                                                <th>Picture two</th>
                                                <th >Action</th>
                                            </tr>
                                            <tbody>
                                                <c:forEach items="${listSlide}" var="slide" varStatus="index" >
                                                    <tr>
                                                        <td style="display:none;">${slide.id} </td>
                                                        <td width="10%">${index.count}</td>
                                                        <td width="30%"> ${slide.diagnosis}</td>
                                                        <td width="30%"> ${slide.plan}</td>
                                                        <td width="20%"> 
                                                            <c:if test="${not empty slide.imgNameOne}">
                                                                <img class="example-image1" src="${pageContext.request.contextPath}/imageFolder/${slide.imgNameOne}" 
                                                                     alt="image-1" width="50px;" height="50px;" />  
                                                            </c:if>
                                                        </td>
                                                        <td width="20%"> 
                                                            <c:if test="${not empty slide.imgNameTwo}">
                                                                <img class="example-image1" src="${pageContext.request.contextPath}/imageFolder/${slide.imgNameTwo}" 
                                                                     alt="image-1" width="50px;" height="50px;" /> 
                                                            </c:if>
                                                        </td>
                                                        <td> 
                                                            <c:if test="${slide.creator eq u.userId}">
                                                                <button class="btn btn-success btn-sm slide" data-toggle="modal" data-backdrop="static" data-keyboard="false"
                                                                        data-id="${slide.id}" >Edit <i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
                                                                </c:if>
                                                                <c:if test="${slide.creator ne u.userId}">
                                                                <button class="btn btn-success btn-sm slide" data-toggle="modal" data-backdrop="static" data-keyboard="false"
                                                                        data-id="${slide.id}" disabled >Edit <i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
                                                                </c:if>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table> 
                                    </c:if> 
                                </div>

                                <!-- Edit Slide modal -->
                                <div class="modal fade" id="slideForm" role="dialog" >
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                <h2 class="modal-title">Edit Slide</h2>
                                            </div>
                                            <div class="modal-body">
                                                <form name="myForm" id="myForm" class="form-horizontal">
                                                    <input type="hidden" value="" id="slideId" />
                                                    <div class="form-group" id="slideEditDiv"> </div>

                                                    <div class="modal-footer">
                                                        <div class="col-sm-8 left ">
                                                            <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="vm.clear()">
                                                                <span class="glyphicon glyphicon-ban-circle"></span>&nbsp;<span>Close</span>
                                                            </button>
                                                            <input type="hidden" value="${s.id}" id="sId" name="sId" />
                                                        </div>
                                                    </div> 
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>  <!--End modal edit slide -->
                            </div>  <!--End slide -->


                            <div class="tab-pane" id="3" style="background-color:;"> <!-- ot note -->
                                <form name="otForm" id="otForm" class="form-horizontal">
                                    <input type="hidden" id="patientId" value="${sp.patientId.personId}" />
                                    <br>
                                    <div class="row">
                                        <div class="col-sm-6"> <!-- first column -->
                                            <div class="form-group">
                                                <label class="control-label col-sm-4 left"  >Date :</label>
                                                <div class="col-sm-5">
                                                    <input type="text" class="form-control input-sm" name="otDate" id="otDate" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-sm-4"  >Time :</label>
                                                <div class="col-sm-5">
                                                    <input type="text" class="form-control input-sm" name="otTime" id="otTime" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-sm-4 left"  >Name of OT :</label>
                                                <div class="col-sm-7">
                                                    <input type="text" class="form-control input-sm" name="nameOfOt" id="nameOfOt" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-sm-4 left"  >Name of Surgeon :</label>
                                                <div class="col-sm-7">
                                                    <input type="text" class="form-control input-sm" name="nameOfSur" id="nameOfSur"  />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-sm-4 left"  >Type of Anesthe. :</label>
                                                <div class="col-sm-7">
                                                    <input type="text" class="form-control input-sm" name="typeAnest" id="typeAnest"  />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6"> <!-- second column -->
                                            Procedure Detail
                                            <textarea class="form-control" rows="8" name="procedureDetail" id="procedureDetail" placeholder="Add Salient Feature" required > </textarea>
                                        </div>
                                    </div>
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
                                                <td >#</td>
                                                <td >Date</td>
                                                <td >Time</td>
                                                <td >Name of OT</td>
                                                <td >Name of Surgeon</td>
                                                <td >Type of Anesthe.</td>
                                            </tr>
                                            <tbody>
                                                <c:forEach items="${listOtNote}" var="ot" varStatus="index" >
                                                    <tr>
                                                        <td>${index.count}</td>
                                                        <td><fmt:formatDate value="${ot.date}" pattern="MM/dd/yyyy"/></td>
                                                        <td >${ot.time}</td>
                                                        <td >${ot.nameOfOt}</td>
                                                        <td >${ot.nameOfSurgeon}</td>
                                                        <td >${ot.typeAnesthesia}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table> 
                                    </c:if> 
                                </div>
                                <div id="viewResult" style="padding:4px;"></div> 
                            </div> <!-- tab ot note End -->

                            <div class="tab-pane" id="4"> <!-- Follow up -->
                                <br>
                                <div class="row">
                                    <div class="col-sm-6 col-md-6">

                                        <form name="myForm" id="myForm" class="form-horizontal" >
                                            <div class="form-group">
                                                <label class="control-label col-sm-4 left"  >Diagnosis :</label>
                                                <div class="col-md-6">
                                                    <input type="text" class="form-control input-sm" name="diagnosisFoll" id="diagnosisFoll"  />												 
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label col-sm-4 left"  >Date of Surgery :</label>
                                                <div class="col-md-6">
                                                    <input type="text" class="form-control input-sm" name="dateSurgery" id="dateSurgery"  />												 
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="control-label col-sm-4 left"  >Date of Follow Up :</label>
                                                <div class="col-md-6">
                                                    <input type="text" class="form-control input-sm" name="dateFollup" id="dateFollup"  />												 
                                                </div>
                                            </div>
                                            <div>
                                                Comment :
                                                <textarea class="form-control" id="comment" name="comment" rows="2" placeholder="Comment"></textarea>
                                            </div>
                                            <br>
                                            <div>
                                                Subsequent Plan :
                                                <textarea class="form-control" id="subPlan" name="subPlan" rows="2" placeholder="Subsequent Plan"></textarea>
                                            </div>
                                        </form>
                                    </div>

                                    <div class="col-sm-6 col-md-6">
                                        <div class="thumbnail">
                                            <form action="pictureSaveFollUP.htm" class="form-horizontal" id="picFormFollUp" name="picFormFollUp" method="post" enctype="multipart/form-data">  
                                                <div class="form-group">  <!-- Image one -->
                                                    <label class="control-label col-sm-4 left"  >  
                                                        <input type="button" class="btn btn-success" value="Browse.."  id="follImgBtn1" /> 
                                                        <input type="file" id="follUpImg1" name="follUpImg1"   /> 
                                                    </label>
                                                    <div class="col-md-6">
                                                        <img id="follView" src="#" alt="Picture Not Selecte" />											 
                                                    </div>
                                                </div>
                                                <div class="form-group"> <!-- Image two -->
                                                    <label class="control-label col-sm-4 left"  >
                                                        <input type="button" class="btn btn-success" value="Browse.."  id="follImgBtn2" /> 
                                                        <input type="file" id="follUpImg2" name="follUpImg2"   />  </label>

                                                    <div class="col-md-6">
                                                        <img id="follView1" src="#" alt="Picture Not Selecte" />										 
                                                    </div>
                                                </div>
                                            </form>  
                                        </div>
                                        <button onclick="saveFollowUp('${sp.id}')"  class="btn btn-primary" >
                                            <span class="glyphicon glyphicon-save"></span>&nbsp;<span>Save</span>
                                        </button>
                                    </div>
                                </div>

                                <br>
                                <div class="panel-body" id="defaultResult" style="background-color:#fcfdfd;"> 
                                    <c:if test="${ not empty listFollUp}">
                                        Follow up List :
                                        <table class="table table-bordered" style="font-size:12px;">
                                            <tr>
                                                <th >#</th>
                                                <th>Diagnosis</th>
                                                <th >Date of Surgery</th>
                                                <th >Date of Follow Up</th>
                                                <th >Comment </th>
                                                <th >Subsequent Plan </th>

                                                <th>Picture one</th>
                                                <th>Picture two</th>
                                                <th >Action</th>
                                            </tr>
                                            <tbody>
                                                <c:forEach items="${listFollUp}" var="f" varStatus="index" >
                                                    <tr>
                                                        <td style="display:none;">${f.id} </td>
                                                        <td width="5%">${index.count}</td>
                                                        <td width="20%"> ${f.diagnosis}</td>
                                                        <td width="10%"><fmt:formatDate value="${f.dateOfSurgery}" pattern="MM/dd/yyyy"/></td>
                                                        <td width="10%"><fmt:formatDate value="${f.dateOfFollowUp}" pattern="MM/dd/yyyy"/></td>
                                                        <td  width="20%">${f.comment} </td>
                                                        <td  width="20%">${f.subsequentPlan} </td>
                                                        <td width="10%"> 
                                                            <c:if test="${not empty f.imgNameOne}">
                                                                <img class="example-image1" src="${pageContext.request.contextPath}/imageFolder/${f.imgNameOne}" 
                                                                     alt="image-1" width="50px;" height="50px;" />  
                                                            </c:if>
                                                        </td>
                                                        <td width="10%"> 
                                                            <c:if test="${not empty f.imgNameTwo}">
                                                                <img class="example-image1" src="${pageContext.request.contextPath}/imageFolder/${f.imgNameTwo}" 
                                                                     alt="image-1" width="50px;" height="50px;" /> 
                                                            </c:if>
                                                        </td>
                                                        <td> 
                                                            <c:if test="${f.creator eq u.userId}">
                                                                <button class="btn btn-success btn-sm followup" data-toggle="modal" data-backdrop="static" data-keyboard="false"
                                                                        data-id="${f.id}" >Edit <i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
                                                                </c:if>
                                                                <c:if test="${f.creator ne u.userId}">
                                                                <button class="btn btn-success btn-sm followup" data-toggle="modal" data-backdrop="static" data-keyboard="false"
                                                                        data-id="${f.id}" disabled >Edit <i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
                                                                </c:if>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table> 
                                    </c:if> 
                                </div>

                                <!-- Edit Followup modal -->
                                <div class="modal fade" id="followupForm" role="dialog" >
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                <h2 class="modal-title">Edit Follow up</h2>
                                            </div>
                                            <div class="modal-body">
                                                <form name="myForm" id="myForm" class="form-horizontal">
                                                    <input type="hidden" value="" id="followId" />
                                                    <div class="form-group" id="followupEditDiv"> </div>

                                                    <div class="modal-footer">
                                                        <div class="col-sm-8 left ">
                                                            <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="vm.clear()">
                                                                <span class="glyphicon glyphicon-ban-circle"></span>&nbsp;<span>Close</span>
                                                            </button>
                                                            <input type="hidden" value="${s.id}" id="fId" name="fId" />
                                                        </div>
                                                    </div> 
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>  <!-- Follow up end-->

                        </div> <!-- main tab div -->
                    </div>
                </div>
            </div> 

            <div class="modal fade" id="printSelect" role="dialog">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h2 class="modal-title">Please Select Print Information</h2>
                        </div>
                        <form class="form-horizontal" id="formPrintSelect">
                            <div class="modal-body">
                                <input id="patientId1" name="patientId1" type="hidden" id="patientId1" />
                                <div class="row" style="padding-left:100px"> 
                                    <table style="line-height:30px;">
                                        <tr style="border-bottom:1px solid #eee">
                                            <td width="60%"> Presenter Information </td> 
                                            <td width="10%"> <input type="checkbox" value="preInfo" id="preInfo" /> </td> 
                                        </tr>
                                        <tr style="border-bottom:1px solid #eee">
                                            <td> Patient Information </td> 
                                            <td> <input type="checkbox" value="patInfo" id="patInfo" /> </td> 
                                        </tr>
                                        <tr style="border-bottom:1px solid #eee">
                                            <td> Slide Information </td> 
                                            <td> <input type="checkbox" value="sliInfo" id="sliInfo" /> </td> 
                                        </tr>
                                        <tr style="border-bottom:1px solid #eee">
                                            <td> OT Note </td> 
                                            <td> <input type="checkbox" value="otInfo" id="otInfo" /> </td> 
                                        </tr>
                                        <tr style="border-bottom:1px solid #eee">
                                            <td> Follow Up </td> 
                                            <td> <input type="checkbox" value="folInfo" id="folInfo" /> </td> 
                                        </tr>
                                    </table>
                                </div>	
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal"> Close
                                    <i class="fa fa-times" aria-hidden="true"></i> </button>
                                <button type="button" data-dismiss="modal" onclick="check(${sp.id})" class="btn btn-default"> OK
                                    <i class="fa fa-print" aria-hidden="true"></i>  </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

    </body>

</html>