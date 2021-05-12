/**
 * place-reply module
 */

console.log("reply module...");

var placeReplyService = (function() {
	return {
		add: function(reply, callback, error) {
			console.log("reply.add...");
			
			$.ajax({
				type: "post",
				url: reply.cp + "/place/replies/add",
				data: JSON.stringify(reply),
				// 송신할 때의 데이터 타입
				contentType: "application/json; charset=utf-8",
				success: function(result, status, xhr) {
					if(callback) {
						callback(result);
					}
				},
				error: function(xhr, status, er) {
					if(error) {
						error(er);
					}
				},
				complete: function() {
					alert("댓글 등록이 완료되었습니다.");
				}
			});			
		},
		getList: function(param, callback, error) {
			var pno = param.pno;
			var rnoStr = param.rno ? "/" + param.rno : "";
			var url = param.cp + "/place/replies/list/" + pno + rnoStr;
			console.log(url);
						
			$.getJSON(url, function(result) {
				if(callback) {
					callback(result);
				}
			}).fail(function(xhr, status, er) {
				if(error) {
					error(er);
				}
			});
			
		},
		delete: function(param, callback, error) {
			var url = param.cp + "/place/replies/" + param.rno;
			
			$.ajax({
				type: "delete",
				url: url,
				success: function(result) {
					if(callback) {
						callback(result);
					}
				},
				error: function(xhr, status, er) {
					if(error) {
						error(er);
					}
				}
			});
		},
		get: function(rno, callback, error) {
			var url = "/place/replies/" + rno;
			
			$.getJSON(url, function(result) {
				if(callback) {
					callback(result);
				}
			}).fail(function(xhr, status, er) {
				if(error) {
					error(er);
				}
			});
		},
		displayTime: function(timeValue) {
			return moment(timeValue).fromNow();
		},
		getReplyDOM: function(param) {
			var str = "";
			
			str += '<li class="reply-content-li" data-rno="' + param.rno + '" data-userid="' + param.userId + '">';
			str += '		<div class="reply-left">';
			str += '			<div class="reply-content">';
			str += '				<span>' + param.content + '</span>';
			str += '				<span>' + param.regDate + '</span>';
			str += '				<span class="reply-like-btn"><i class="far fa-thumbs-up" id="like-btn"></i><span class="like-num">' + param.likeNum + '</span></span>';
			str += '			</div>';
			str += '		</div>';
			str += '		<button class="reply-delete-btn" id="replyDeleteBtn">삭제</button>';
			str += '</li>';
			
			return str;
		},
		likeReply: function(param, callback, error) {
			var url = param.cp + "/place/replies/" + param.rno + "/" + param.userId;
			
			$.ajax({
				type: "post",
				url: url,
				success: function(result) {
					if(callback) {
						callback(result);
					}
				},
				error: function(xhr, status, er) {
					if(error) {
						error(er);
					}
				}
			});
		},
		unlikeReply: function(param, callback, error) {
			var url = param.cp + "/place/replies/" + param.rno + "/" + param.userId;
			
			$.ajax({
				type: "delete",
				url: url,
				success: function(result) {
					if(callback) {
						callback(result);
					}
				},
				error: function(xhr, status, er) {
					if(error) {
						error(er);
					}
				}
			});
		},
		getLikeList: function(param, callback, error) {
			var url = param.cp + "/place/replies/" + param.pno + "/" + param.userId;
			
			$.getJSON(url, function(result) {
				if(callback) {
					callback(result);
				}
			}).fail(function(xhr, status, er) {
				if(error) {
					error(er);
				}
			});
		},
		getRegDate: function(param, callback, error) {
			var url = "/place/replies/getRegDate/" + param.pno + "/" + param.userId;
			
			$.getJSON(url, function(result) {
				if(callback) {
					callback(result);
				}
			}).fail(function(xhr, status, er) {
				if(error) {
					error(er);
				}
			});
		}
	};
})();