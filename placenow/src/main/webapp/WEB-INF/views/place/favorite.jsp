<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib  uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<jsp:include page="../includes/header.jsp" />
	<!-- Masthead -->
	<header class="masthead text-white text-center">
		<div class="container">
			<div class="row">
				<div class="header-text col-xl-9 mr-auto mb-5">
		        	<h1 class="region-text badge badge-light">즐겨찾기</h1>
		    	</div>
			</div>
		</div>
	</header>
	
	<div class="modal fade" id="popularityModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xs" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<p><b>인기도</b>란?</p>
					<span>SNS상에서 태그로 언급된 횟수에 따라 산정되는 수치입니다.</span>
				</div>
				<div class="modal-footer">
					<button id="modalCloBtn" class="btn btn-outline-secondary btn-sm" type="button"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

    <div class="place-wrapper">
    	<div class="search-keyword">
    		<c:if test="${not empty list}">
    		<h2>총 ${fn:length(list)} 건의 즐겨찾기된 장소</h2>
    		</c:if>
    	</div>
	    <div class="place-list-content mt-3">
			<ul class="place-list" id="placeList">
				<c:forEach items="${list}" var="place">
				<li class="card shadow" data-pno="${place.pno}">
					<img src="${pageContext.request.contextPath}/display?fileName=${place.attachList[0].downloadPath}" class="card-img-top" alt="place-thumbnail">
					<div class="shadow place-popularity">
						<c:choose>
							<c:when test="${place.popularity > 2000}">
							<i class="fas fa-thermometer-full popularity-high" id="popIcon"></i>
							<p id="popText">높음</p>
							</c:when>
							<c:when test="${place.popularity > 1000}">
							<i class="fas fa-thermometer-half popularity-normal" id="popIcon"></i>
							<p id="popText">보통</p>
							</c:when>
							<c:when test="${place.popularity <= 1000}">
							<i class="fas fa-thermometer-empty popularity-low" id="popIcon"></i>
							<p id="popText">낮음</p>
							</c:when>
						</c:choose>
					</div>
					<c:if test="${place.replyNum ne 0}">
					<div class="update-info"><span>업데이트됨 : </span><span>${place.updateDate}</span></div>
					</c:if>
					<div class="card-body place-info">
						<ul>
							<li class="place-title">
								<h4 class="card-title mt-2">${place.pname}</h4>
								<p>${place.address}</p>
							</li>
							<li class="place-fav-btn">
								<i class="far fa-heart fav-btn" data-pno="${place.pno}"></i>
               					<p class="fav-num">${place.favNum}</p>
							</li>
						</ul>
					</div>
				</li>
				</c:forEach>
			</ul>
	    </div>
   	    <div class="fav-text" id="addText">
	    	<span>즐겨찾기에 추가되었습니다</span>
	    </div>
	    <div class="fav-text" id="removeText">
	    	<span>즐겨찾기에서 제외되었습니다</span>
	    </div>
	</div>
<script>
	var cp = "${pageContext.request.contextPath}";
	var userId = "";
	<sec:authorize access="isAuthenticated()">
	userId = '<sec:authentication property="principal.username" htmlEscape="false"/>';
	</sec:authorize>
	var placeList = $(".place-list");
	var lastPno = 1;
	var csrf = "${_csrf.headerName}";
	var csrfToken = "${_csrf.token}";
	
	$(document).ajaxSend(function(e, xhr) {
		xhr.setRequestHeader(csrf, csrfToken);
	});
	
	init();
	
	function init() {			
		$(".place-list > li > img, .place-list > li .place-title").click(function() {
			var pno = $(this).closest(".card").data("pno");
			$(location).attr("href", "detail?pno=" + pno);
		});
			
		$(".place-popularity").click(function() {
			$("#popularityModal").modal("show");
		})
		
		/* 즐겨찾기에 추가 또는 제외 */
		$(".place-fav-btn").on("click", "i", function() {
			var pno = $(this).data("pno");
			var favNum = $(this).next().text() * 1;
			
			if(userId == "") {
				alert("로그인해주세요.");
				return;
			}
			
			if($(this).hasClass("far")) {
				/* 즐겨찾기 추가 */
				placeService.addFavList({
					pno: pno,
					userId: userId,
					cp: cp
				}, function(result) {
					console.log(result)
				});
				
				$(this).next().text(favNum+1);
				
				$("#addText").off().fadeIn();
				
				setTimeout(function() {
					$("#addText").off().fadeOut();
				}, 2000);
			} else {
				/* 즐겨찾기 제외 */
				placeService.removeFavList({
					pno: pno,
					userId: userId,
					cp: cp
				}, function(result) {
					console.log(result)
				});
				
				$(this).next().text(favNum-1);
				
				$("#removeText").off().fadeIn();
				
				setTimeout(function() {
					$("#removeText").off().fadeOut();
				}, 2000);
			}
			$(this).toggleClass("far fas");
		});
		
		if(userId != "") {
			placeService.getFavList({
				userId: userId,
				cp: cp
			}, function(result) {
				var favList = result;
				
				$(".place-list > li").each(function() {
					for(var i in favList) {
						if($(this).data("pno") == favList[i].pno) {
							$(this).find(".fav-btn").removeClass("far").addClass("fas");
						}
					}
				});
			});
		}
	}

</script>
<jsp:include page="../includes/footer.jsp" />