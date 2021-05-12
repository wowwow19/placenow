<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="includes/header.jsp" />
<!-- Masthead -->
<header class="masthead text-white text-center">
	<div class="container">
		<div class="row">
			<div class="header-text col-xl-9 mr-auto mb-5">
				<h1 class="region-text badge badge-light">회원가입</h1>
			</div>
		</div>
	</div>
</header>

<div class="register-wrapper">
	<div class="page-title">
		<div class="sub-title">
			<p>회원정보를</p>
			<p>입력해주세요</p>
		</div>
	</div>

	<div class="register-form-wrapper card shadow">
		<form class="register-form" method="POST" autocomplete="off">
			<ul>
				<li>
					<div class="input-email">
						<p class="input-condition">띄어쓰기 없이 영문/숫자가 포함된 정확한 이메일주소</p> 
						<input type="email" name="userId" placeholder="이메일주소(필수)" required>
						<p class="input-error type-error">사용불가능한 이메일주소입니다.</p>
						<p class="input-error duplicated-error">이미 존재하는 이메일주소입니다.</p>
						<p class="input-error need-verification-error">이메일 인증이 필요합니다.</p>
						<button type="button" class="btn verification-btn" id="sendBtn" disabled>인증</button>
						<button type="button" class="btn verification-btn" id="loadingBtn" disabled><span class="send-loading spinner-border spinner-border-sm"></span></button>
					</div>
					<div class="input-verification-number">
						<hr>
						<p class="input-condition">6자리의 숫자</p> 
						<input type="text" name="verificationNumber" placeholder="인증번호(필수)" required>
						<p class="input-error verification-error">인증번호가 일치하지 않습니다.</p>
					</div>
				</li>
				<li>
					<p class="input-condition">띄어쓰기 없이 영문/숫자/특수문자가 포함된 6-15자</p> <input
					type="password" name="userPw" value="" placeholder="비밀번호(필수)" required>
					<hr> 
					<input type="password" name="userPwCk" placeholder="비밀번호 재입력" required>
					<p class="input-error type-error">사용불가능한 비밀번호입니다.</p>
					<p class="input-error matching-error">비밀번호가 일치하지 않습니다.</p>
				</li>
				<li>
					<p class="input-condition">10자 이하의 문자</p>
					<input type="text" name="userName" placeholder="별명(필수)" required>
					<p class="input-error length-error">10자 이하로 입력해주세요.</p>
				</li>
				<li class="additional-info">
					<p class="input-title">생년월일(필수)</p>
					<div class="form-group" id="birthDateInput">
						<select class="form-control" name="birthYear" required>
							<c:forEach begin="1950" end="2021" step="1" var="i">
							<option value="${i}">${i}</option>
							</c:forEach>
							<option selected>년</option>
						</select>
						<select class="form-control">
							<option selected>월</option>
							<c:forEach begin="1" end="12" step="1" var="i">
							<option>${i}</option>
							</c:forEach>
						</select>
						<select class="form-control">
							<option selected>일</option>
							<c:forEach begin="1" end="31" step="1" var="i">
							<option>${i}</option>
							</c:forEach>
						</select>
					</div>
				</li>
				<li class="additional-info">
					<p class="input-title">성별(필수)</p>
					<div class="form-group" id="genderInput">
						<div class="form-check-inline">
						 	<label class="form-check-label">
								<input type="radio" class="form-check-input" name="gender" value="M">남성
							</label>
						</div>
						<div class="form-check-inline">
							<label class="form-check-label">
								<input type="radio" class="form-check-input" name="gender" value="F">여성
							</label>
						</div>
					</div>
				</li>
				<li class="additional-info">
					<p class="input-condition">숫자로만 입력</p>
					<input type="text" name="phone" placeholder="전화번호(선택)" >
				</li>
			</ul>
			<div class="check-newsletter">
				<label><input type="checkbox" name="newsletter" value="AGREE"> [선택] 이메일로 최신 소식을 받아보겠습니다.</label>
			</div>
			<div class="btm-btns register-btns float-right">
				<input type="hidden" name="use" value="${terms.use}">
				<input type="hidden" name="privacy" value="${terms.privacy}">
				<input type="hidden" name="location" value="${empty terms.location ? 'DISAGREE' : terms.location}">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				<a href="/" type="button" class="btn btn-outline-secondary mr-2">취소</a>
				<button class="btn btn-primary">완료</button>
			</div>
		</form>
	</div>
