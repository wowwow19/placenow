<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib  uri="http://www.springframework.org/security/tags" prefix="sec"%>

<jsp:include page="../includes/header.jsp" />
	<!-- Masthead -->
	<header class="masthead text-white text-center">
		<div class="container">
			<div class="row">
				<div class="header-text col-xl-9 mr-auto mb-5">
		        	<h1 class="region-text badge badge-light"></h1><h1><i class="fas fa-angle-right"></i></h1><h1 class="category-text badge badge-light"></h1>
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
    		<c:if test="${not empty param.keyword}">
    		<h2>"${param.keyword}" 검색결과</h2>
    		</c:if>
    	</div>
		<div class="place-list-btns mt-3">
			<div class="btn-group">
				<div class="btn-group region-btn">
					<button type="button" class="region-btn btn btn-outline-info dropdown-toggle" data-toggle="dropdown">
						지역
					</button>
					<div class="dropdown-menu dropdown-menu-left">
						<a class="dropdown-item" href="list?category=${param.category}" data-region="0">전체 (${total[0]})</a>
				      	<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="list?region=1&category=${param.category}" data-region="1">서울/인천 (${total[1]})</a>
						<a class="dropdown-item" href="list?region=2&category=${param.category}" data-region="2">경기 (${total[2]})</a>
						<a class="dropdown-item" href="list?region=3&category=${param.category}" data-region="3">강원 (${total[3]})</a>
						<a class="dropdown-item" href="list?region=4&category=${param.category}" data-region="4">대전/충청 (${total[4]})</a>
						<a class="dropdown-item" href="list?region=5&category=${param.category}" data-region="5">광주/전라 (${total[5]})</a>
						<a class="dropdown-item" href="list?region=6&category=${param.category}" data-region="6">대구/경북 (${total[6]})</a>
						<a class="dropdown-item" href="list?region=7&category=${param.category}" data-region="7">부산/경남 (${total[7]})</a>
						<a class="dropdown-item" href="list?region=8&category=${param.category}" data-region="8">제주 (${total[8]})</a>
					</div>
				</div>
				<div class="btn-group category-btn">
					<button type="button" class="category-btn btn btn-outline-info dropdown-toggle" data-toggle="dropdown">
						구분
					</button>
					<div class="dropdown-menu dropdown-menu-right">
						<a class="dropdown-item" href="list?region=${param.region}" data-category="0">전체</a>
				      	<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="list?region=${param.region}&category=1" data-category="1">여행지</a>
						<a class="dropdown-item" href="list?region=${param.region}&category=2" data-category="2">액티비티</a>
						<a class="dropdown-item" href="list?region=${param.region}&category=3" data-category="3">카페</a>
						<a class="dropdown-item" href="list?region=${param.region}&category=4" data-category="4">맛집</a>
					</div>
				</div>
			</div>
		</div>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
		<div class="place-add-btn mt-3">
			<a href="add"><button type="button" class="btn btn-primary btn-block"><i class="fas fa-plus-circle"></i> 장소추가</button></a>
		</div>
		</sec:authorize>
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
	var region = '<c:out value="${empty param.region ? 0 : param.region}" />';
	var category = '<c:out value="${empty param.category ? 0 : param.category}" />';
	var keyword = '<c:out value="${param.keyword}" />';
	var placeList = $(".place-list");
	var lastPno = 1;
	const regionArr = ["전체", "서울/인천", "경기", "강원", "대전/충청", "광주/전라", "대구/경북", "부산/경남", "제주"];
	const categoryArr = ["전체", "여행지", "액티비티", "카페", "맛집"];
	var csrf = "${_csrf.headerName}";
	var csrfToken = "${_csrf.token}";
	
	$(document).ajaxSend(function(e, xhr) {
		xhr.setRequestHeader(csrf, csrfToken);
	});
	
	$(".region-text").text(regionArr[region]);
	$(".category-text").text(categoryArr[category]);
	init();
	
	
	function showMore(pno) {
		if($(".list-search-input").val() != "") {
			keyword = $(".list-search-input").val();
		}
		
		placeService.getMore({
			region: region,
			category: category,
			keyword: keyword,
			pno: pno,
			cp: cp
		}, function(list) {
			
			// 장소 목록 콘솔 출력
			console.log(list);
			
			if(!list.length) {
				return;
			}
			
			var str = "";
			for(var i in list) {
				var popularity = list[i].popularity;
				var popularityClass = "";
				var popularityText = "";
				
				if(popularity > 2000) {
					popularityClass = "fa-thermometer-full popularity-high";
					popularityText = "높음";
				} else if(popularity > 1000) {
					popularityClass = "fa-thermometer-half popularity-normal";
					popularityText = "보통";
				} else {
					popularityClass = "fa-thermometer-empty popularity-low";
					popularityText = "낮음";
				}
				
				str +=	'<li class="card shadow" data-pno="' + list[i].pno + '">';
				str +=		'<div class="shadow place-popularity">';
				str +=			'<i class="fas ' + popularityClass + '" id="popIcon"></i>';
				str +=			'<p id="popText">' + popularityText + '</p>';
				str +=		'</div>';
				str +=		'<img src="${pageContext.request.contextPath}/display?fileName=' + list[i].attachList[0].downloadPath + '" class="card-img-top" alt="place-thumbnail">';
				if(list[i].replyNum != 0) {
					str += '<div class="update-info"><span>업데이트됨 : </span><span>' + list[i].updateDate + '</span></div>';
				}
				str +=		'<div class="card-body place-info">';
				str +=			'<ul>';
				str +=				'<li class="place-title">';
				str +=					'<h4 class="card-title mt-2">' + list[i].pname + '</h4>';
				str +=					'<p>' + list[i].address + '</p>';
				str +=				'</li>';
				str +=				'<li class="place-fav-btn">';
				str +=					'<i class="far fa-heart fav-btn" data-pno="' + list[i].pno + '"></i>';
	            str +=   				'<p class="fav-num">' + list[i].favNum +'</p>';
				str +=				'</li>';
				str +=			'</ul>';
				str +=		'</div>';
				str +=	'</li>';
			}
			
			placeList.html(placeList.html() + str);
			init();
		});
	}
	
	window.onscroll = function(e) {
	    //추가되는 임시 콘텐츠
	    //window height + window scrollY 값이 document height보다 클 경우,
	    if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
	    	// 마지막 rno 가져오기
			lastPno = $(".place-list > li:last").data("pno");
	    	console.log(lastPno);
			// showList() 호출
			showMore(lastPno);
	    }
	};
									
	function showResult(pno, keyword) {
		placeService.getMore({
			region: region,
			category: category,
			keyword: keyword,
			pno: pno,
			cp: cp
		}, function(list) {
			
			// 장소 목록 콘솔 출력
			console.log(list);
							
			var str = "";
			for(var i in list) {
				var popularity = list[i].popularity;
				var popularityClass = "";
				var popularityText = "";
				
				if(popularity > 2000) {
					popularityClass = "fa-thermometer-full popularity-high";
					popularityText = "높음";
				} else if(popularity > 1000) {
					popularityClass = "fa-thermometer-half popularity-normal";
					popularityText = "보통";
				} else {
					popularityClass = "fa-thermometer-empty popularity-low";
					popularityText = "낮음";
				}
				
				str +=	'<li class="card shadow" data-pno="' + list[i].pno + '">';
				str +=		'<div class="shadow place-popularity">';
				str +=			'<i class="fas ' + popularityClass + '" id="popIcon"></i>';
				str +=			'<p id="popText">' + popularityText + '</p>';
				str +=		'</div>';
				str +=		'<img src="${pageContext.request.contextPath}/display?fileName=' + list[i].attachList[0].downloadPath + '" class="card-img-top" alt="place-thumbnail">';
				if(list[i].replyNum != 0) {
					str += '<div class="update-info"><span>업데이트됨 : </span><span>' + list[i].updateDate + '</span></div>';
				}
				str +=		'<div class="card-body place-info">';
				str +=			'<ul>';
				str +=				'<li class="place-title">';
				str +=					'<h4 class="card-title mt-2">' + list[i].pname + '</h4>';
				str +=					'<p>' + list[i].address + '</p>';
				str +=				'</li>';
				str +=				'<li class="place-fav-btn">';
				str +=					'<i class="far fa-heart fav-btn" data-pno="' + list[i].pno + '"></i>';
	            str +=   				'<p class="fav-num">' + list[i].favNum +'</p>';
				str +=				'</li>';
				str +=			'</ul>';
				str +=		'</div>';
				str +=	'</li>';
			}
			
			placeList.html(str);
			init();
		});
	}
	
	function init() {			
		$(".place-list > li > img, .place-list > li .place-title").click(function() {
			var url = '<c:out value="${cri.listLink2}" escapeXml="false" />';
			var pno = $(this).closest(".card").data("pno");
			console.log(url);
			console.log(pno);
			$(location).attr("href", "detail" + url + "&pno=" + pno);
		});
		
		$(".region-btn a[data-region='" + region +"']").addClass("active");
		$(".category-btn a[data-category='" + category +"']").addClass("active");
		
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
				
				$("#addText").fadeIn();
				
				setTimeout(function() {
					$("#addText").fadeOut();
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
				
				$("#removeText").fadeIn();
				
				setTimeout(function() {
					$("#removeText").fadeOut();
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