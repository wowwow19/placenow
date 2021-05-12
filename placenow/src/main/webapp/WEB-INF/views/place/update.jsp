<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../includes/header.jsp" />
	<!-- Masthead -->
	<header class="masthead text-white text-center">
		<div class="container">
			<div class="row">
				<div class="header-text col-xl-9 mr-auto mb-5">
		        	<h1 class="badge badge-light">장소수정</h1>
		    	</div>
			</div>
		</div>
	</header>
	
	<div class="place-add-wrapper">
		<form class="place-add-form needs-validated card shadow" method="post" >
			<div class="row input-region-category">
				  <div class="form-group input-region">
				    <select class="form-control" name="region" required>
				      <option value="">지역선택</option>
				      <option value="1">서울/인천</option>
				      <option value="2">경기</option>
				      <option value="3">강원</option>
				      <option value="4">대전/충청</option>
				      <option value="5">광주/전라</option>
				      <option value="6">대구/경북</option>
				      <option value="7">부산/경남</option>
				      <option value="8">제주</option>
				    </select>
				  </div>
				  <div class="form-group input-category">
				    <select class="form-control" name="category" required>
				      <option value="">구분선택</option>
				      <option value="1">여행지</option>
				      <option value="2">액티비티</option>
				      <option value="3">카페</option>
				      <option value="4">맛집</option>
				    </select>
				  </div>
			</div>
			<div class="row input-pname mb-3">
				<input type="text" name="pname" class="form-control" id="pname" placeholder="장소명" value="${place.pname}" required>
			</div>
			<div class="row input-address input-group mb-3">
			  <input type="text" name="address" class="form-control" id="sample4_roadAddress" placeholder="주소" value="${place.address}" required>
			  <div class="input-group-append">
			    <button class="btn btn-secondary" type="button" onclick="sample4_execDaumPostcode()">검색</button>
			  </div>
			</div>
			<div class="row input-files">
				<div class="row upload-input">
					<input id="files" type="file" name="files" accept="image/jpg, image/jpeg, image/png, image/gif" multiple>
				</div>
				<div class="row upload-result mt-3">
					<ul class="list-group">
					</ul>
				</div>
				<p class="mt-1">사진파일(jpg, jpeg, png, gif)만 업로드 가능합니다</p>
			</div>
			<div class="row add-form-btns mt-3">
				<button type="submit" class="btn btn-primary mr-2" data-oper="modify">등록</button>
				<button type="button" class="btn btn-outline-secondary" onclick="javascript:history.back();">취소</button>
			</div>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		</form>
	</div>
	
   	<!-- Image Modal-->
	<div class="modal fade" id="imgModal">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-body text-center"><img class="mw-100"></div>
			</div>
		</div>
	</div>
	
	
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample4_roadAddress").value = roadAddr;
                
            }
        }).open();
    }
