'use strict';




var chatPage = document.querySelector('#chat-page');
var messageForm = document.querySelector('#messageForm');
var messageInput = document.querySelector('#message');
var messageArea = document.querySelector('#messageArea');
var connectingElement = document.querySelector('.connecting');

var stompClient = null;
var username = null;

var colors = [
    '#2196F3', '#32c787', '#00BCD4', '#ff5652',
    '#ffc107', '#ff85af', '#FF9800', '#39bbb0'
];

// Kết nối WebSocket khi modal mở
function connect() {
    username = chatPage.dataset.username; // Lấy tên người dùng từ `data-username`

    if (username) {
        var socket = new SockJS('/ws');
        stompClient = Stomp.over(socket);

        stompClient.connect({}, onConnected, onError);
    } else {
        console.error("Username is required to connect!");
    }
}

// Ngắt kết nối WebSocket khi modal đóng
function disconnect() {
    if (stompClient) {
        stompClient.disconnect();
        console.log("Disconnected");
    }
}

function onConnected() {
    // Subscribe to the Public Topic
    stompClient.subscribe('/topic/public', onMessageReceived);

    // Thông báo tham gia phòng
    stompClient.send(
        "/app/chat.addUser",
        {},
        JSON.stringify({ sender: username, type: 'JOIN' })
    );

    connectingElement.classList.add('hidden');
}

function onError(error) {
    connectingElement.textContent = 'Could not connect to WebSocket server. Please refresh this page to try again!';
    connectingElement.style.color = 'red';
}

function sendMessage(event) {
    event.preventDefault(); // Ngăn tải lại trang

    var messageContent = messageInput.value.trim();
    if (messageContent && stompClient && stompClient.connected) {
        var chatMessage = {
            sender: username,
            content: messageContent,
            type: 'CHAT'
        };
        stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(chatMessage));
        messageInput.value = ''; // Xóa nội dung tin nhắn sau khi gửi
    } else {
        console.error("WebSocket is not connected!");
    }
}


function onMessageReceived(payload) {
    var message = JSON.parse(payload.body);

    var messageElement = document.createElement('li');

    if (message.type === 'JOIN') {
        messageElement.classList.add('event-message');
        message.content = message.sender + ' Has Joined!';
    } else if (message.type === 'LEAVE') {
        messageElement.classList.add('event-message');
        message.content = message.sender + ' Has Left!';
    } else {
        messageElement.classList.add('chat-message');

        var avatarElement = document.createElement('i');
        var avatarText = document.createTextNode(message.sender[0].toUpperCase()); // Lấy ký tự đầu tiên
        avatarElement.appendChild(avatarText);
        avatarElement.style['background-color'] = getAvatarColor(message.sender);

        messageElement.appendChild(avatarElement);

        // Thêm tên người gửi
        var usernameElement = document.createElement('span');
        usernameElement.textContent = message.sender; // Chỉ hiển thị tên người gửi
        usernameElement.style.fontWeight = '600'; // Làm nổi bật tên người gửi
        usernameElement.style.marginRight = '10px';

        messageElement.appendChild(usernameElement);
    }

    // Chỉ hiển thị nội dung tin nhắn
    var textElement = document.createElement('p');
    textElement.textContent = message.content; // Nội dung tin nhắn
    textElement.style.margin = '0'; // Loại bỏ khoảng cách dư thừa

    messageElement.appendChild(textElement);
    messageArea.appendChild(messageElement);

    messageArea.scrollTop = messageArea.scrollHeight;
}


function getAvatarColor(messageSender) {
    var hash = 0;
    for (var i = 0; i < messageSender.length; i++) {
        hash = 31 * hash + messageSender.charCodeAt(i);
    }
    var index = Math.abs(hash % colors.length);
    return colors[index];
}

// Lắng nghe sự kiện khi mở và đóng modal
document.addEventListener('DOMContentLoaded', function () {
    var chatModal = document.getElementById('chatModal');

    chatModal.addEventListener('show.bs.modal', function () {
        var chatPage = document.querySelector('#chat-page');
        if (chatPage) {
            username = chatPage.dataset.username || "Anonymous"; // Gán giá trị mặc định nếu null
            console.log("Connecting to WebSocket...");
            if (!stompClient || !stompClient.connected) {
                connect();
            }
        } else {
            console.error("Chat page not found!");
        }
    });

    chatModal.addEventListener('hidden.bs.modal', function () {
        console.log("Disconnecting WebSocket...");
        disconnect();
    });
});



// Gửi tin nhắn
messageForm.addEventListener('submit', sendMessage, true);
