<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib  uri="http://www.springframework.org/security/tags" prefix="sec"%>

<jsp:include page="includes/header.jsp" />
	  <div id="fullpage">
	  	<div class="section" id="section1">
  		    <video muted autoplay loop data-keepplaying>
		      <source data-src="${pageContext.request.contextPath}/resources/img/city.mp4" type="video/mp4">
		    </video>
		    <div class="main-logo">
		    	<a href="${pageContext.request.contextPath}/"><img alt="logo" src="${pageContext.request.contextPath}/resources/img/logo-light.png"></a>
		    </div>
			<sec:authorize access="isAnonymous()">
		    <div class="main-login mt-5">
	   			<div class="login-btn-wrapper">
			   		<a href="/customLogin" class="btn btn-outline-light login-btn mt-2">로그인</a>
	   			</div>
		   	</div>
		   	</sec:authorize>
		   	<sec:authorize access="isAuthenticated()">
		    <div class="main-login mt-5">
		    	<form method="post" action="/customLogout">
		   			<div class="login-btn-wrapper">
				   		<button class="btn btn-outline-light login-btn mt-2">로그아웃</button>
		   			</div>
		   			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	   			</form>
		   	</div>
		   	</sec:authorize>
  		</div>
	  	<div class="section" id="section2">
  			<div class="slide" id="slide1" data-anchor="slide1"><span class="slide-category">여행지</span></div>
			<div class="slide" id="slide2" data-anchor="slide2"><span class="slide-category">액티비티</span></div>
			<div class="slide" id="slide3" data-anchor="slide3"><span class="slide-category">카페</span></div>
			<div class="slide" id="slide4" data-anchor="slide4"><span class="slide-category">맛집</span></div>
	  	</div>
	  </div>
  	  <div class="search">
  	  	<form method="get" action="place/list">
	  	  	<input class="search-input" name="keyword" type="text">
	  	  	<button class="search-btn"><i class="fas fa-search"></i></button>
  	  	</form>
  	  	<p>NOW</p>
  	  </div>
  	  <div class="main-btm">
	  	  <div class="btm-arrow">
	  	  	<i class="fas fa-chevron-down"></i>
	  	  </div>
  	  </div>
	<script>
		init();
		
		function init() {
			focusSearch();
		}
		
		// 풀페이지 설정
		$('#fullpage').fullpage({
			//options here
			autoScrolling : true,
			scrollHorizontally : true,
			navigation : true,
			navigationPosition : 'right',
			sectionSelector : '.section',
			slideSelector : '.slide',
			loopBottom : true,
			loopHorizontal : true,
			controlArrows : false,
			afterRender : function() {
				setInterval(function() {
					$.fn.fullpage.moveSlideRight();
				}, 3000);
				
				$(".navbar-brand img").hide();
				$(".nav-link").css("color", "#222");
				$(".navbar-search *").hide();
			},
			onLeave : function(index, nextIndex, direction) {
				var width = $(".slide.active").find("span").width();
				/* section1 -> section 2 */
				if (index == 1 && direction == 'down') {
					$(".navbar-brand img").fadeIn();
					$(".main-btm").fadeOut();
					$(".search").fadeIn();
					$(".search input").val("");
					$(".slide-category").fadeIn();
					$(".search input").css("transition", ".5s").width(width + 50);
					$(".nav-link").css("color", "#efefef");
				}
				/* section2 -> section 1 */
				if (index == 2 && direction == 'up' || 
					index == 2 && direction == 'down') {
					$(".navbar-brand img").fadeOut();
					$(".main-btm").fadeIn();
					$(".search").fadeOut();
					$(".nav-link").css("color", "#222");
				}
			},
			onSlideLeave : function(origin, index, direction) {
				var width = $(this).next().find("span").width();
				var firstWidth = $("#slide1").find("span").width();
		
				if (!$(".search-input").is(":focus")) {
					if($(".search-input").val() == "") {
						if ($(this).find("span").text() === "맛집") {
							$(".search input").css("transition", ".5s").width(firstWidth + 50);
						} else {
							$(".search input").css("transition", ".5s").width(width + 50);
						}
					}
				}
			}
		});
		
		// 메인 검색창 focus 효과
		function focusSearch() {
			$(".search-input").focusin(function() {
				$(".slide span").fadeOut();
				$(".search input").width(300).css("color", "#222");
				$(".search-btn").css("color", "#222");
			});
		
			$(".search-input").focusout(function() {
				var width = $("#section2").children().find(".active").find("span").width();
				if($(this).val() == "") {
					$(".slide span").fadeIn();
					$(".search input").width(width + 50);
				} else {
					$(".search input").css("color", "#efefef");
				}
				$(".search-btn").css("color", "#efefef");
			});
		}
	</script>
<jsp:include page="includes/footer.jsp" />