</script>
<script>
	var cp = "${pageContext.request.contextPath}";
	var pno = '<c:out value="${place.pno}"/>';
	// 최대 파일 크기
	var maxSize = 1024 * 1024 * 5;
	var cloneObj = $(".upload-input").clone();
	var uploadResult = $(".upload-result ul");
	var csrf = "${_csrf.headerName}";
	var csrfToken = "${_csrf.token}";

	$(document).ajaxSend(function(e, xhr) {
		xhr.setRequestHeader(csrf, csrfToken);
	});

	$(function() {
		
		$.getJSON("${pageContext.request.contextPath}/place/getAttachList", {
			pno: pno
			}, 
			function(uploadResultArr) {
			var str = "";
			for(var i in uploadResultArr) {
				var obj = uploadResultArr[i];
				str += "<li class='list-group-item'";
				str += " data-filename='" + obj.fileName;
				str += "' data-image='" + obj.image;
				str += "' data-uuid='" + obj.uuid;
				str += "' data-uploadpath='" + obj.uploadPath;
				str += "'>";
				if(!obj.image) {
					str += "	<a href='${pageContext.request.contextPath}/download?fileName=" + obj.downloadPath + "'><i class='fas fa-paperclip text-muted'></i> " + obj.fileName + "</a>";
				} else {
					str += "	<a href='javascript:showImage(\"" + obj.downloadPath + "\")'>";
					str += "		<img src='${pageContext.request.contextPath}/display?fileName=" + obj.thumbnailPath + "'>";
					str += "	</a>";
				}
				str += "	<i class='fas fa-times-circle remove-file-btn'></i>";
				str += "</li>";
			}
			uploadResult.append(str);
		});

		
		$(".upload-input").on("change", "#files", function() {
			var formData = new FormData();
			var files = $("#files")[0].files;
			console.log(files);
			
			for(var i in files) {
				if(!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				formData.append("files", files[i]);
			}
			
			$.ajax({
				url: '${pageContext.request.contextPath}/uploadAction',
				type: 'post',
				data: formData,
				dataType: 'json',
				processData: false,
				contentType: false,
				success: function(result) {
					console.log(result);
					showUploadedFile(result);
					$(".upload-input").html(cloneObj.html());
				}
			});
		});
		
		function checkExtension(name, size) {
			if(size > maxSize) {
				alert("최대 업로드 크기를 초과했습니다");
				return false;
			}
			return true;
		}
		
		function showUploadedFile(uploadResultArr) {
			var str = "";
			for(var i in uploadResultArr) {
				var obj = uploadResultArr[i];
				str += "<li class='list-group-item'";
				str += " data-filename='" + obj.fileName;
				str += "' data-image='" + obj.image;
				str += "' data-uuid='" + obj.uuid;
				str += "' data-uploadpath='" + obj.uploadPath;
				str += "'>";
				if(!obj.image) {
					str += "	<a href='${pageContext.request.contextPath}/download?fileName=" + obj.downloadPath + "'><i class='fas fa-paperclip text-muted'></i> " + obj.fileName + "</a>";
				} else {
					str += "	<a href='javascript:showImage(\"" + obj.downloadPath + "\")'>";
					str += "		<img src='${pageContext.request.contextPath}/display?fileName=" + obj.thumbnailPath + "'>";
					str += "	</a>";
				}
				str += "	<i class='fas fa-times-circle remove-file-btn'></i>";
				str += "</li>";
			}
			uploadResult.append(str);
		}

		
		function showImage(path) {
			$("#imgModal img").attr("src", "${pageContext.request.contextPath}/display?fileName=" + path);
			$("#imgModal").modal("show");
		}
		
		$(".upload-result").on("click", ".remove-file-btn", function() {
			var $li = $(this).closest("li");
			var data = {
				fileName: $li.data("filename"),
				image: $li.data("image"),
				uuid: $li.data("uuid"),
				uploadPath: $li.data("uploadpath")
			};
			console.log(data);
			
			$.ajax({
				url: "${pageContext.request.contextPath}/deleteFile",
				type: "post",
				data: JSON.stringify(data),
				contentType: "application/json; charset=utf-8",
				success: function(result) {
					alert(result);
					$li.remove();
				}
			});
			
			$li.remove();
		});
		
		$("button[type='submit']").on("click", function() {
			if($(this).data("oper") != "modify") return;

			event.preventDefault();
			var str = "";
			var attrs = ["fileName", "uuid", "uploadPath", "image"];
			
			$(".upload-result li").each(function(i, it) {
			    for(var j in attrs) {
					str += '<input type="hidden" name="attachList[' + i + '].' + attrs[j];
					str += '" value="' + $(it).data(attrs[j].toLowerCase()) + '">';
			    }
			});
			
			console.log(str);
			$(this).closest("form").append(str).submit();
		});

	});
	
	$(".input-region option").each(function() {
		var region = '<c:out value="${place.region}" />';
		if($(this).val() == region) {
			$(this).attr("selected", true);
		}
	});
	
	$(".input-category option").each(function() {
		var category = '<c:out value="${place.category}" />';
		if($(this).val() == category) {
			$(this).attr("selected", true);
		}
	});
</script>
<jsp:include page="../includes/footer.jsp" />