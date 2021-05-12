<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Place now</title>

    <!-- Custom fonts for this template-->
    <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">

</head>

<body>

    <div class="container" id="loginContainer">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-5 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="p-5">
                                    <div class="text-center">
                                        <a href="/"><img src="${pageContext.request.contextPath}/resources/img/logo-dark.png" style="width: 150px"></a>
                                    </div>
                                    <form class="user mt-5" method="post" action="${pageContext.request.contextPath}/login">
                                        <div class="form-group">
                                            <input type="text" name="username" class="form-control form-control-user"
                                                id="exampleInputEmail" aria-describedby="emailHelp"
                                                placeholder="이메일주소">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" name="password" class="form-control form-control-user"
                                                id="exampleInputPassword" placeholder="비밀번호">
                                        </div>
                                        <div class="form-group">
                                            <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" name="remember-me" class="custom-control-input" id="customCheck">
                                                <label class="custom-control-label" for="customCheck">자동로그인</label>
                                            </div>
                                        </div>
                                        <button class="btn btn-primary btn-user btn-block">로그인</button>
                                        <!-- <hr>
                                        <button href="index.html" class="btn btn-user btn-block login-naver-btn">
                                            <span class="h6"><b>N</b></span><span class="mb-2"> 네이버로 로그인</span>
                                        </button>
                                        <button href="index.html" class="btn btn-user btn-block login-kakao-btn">
                                            <span class="h6"><b>k</b></span><span> 카카오로 로그인</span>
                                        </button> -->
                                   		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                   	</form>
                                    <!-- <div class="text-center mt-3">
                                    	<span class="small">비밀번호를 잊으셨나요? </span>
                                        <a class="small" href="#"><b> 비밀번호 찾기</b></a>
                                    </div> -->
                                    <div class="text-center">
                                    	<span class="small">아직 회원이 아니신가요? </span>
                                        <a class="small" href="${pageContext.request.contextPath}/register/terms"><b> 회원가입</b></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="${pageContext.request.contextPath}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="${pageContext.request.contextPath}/resources/js/sb-admin-2.min.js"></script>
    <script>
    	<c:if test="${not empty error}">
    	alert("<c:out value='${error}'/>")
    	</c:if>
    </script>
</body>
</html>