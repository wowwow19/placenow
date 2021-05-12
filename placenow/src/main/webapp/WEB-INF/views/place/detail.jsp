<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib  uri="http://www.springframework.org/security/tags" prefix="sec"%>

<jsp:include page="../includes/header.jsp" />
<!-- Masthead -->
<header class="masthead text-white text-center">
	<div class="container">
		<div class="row">
			<div class="header-text col-xl-9 mr-auto mb-5">
				<h1 class="region-text badge badge-light"></h1>
				<h1>
					<i class="fas fa-angle-right"></i>
				</h1>
				<h1 class="category-text badge badge-light"></h1>
			</div>
		</div>
	</div>
</header>

<div class="modal fade" id="popularityModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xs" role="document">
		<div class="modal-content">
			<div class="modal-body">
				<p>
					<b>인기도</b>란?
				</p>
				<span>SNS상에서 태그로 언급된 횟수에 따라 산정되는 수치입니다.</span>
			</div>
			<div class="modal-footer">
				<button id="modalCloBtn" class="btn btn-outline-secondary btn-sm"
					type="button" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<div class="place-wrapper card shadow" id="detailWrapper">
	<div class="row mb-3" id="detailTopBtns">
		<div class="col">
			<a href="${pageContext.request.contextPath}/place/list<c:out value='${cri.listLink2}' escapeXml='false'/>"
				class="btn btn-sm btn-outline-info"><i
				class="fas fa-chevron-left"></i> 목록으로</a>
		</div>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
		<div class="col text-right">
			<form method="post" action="${pageContext.request.contextPath}/place/delete">
				<div class="btn-group">
					<a href="${pageContext.request.contextPath}/place/update?pno=${place.pno}"
						class="btn btn-sm btn-outline-primary">수정</a>
					<button class="btn btn-sm btn-outline-danger place-delete-btn">삭제</button>
				</div>
				<input type="hidden" name="pno" value="${place.pno}">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			</form>
		</div>
		</sec:authorize>
	</div>
	<div class="place-detail-info">
		<div class="info-left">
			<div class="info-left-top">
				<div class="place-title mb-2" id="detail-title">
					<span>${place.pname}</span>
				</div>
			</div>
			<div class="place-address">
				<span>${place.address}</span> <span class="location-btn"><b>위치보기</b></span>
			</div>
		</div>
		<div class="info-right">
			<div class="shr-btn-wrapper">
				<i class="fas fa-share-alt shr-btn"></i>
			</div>
			<div class="fav-btn-wrapper">
				<i class="far fa-heart fav-btn" data-pno="${place.pno}"></i>
				<p class="fav-num">${place.favNum}</p>
			</div>
		</div>
	</div>

	<div id="demo" class="carousel slide mt-3" data-ride="carousel"
		id="placePictures">

		<!-- Indicators -->
		<ul class="carousel-indicators">
			<c:forEach begin="0" end="${fn:length(attachList)-1}" step="1" var="i">
			<li data-target="#demo" data-slide-to="0"></li>
			</c:forEach>
		</ul>

		<!-- The slideshow -->
		<div class="carousel-inner">
			<c:forEach items="${attachList}" var="attach">
				<div class="carousel-item">
					<img src="${pageContext.request.contextPath}/display?fileName=${attach.downloadPath}"
						alt="picture">
				</div>
			</c:forEach>
		</div>

		<!-- Left and right controls -->
		<a class="carousel-control-prev" href="#demo" data-slide="prev"> <span
			class="carousel-control-prev-icon"></span>
		</a> <a class="carousel-control-next" href="#demo" data-slide="next">
			<span class="carousel-control-next-icon"></span>
		</a>

		<div class="shadow place-popularity" id="detailPopularity">
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

	</div>


	<div class="place-detail-map" id="map"></div>

	<div class="comments-logo">
		<span>NOW</span> <i class="fas fa-broadcast-tower"></i>
	</div>

	<div class="more-btn">
		<button id="replyMoreBtn">더보기</button>
	</div>

	<div class="reply-content-wrapper">
		<ul></ul>
	</div>
    <div class="fav-text detail-fav-text" id="addText">
    	<span>즐겨찾기에 추가되었습니다</span>
    </div>
    <div class="fav-text detail-fav-text" id="removeText">
    	<span>즐겨찾기에서 제외되었습니다</span>
    </div>
