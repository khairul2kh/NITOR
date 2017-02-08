<%-- 
    Document   : header
    Created on : Jan 26, 2017, 12:04:06 PM
    Author     : Khairul
--%>

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
                        <li><a role="menuitem" tabindex="-1" href="selectedPatientList.htm" 
                               data-backdrop="static" data-keyboard="false"> Back </a></li>
                        <li role="presentation" class="divider"></li>
                        <li><a role="menuitem" tabindex="-1" href='${pageContext.request.contextPath}/logout'>
                                <span class="glyphicon glyphicon-log-out"></span>&nbsp; Log Out</a></li>
                    </ul>
                </li>
            </ul> 
        </div>
    </div>
</nav>
