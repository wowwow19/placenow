/**
*	place module
*/

var placeService = (function() {
	return {
		getMore: function(param, callback, error) {
			var region = param.region != 0 ? param.region : "";
			var category = param.category != 0 ? param.category : "";
			var keyword = param.keyword != "" ? param.keyword : "";
			var pno = param.pno;
			var url = param.cp + "/place/more?pno=" + pno + "&region=" + region + "&category=" + category + "&keyword=" + keyword;
			
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
		delete: function(pno, callback, error) {
			var url = "/place/delete?pno=" + pno;
			
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
		addFavList: function(param, callback, error) {
			var url = param.cp + "/place/" + param.pno + "/" + param.userId;
			
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
		removeFavList: function(param, callback, error) {
			var url = param.cp + "/place/" + param.pno + "/" + param.userId;
			
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
		getFavList: function(param, callback, error) {
			var url = param.cp + "/place/" + param.userId;
			
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