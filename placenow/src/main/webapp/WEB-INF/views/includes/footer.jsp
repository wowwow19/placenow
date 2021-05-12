<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	</div>
	<script>
		// 인기도 모달 팝업
		$("#placePopularity").click(function() {
			$("#popularityModal").modal("show");
		});
		
		// 네비게이션바 검색
		$(".navbar-search").on("submit", function() {
			var url = '<c:out value="${cri.listLink}" />';
			$(this).attr("action", "${pageContext.request.contextPath}/place/list" + url);
		});
		
		// 스크롤시 네비게이션 효과
		changeNav();
		toggleDropdown();
			
		function changeNav() {
			$(window).on("scroll", function() {
				var minHeight = $(".masthead").outerHeight() - 50;
				console.log(minHeight);
				
				if($(document).scrollTop() >= minHeight) {
					$(".navbar-logo").attr("src", "${pageContext.request.contextPath}/resources/img/logo-dark.png");
					$(".navbar").addClass("shadow").css("background", "white");
					$(".nav-link").css("color", "#222");
				} else {
					$(".navbar-logo").attr("src", "${pageContext.request.contextPath}/resources/img/logo-light.png")
					$(".navbar").removeClass("shadow").css("background", "transparent");
					$(".nav-link").css("color", "#efefef");
				}
			});
		}
		
		function toggleDropdown() {
			$(".dropdown-menu a").click(function() {
				$(this).parent().find(".active").removeClass("active");
				$(this).addClass("active");
			});
		}
		
		
	</script>
</body>

</html>