</div>
<script>
	var isIdProper = false;
	var isPwProper = false;
	var isNameProper = false;
	var verificationNumber = "";
	init();
	
	function init() {
		// input, select 공통 focus-in 효과
		$(".register-form li input, .register-form li select").focusin(function() {
			$(this).siblings(".input-condition").slideDown();
			$(this).closest("li").css("border", "1px solid #77f").css("transition", ".5s");
		});
		
		$(".additional-info *").focusout(function() {
			$(this).siblings(".input-condition").slideUp();
			$(this).closest("li").css("border", "1px solid #ccc").css("transition", ".5s");
		});
		
		// 아이디체크
		checkId();
		// 비밀번호체크
		checkPw();
		// 별명체크
		checkName();
		
		// 제출 전 모든 유효성 검증 체크
		$(".register-form").off().on("submit", function() {
			event.preventDefault();
	        event.stopPropagation();
	        			
	        // 모든 유효성 검증을 통과하면 제출 수행
			if(isIdProper && isPwProper && isNameProper) {
				alert("회원가입이 완료되었습니다.");
				$(".register-form")[0].submit();
				return;
			}
			
			alert("입력정보를 확인해주세요.");
		});
	}
	
	function checkId() {
		var regex = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
		
		// 이메일 입력 체크
		$("input[name='userId']").focusout(function() {
			isIdProper = false;
			$(this).siblings(".input-condition").slideUp();
			$(this).siblings(".input-error").slideUp();
			$("#sendBtn").attr("disabled", true);

			// 값이 비어있을 때
			if($(this).val() == "") {
				$(this).siblings(".input-error").slideUp();
				$(this).closest("li").css("border", "1px solid #ccc").css("transition", ".5s");
				return;
			}
			
			// 형식체크 오류
			if(!regex.test($(this).val())) {
				$(this).siblings(".type-error").slideDown();
				$(this).closest("li").css("border", "1px solid #f77").css("transition", ".5s");
				return;
			}
			$(this).siblings(".type-error").slideUp();
			
			// 중복체크 오류
			if(checkDuplicated()) {
				$(this).siblings(".duplicated-error").slideDown();
				$(this).closest("li").css("border", "1px solid #f77").css("transition", ".5s");
				return;
			}
			$(this).siblings(".duplicated-error").slideUp();
			$("#sendBtn").attr("disabled", false);
			$(this).siblings(".need-verification-error").slideDown();
			$(this).closest("li").css("border", "1px solid #f77").css("transition", ".5s");
		});
		
		// 인증번호 입력 체크
		$("input[name='verificationNumber']").focusout(function() {
			isIdProper = false;
			$(this).siblings(".input-condition").slideUp();
			$(this).siblings(".input-error").slideUp();
			
			// 전송된 인증번호와 입력된 값이 다를 때
			if(verificationNumber != $(this).val()) {
				$(".verification-error").slideDown();
				$(this).closest("li").css("border", "1px solid #f77").css("transition", ".5s");
				return;
			}
			
			// 모든 유효성 검증을 통과했을 때
			isIdProper = true;
			$(this).closest("li").css("border", "1px solid #2c2").css("transition", ".5s");
			$(".verification-error").slideUp();
		});
		
		// 인증번호 전송
		$("#sendBtn").off().click(function() {
			getVerificationNumber();
			setTimeout(function() {
				console.log(verificationNumber);
			}, 6000);
		});
		
		function checkDuplicated() {
			var flag;
			
			if($("input[name='userId']").val() != "") {
				var value = $("input[name='userId']").val() + "";
				var url = "${pageContext.request.contextPath}/getUser/" + value;
				
				$.ajax({
					type: "get",
					url: url,
					async: false,
					success: function(result) {
						if(result == "") {
							flag = false;
						} else {
							flag = true;
						}
					}
				});
			}
			return flag;
		}
		
		function getVerificationNumber() {
			var userId = $("input[name='userId']").val();
			
			$(".send-loading").show();
			$(".need-verification-error").slideUp();
			showLoader();
			// 인증번호 발송 로직
			setTimeout(function() {
				$.ajax({
					type: "get",
					url: "${pageContext.request.contextPath}/verify/" + userId,
					success: function(data) {
						verificationNumber = data;
					},
					complete: function() {
						$(".input-verification-number").slideDown();
						alert("인증번호를 발송했습니다.");
						hideLoader();
					}
				});
			}, 100);
		}
		
		function showLoader() {
			$("#loadingBtn").show();
			$("#sendBtn").hide();
		}
		
		function hideLoader() {
	        $("#loadingBtn").hide();
	        $("#sendBtn").show();
		}
	}
			
	function checkPw() {
	    var regex = /^.*(?=^.{6,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
		var pw = $("input[name='userPw']");
		var pwck = $("input[name='userPwCk']");
	    	    
		$("input[type='password']").focusout(function() {
			isPwProper = false;
			$(this).siblings(".input-condition").slideUp();
			$(this).siblings(".input-error").slideUp();
			
			// 값이 비어있을 때
			if(pw.val() == "") {
				$(this).siblings(".input-error").slideUp();
				$(this).closest("li").css("border", "1px solid #ccc").css("transition", ".5s");
				return;
			}
			
			// 형식체크 오류
			if(!regex.test(pw.val())) {
				$(this).siblings(".type-error").slideDown();
				$(this).closest("li").css("border", "1px solid #f77").css("transition", ".5s");
				return;
			} 
			$(this).siblings(".type-error").slideUp();
			
			// 일치체크 오류
			if(!checkMatching()) {
				$(this).siblings(".matching-error").slideDown();
				$(this).closest("li").css("border", "1px solid #f77").css("transition", ".5s");
				return;
			}
			
			// 모든 유효성 검증을 통과했을 때
			isPwProper = true;
			$(this).siblings(".matching-error").slideUp();
			$(this).closest("li").css("border", "1px solid #2c2").css("transition", ".5s");
		});
		
		function checkMatching() {			
			if(pw.val() === pwck.val()) {
				return true;
			} else {
				return false;
			}
		}
	}
	
	function checkName() {
		$("input[name='userName']").focusout(function() {
			isNameProper = false;
			$(this).siblings(".input-condition").slideUp();
			$(this).siblings(".input-error").slideUp();
			
			// 값이 비어있을 때
			if($(this).val() == "") {
				$(this).closest("li").css("border", "1px solid #ccc").css("transition", ".5s");
				return;
			}
			
			// 입력값의 길이 오류
			if($(this).val().length > 10) {
				$(this).siblings(".length-error").slideDown();
				$(this).closest("li").css("border", "1px solid #f77").css("transition", ".5s");
				return;
			} 
			
			// 모든 유효성 검증을 통과했을 때
			isNameProper = true;
			$(this).siblings(".input-error").slideUp();
			$(this).closest("li").css("border", "1px solid #2c2").css("transition", ".5s");
		});
	}
</script>
<jsp:include page="includes/footer.jsp" />