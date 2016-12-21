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
        <style>
            .icon-success {
                color: #088A08;
            }
            body, #mainWrapper {
                height: 100%;
                background-color:#FFF;
            }
            body, .form-control{
                font-size:12px!important;

            }
            .floatRight{
                float:right;
                margin-right: 18px;
            }
            .has-error{
                color:red;
            }
            .formcontainer{
                background-color: #DAE8E8;
                padding: 20px;
            }
            .tablecontainer{
                padding-left: 20px;
            }
            .generic-container {
                width:80%;
                margin-left: 10%;
                margin-top: 20px;
                margin-bottom: 20px;
                padding: 20px;
                background-color: #EAE7E7;
                border: 1px solid #ddd;
            }
            .custom-width {
                width: 80px !important;
            }
            .tdn a{text-decoration: none;}
            .nav-tabs>li.active>a,
            .nav-tabs>li.active>a:hover,
            .nav-tabs>li.active>a:focus {
                color: #555;
                background-color: #F2F2F2;
                border: 1px solid #eee;
                border-bottom-color: transparent;
                cursor: default
            }
            .header{
                display:block;
                height:50px;
                position:relative;
                background: #50a3a2;
                background: -webkit-linear-gradient(top left, #50a3a2 0%, #53e3a6 100%);
                background: linear-gradient(to bottom right, #50a3a2 0%, #53e3a6 100%);
                width:100%;
            }
            .modal-dialog{
                position: relative;
                display: table; //This is important 
                overflow-y: auto;    
                overflow-x: auto;
                width: auto;
                min-width: 70%;   
            }
            .modal-header, h2, .close {
                background-color: #5cb85c;
                color:white !important;
                text-align: center;
                font-size: 16px;
            }
        </style>
        <script>
            var myApp = angular.module("myApp", []);
            myApp.controller("myController", function($scope) {

                $scope.newUser = {};
                $scope.clickedUser = {};
                $scope.users = [
                    {username: "khairul", fullname: "Hasan Zamil", email: "jakir@gmail.com"},
                    {username: "Mahbub", fullname: "Zakir Hossain", email: "abc@gmail.com"},
                    {username: "Shimul", fullname: "AZM Mahmud", email: "Mahmud@gmail.com"}
                ];

                $scope.saveUser = function() {
                    $scope.users.push($scope.newUser);
                    $scope.newUser = {};
                };

                $scope.selectUser = function(user) {
                    console.log(user);
                };

            });

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
                                <li><a role="menuitem" tabindex="-1" href="" data-toggle="modal" data-target="#myModal" data-backdrop="static" data-keyboard="false">
                                        Add Doctor Profile</a></li>
                                <li  ><a role="menuitem" tabindex="-1" href="#">CSS</a></li>
                                <li  ><a role="menuitem" tabindex="-1" href="#">JavaScript</a></li>
                                <li role="presentation" class="divider"></li>
                                <li><a role="menuitem" tabindex="-1" href='${pageContext.request.contextPath}/logout'>
                                        <span class="glyphicon glyphicon-log-out"></span>&nbsp; Log Out</a></li>
                            </ul>
                        </li>
                    </ul> 
                </div>
            </div>
        </nav> 
        <br><br>

        <div class="container theme-showcase" role="main">
            <div class="page-header">
                <h1> Text </h1>
            </div>
            <div class="row">
                <div class="col-sm-2"><div>  </div>   </div>
                <div class="col-sm-3">
                    <div >
                        <div class="input-group">
                            <input type="button" style="text-align:left;"  value="Add Doctor Profile" class="form-control btn btn-success " 
                                   data-toggle="modal" data-target="#myModal" data-backdrop="static" data-keyboard="false" />
                            <span class = "input-group-addon btn" data-toggle="modal" data-target="#myModal" data-backdrop="static" data-keyboard="false">
                                <i class="fa fa-user-md green"   aria-hidden="true"></i>
                            </span>
                        </div>
                        <br>
                        <div class="input-group">
                            <input type="button" style="text-align:left;"  value="Add Patient" class="form-control btn btn-success" 
                                   data-toggle="modal" data-target="#myModal" data-backdrop="static" data-keyboard="false" />
                            <span class = "input-group-addon btn" data-toggle="modal" data-target="#myModal" data-backdrop="static" data-keyboard="false">
                                <i class="fa fa-user-o green" aria-hidden="true"></i>

                            </span>
                        </div>
                        <br>
                        <div class="input-group">
                            <input type="button" style="text-align:left;"  value="Add Slide" class="form-control btn btn-success" 
                                   data-toggle="modal" data-target="#myModal" data-backdrop="static" data-keyboard="false" />
                            <span class = "input-group-addon btn" data-toggle="modal" data-target="#myModal" data-backdrop="static" data-keyboard="false">
                                <i class="fa fa-plus-square fa-1x green" aria-hidden="true" ></i>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="col-sm-2"><div>  </div>   </div>
            </div>
            <div class="page-header"></div> 
        </div>  

        <!-- Modal Doctor Profile -->
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h2 class="modal-title">Create Doctor Profile</h2>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" role="form" method="POST" action="addDoctor.htm">
                            <div class="form-group">
                                <label class="control-label col-sm-3"  >Doctor Name :</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" ng-model="doctorName" id="doctorName" name="doctorName" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-3"  >Designation</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" ng-model="designation" id="designation" name="designation" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-3"  >Course</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" ng-model="course" id="course" name="course" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-3"  >Session</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" ng-model="session" id="session" name="session" />
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="vm.clear()">
                                    <span class="glyphicon glyphicon-ban-circle"></span>&nbsp;<span>Close</span>
                                </button>
                                <button type="submit"  class="btn btn-primary" data-dismiss="modal">
                                    <span class="glyphicon glyphicon-save"></span>&nbsp;<span>Save</span>
                                </button>
                            </div>
                        </form>
                    </div>

                    <button type="submit" class="btn btn-default" ng-click="saveUser()" data-dismiss="modal">Save</button>  

                </div>
            </div>
        </div>
    </div>
    <!-- Modal Doctor Profile End -->


    <script>
        if (SESSION.checkSession()) {
            jQuery(document).ready(function() {
                $("#date").css('cursor', 'pointer');
                $('#date').datepicker();
                $("#date1").css('cursor', 'pointer');
                $('#date1').datepicker();
            });
        }

        $('.clockpicker').clockpicker()
                .find('input').change(function() {
            console.log(this.value);
        });
        var input = $('#single-input').clockpicker({
            placement: 'bottom',
            align: 'left',
            autoclose: true,
            'default': 'now'
        });
        $('ul li a').click(function() {
            $('ul li.active').removeClass('active');
            $(this).closest('li').addClass('active');
        });
    </script>

</body>
<%@ include file="/WEB-INF/template/footer.jsp"%>
</html>

