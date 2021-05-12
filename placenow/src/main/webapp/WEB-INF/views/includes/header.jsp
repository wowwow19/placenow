<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib  uri="http://www.springframework.org/security/tags" prefix="sec"%>
	
<!DOCTYPE html>
<html lang="ko">

<head>

	<meta charset="utf-8">
	<meta name="viewport"
		content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	
	<title>Place now</title>
	
	<!-- Bootstrap core CSS -->
	<link href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css"
		rel="stylesheet">
	
	<!-- Custom fonts for this template -->
	<link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
	
	<!-- Custom styles for this template -->
	<link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/landing-page.min.css" rel="stylesheet">
	
	<!-- Custom styles for this page -->
	<link href="${pageContext.request.contextPath}/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
	
	<!-- Custom fonts for this template -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/simple-line-icons/css/simple-line-icons.css">
		
	<!-- FullScreen CSS -->
	<link href="${pageContext.request.contextPath}/resources/vendor/fullpage/jquery.fullPage.css" rel="stylesheet">
	
	<!-- Common CSS -->
	<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">

	<!-- Bootstrap core JavaScript -->
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	
	<!-- Plugin JavaScript -->
	<script src="${pageContext.request.contextPath}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
	
	<!-- Custom scripts for all pages-->
	<script src="${pageContext.request.contextPath}/resources/js/sb-admin-2.min.js"></script>
	
	<!-- Custom scripts for this template -->
	<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/place.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/place-reply.js"></script>
	
	<!-- FullPage JavaScript -->
	<script src="${pageContext.request.contextPath}/resources/vendor/fullpage/jquery.fullPage.js"></script>
	<script src="${pageContext.request.contextPath}/resources/vendor/fullpage/jquery.fullpage.extensions.min.js"></script>
	
	<!-- kakaomap api -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a834c3a4d42546169a95c60ece44916d&libraries=services"></script>

	
</head>

<body id="page-top">

	<div class="wrapper">
		<!-- Navigation -->
		<nav class="navbar navbar-expand navbar-light topbar mb-4 fixed-top"
			id="mainNav">
			<div class="container">
				<a class="navbar-brand js-scroll-trigger" href="${pageContext.request.contextPath}/"> <img
					class="navbar-logo" alt="logo" src="${pageContext.request.contextPath}/resources/img/logo-light.png">
				</a>
                <form
                    class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search" action="">
                    <div class="input-group">
                        <input type="search" name="keyword" class="list-search-input form-control bg-light border-0 small" placeholder="어디로 갈까요?"
                            aria-label="Search" aria-describedby="basic-addon2">
                        <div class="input-group-append">
                            <button class="btn btn-light" type="button">
                                <i class="mb-2 fas fa-search fa-sm"></i>
                            </button>
                        </div>
                       	<input type="hidden" name="region" value="${cri.region}">
                       	<input type="hidden" name="category" value="${cri.category}">
                    </div>
                </form>
				
				<sec:authentication property="principal" var="member"/>
				<ul class="nav navbar-nav navbar-right">
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle mr-3" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2">${member == 'anonymousUser' ? '로그인해주세요' : member.vo.userName}</span>
                                <i class="fas fa-user-circle"></i>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <sec:authorize access="isAnonymous()">
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/register/terms">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    회원가입
                                </a>
                                <a class="dropdown-item" href="#" onclick="alert('준비중입니다.')">
                                	<i class="fas fa-question-circle mr-2 text-gray-400"></i>
                                   	문의게시판
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/customLogin">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    로그인
                                </a>
                                </sec:authorize>
                                <sec:authorize access="isAuthenticated()">
	                                <sec:authorize access="hasRole('ROLE_ADMIN')">
	                                <a class="dropdown-item" href="#">
	                                	<i class="fas fa-user-cog mr-2 text-gray-400"></i>
	                                   	관리자메뉴
	                                </a>
	                                </sec:authorize>
	                                <sec:authorize access="hasRole('ROLE_MEMBER')">
	                                <a class="dropdown-item" href="#" onclick="alert('준비중입니다.')">
	                                	<i class="fas fa-user mr-2 text-gray-400"></i>
	                                   	마이페이지
	                                </a>
	                                <a class="dropdown-item" href="${pageContext.request.contextPath}/place/favorite">
	                                	<i class="fas fa-heart mr-2 text-gray-400"></i>
	                                  	즐겨찾기
	                                </a>
	                                </sec:authorize>
                                <a class="dropdown-item" href="#">
                                	<i class="fas fa-question-circle mr-2 text-gray-400"></i>
                                   	문의게시판
                                </a>
                                <div class="dropdown-divider"></div>
                                <form method="post" action="${pageContext.request.contextPath}/customLogout">
	                                <button class="dropdown-item">
	                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
	                                    로그아웃
	                                </button>
	                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                </form>
                                </sec:authorize>
                            </div>
                        </li>
				</ul>
			</div>
		</nav>