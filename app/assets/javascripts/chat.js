$(function () {
	var url = getCookie("socket_url");
//
//	console.log(url)

//	document.getElementById("send").addEventListener("click", send);
//	document.getElementById("broadcast").addEventListener("click", broadcast);
//	document.getElementById("logout").addEventListener("click", logout);

	var socket = new WebSocket(url);
	console.log(socket)
//	socket.keep_alive = 0;
	console.log(socket)
	

	socket.onopen = function () {
		console.log("Connection is established");
		send_message({});
	};

	socket.onclose = function (event) {
		if (event.wasClean) {
			console.log("Socket closed");
		} else {
			console.log("Socket was closed due to error", event);
		}
	};

	socket.onerror = function (event) {
		console.log(event)
	};

	socket.onmessage = function (event) {
		var data = JSON.parse(event.data);
		console.log(data);
		
//		if (!data.auth) {
//			console.log("Authorization incorrect");
////			window.location.href = "/";
//		}
		
		if (data.users) {
			update_userlist(data.users);
		}
		
		if (data.message) {
			add_message(data.message.author, data.message.text);
		}

	};

	$('#send').click(function () {
		var text = $("#text").val();
		var recepients = $("#recepients li").map(function(){
               return $(this).text();
            }).get();

		send_message({
			recepients: recepients,
			text: text
		});
	});

//	function send() {
//		console.log('send')
//		return false;
//		var message = document.getElementById("outcomming-message").value;
//		var messagearray = message.split(":");
//		var answer = {};
//		answer["login"] = messagearray[0];
//		answer["message"] = messagearray[1];
//		socket.send(JSON.stringify(answer));
//	}
//
//	function broadcast() {
//		var message = document.getElementById("outcomming-message").value;
//		var anwser = {};
//		anwser["broadcast"] = message;
//		socket.send(JSON.stringify(anwser));
//	}
//
//	function logout() {
//		var anwser = {};
//		anwser["logout"] = "";
//		socket.send(JSON.stringify(anwser));
//	}

	function getCookie(name) {
		var matches = document.cookie.match(new RegExp("(?:^|; )" + name.replace(/([\.$?{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"));
		return matches ? decodeURIComponent(matches[1]) : undefined;
	}
	
	function update_userlist(users) {
		var ul_tag = document.createElement("ul");
		var li_tag;
		
		for (var i = 0; i < users.length; i++) {
			li_tag = document.createElement("li");
			li_tag.innerText = users[i].name;
			li_tag.setAttribute('class', users[i].status);
			li_tag.addEventListener("click", addUser);
			ul_tag.appendChild(li_tag);
		}
		
		$('#active-users').html(ul_tag);
	}

	function add_message(author, text) {
		var li_tag = document.createElement("li");
		var user = document.createElement("b");
		user.innerText = author;
		user.addEventListener("click", addUser);
		var mess = document.createElement("span");
		mess.innerText = ': ' + text;
		li_tag.appendChild(user);
		li_tag.appendChild(mess);
		
		$('#messages ul').append(li_tag);
		$("#messages").scrollTop($("#messages li").length * 100);
	}
	
	function send_message(message) {
		var session_id = getCookie("_g76tge2j0");
		message['session_id'] = session_id;

		console.log('send:' + JSON.stringify(message))		
		socket.send(JSON.stringify(message));
	}

	function addUser(event) {
		var user = document.createElement("li");
		user.addEventListener("click", delUser);
		user.innerText = event.currentTarget.innerText;
		
		$('#recepients').append(user)
	}
	
	function delUser(event) {
		event.target.remove()
	}
})