</div>

<!-- <div class="move-top-btn" id="place-page-move-top-btn">
	<a href="" id="move-top-btn"><i class="fas fa-chevron-up"></i></a>
</div> -->

<sec:authentication property="principal" var="member" />
<div class="place-detail-reply-input">
	<form action="" class="place-reply-form">
		<div class="emoji-btn">
			<i class="far fa-smile"></i>
		</div>
		<input type="text" id="replyContent" class="form-control" name="content" placeholder="실시간 정보를 공유해주세요.">
		<input type="hidden" id="replyUserId" class="form-control" name="userId">
		<input type="hidden" class="form-control" name="pno" value="${place.pno}">
		<button id="addReplyBtn">
			<span>입력</span>
		</button>
	</form>
</div>

<script>
	var cp = "${pageContext.request.contextPath}";
	var userId = "";
	var region = '<c:out value="${empty param.region ? 0 : param.region}" />';
	var category = '<c:out value="${empty param.category ? 0 : param.category}" />';
	var keyword = '<c:out value="${param.keyword}" />';
	var pno = '<c:out value="${place.pno}" />';
	const regionArr = [ "전체", "서울/인천", "경기", "강원", "대전/충청", "광주/전라", "대구/경북",
			"부산/경남", "제주" ];
	const categoryArr = [ "전체", "여행지", "액티비티", "카페", "맛집" ];
	var replyUL = $(".reply-content-wrapper > ul");
	var firstPicture = $(".carousel-inner div:first");
	var firstIndicator = $(".carousel-indicators li:first");
	var csrf = "${_csrf.headerName}";
	var csrfToken = "${_csrf.token}";
	var checkReply = isRecent() == "true";
	<sec:authorize access="isAuthenticated()">
	userId = '<sec:authentication property="principal.username" htmlEscape="false"/>';
	</sec:authorize>
	console.log(checkReply);
	console.log(typeof checkReply);

	$(document).ajaxSend(function(e, xhr) {
		xhr.setRequestHeader(csrf, csrfToken);
	});

	$(function() {		
		$(".region-text").text(regionArr[region]);
		$(".category-text").text(categoryArr[category]);
		
		firstPicture.addClass("active");
		firstIndicator.addClass("active");
		
		$("#detailPopularity").click(function() {
			$("#popularityModal").modal("show");
		});
		
		$(".place-reply-form").on("submit", function() {
			var content = $("#replyContent").val();
			
 			if(userId == "") {
				alert("로그인해주세요.");
				return;
			}

			if(content == "") {
				alert("내용을 입력해주세요.");
				return;
			}
			
			if(checkReply) {
				alert("24시간 이내에 같은 장소의 정보를 다시 공유할 수 없습니다.");
				return;
			}
			
			var reply = {
				pno: pno,
				content: content,
				userId: userId,
				cp: cp
			};
			
			placeReplyService.add(reply, function(result) {
				alert(result ? "댓글이 등록되었습니다." : "댓글 등록을 실패했습니다.");
				placeReplyService.get(result, function(result) {
					replyUL.append(placeReplyService.getReplyDOM(result));
				});
			});
			
			$("#replyContent").val("");
 		});
				
		$("#replyMoreBtn").click(function() {
			var rno = $(".reply-content-wrapper li:first").data("rno")
			console.log(rno);
			showReplyList(rno);
		});
		
		$(document).ajaxSend(function(e, xhr) {
			xhr.setRequestHeader(csrf, csrfToken);
		});
		
		toggleMap();
		showReplyList();
	});
	
	function showMap() {
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 4
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder
				.addressSearch(
						'<c:out value="${place.address}" />',
						function(result, status) {

							// 정상적으로 검색이 완료됐으면 
							if (status === kakao.maps.services.Status.OK) {

								var coords = new kakao.maps.LatLng(result[0].y,
										result[0].x);

								// 결과값으로 받은 위치를 마커로 표시합니다
								var marker = new kakao.maps.Marker({
									map : map,
									position : coords
								});

								// 인포윈도우로 장소에 대한 설명을 표시합니다
								var infowindow = new kakao.maps.InfoWindow(
										{
											content : '<div style="width:150px;text-align:center;padding:6px 0;"><c:out value="${place.pname}" /></div>'
										});
								infowindow.open(map, marker);

								// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
								map.setCenter(coords);
							}
						});
	}

	function toggleMap() {
		var pic = $(".carousel");
		var map = $("#map");

		$(".location-btn").click(function() {
			pic.hide();
			map.show();
			showMap();
		});

		$(".place-title").click(function() {
			pic.show();
			map.hide();
		});

	}

	function showReplyList(rno) {
		placeReplyService.getList({
			pno: pno,
			rno: rno,
			cp: cp
		}, function(list) {
			// 댓글 목록 출력
			console.log(list);
						
			list = list.reverse();
			var str = "";

			for(var i in list) {
				str += placeReplyService.getReplyDOM(list[i]);
			}
			
			if(rno == "") {
				replyUL.html(str);
			} else {
				replyUL.html(str + replyUL.html());
			}
			deleteReply();
			showMyReply();
			init();
		});
	}
	
	function deleteReply() {
		$(".reply-delete-btn").click(function() {
			var rno = $(this).closest("li").data("rno");
			
			if(!confirm("정말로 삭제하시겠습니까?")) return;
			
			placeReplyService.delete({
				rno: rno,
				cp: cp
			}, function(result) {
				alert("댓글을 삭제했습니다.");
				
				$(".reply-content-li").each(function() {
					if($(this).data("rno") == rno) {
						$(this).remove();
					}
				});
			});
		});
	}
		
	function showMyReply() {
		$(".reply-content-wrapper li").each(function() {
			if(userId == $(this).data("userid")) {
				$(this).addClass("my-reply");
				$(this).mouseenter(function() {
					$(this).css("background", "rgba(222, 222, 222, 0.2)").css("transition", ".5s");
					$(this).find(".reply-delete-btn").show();
				});
				$(this).mouseleave(function() {
					$(this).css("background", "transparent").css("transition", ".5s");
					$(this).find(".reply-delete-btn").hide();
				});
			}
		});
	}
	
	function isRecent() {
		var flag;
		var url = "${pageContext.request.contextPath}/place/detail/" + pno;
		
		$.ajax({
			type: "get",
			url: url,
			async: false,
			success: function(result) {
				flag = result.getElementsByTagName('Boolean')[0].textContent;
			}
		});
		return flag;
	}
	
	/* 즐겨찾기에 추가 또는 제외 */
	$(".fav-btn-wrapper").on("click", "i", function() {
		var pno = $(this).data("pno");
		var favNum = $(this).next().text() * 1;
		
		if(userId == "") {
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
	
	<sec:authorize access="isAuthenticated()">
	placeService.getFavList({
		userId: userId,
		cp: cp
	}, function(result) {
		var favList = result;
		
		for(var i in favList) {
			if(pno == favList[i].pno) {
				$(".fav-btn").removeClass("far").addClass("fas");
			}
		}
	});
	</sec:authorize>
	
	function init() {
		$(".reply-like-btn").on("click", "i", function() {
			var rno = $(this).closest("li").data("rno");
			var likeNum = $(this).next().text() * 1;
			
			if(userId == "") {
				alert("로그인해주세요.");
				return;
			}
			
			if($(this).hasClass("far")) {
				/* 즐겨찾기 추가 */
				placeReplyService.likeReply({
					rno: rno,
					userId: userId,
					cp: cp
				}, function(result) {
					console.log(result)
				});
				
				$(this).next().text(likeNum+1);
			} else {
				/* 즐겨찾기 제외 */
				placeReplyService.unlikeReply({
					rno: rno,
					userId: userId,
					cp: cp
				}, function(result) {
					console.log(result)
				});
				
				$(this).next().text(likeNum-1);
			}
			$(this).toggleClass("far fas");
		});
		
		<sec:authorize access="isAuthenticated()">
		placeReplyService.getLikeList({
			pno: pno,
			userId: userId,
			cp: cp
		}, function(result) {
			var likeList = result;
			
			$(".reply-content-li").each(function() {
				for(var i in likeList) {
					if($(this).data("rno") == likeList[i]) {
						$(this).find("i").removeClass("far").addClass("fas");
					}
				}
			});
		});
		</sec:authorize>

	}
	
</script>
<jsp:include page="../includes/footer.jsp" />