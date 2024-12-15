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
var hasSentSystemMessage = false; // Biến cờ để kiểm tra tin nhắn hệ thống đã gửi hay chưa

// Kết nối WebSocket khi modal mở
function connect() {
    username = chatPage.dataset.username; // Lấy tên người dùng từ `data-username`
    if (!stompClient || !stompClient.connected) {
        if (username) {
            var socket = new SockJS('/ws');
            stompClient = Stomp.over(socket);

            stompClient.connect({}, onConnected, onError);
        } else {
            console.error("Username is required to connect!");
        }
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

    if (!hasSentSystemMessage) {
        // Gửi tin nhắn hệ thống chỉ một lần
        stompClient.send(
            "/app/chat.addUser",
            {},
            JSON.stringify({ sender: username, type: 'JOIN' })
        );
        hasSentSystemMessage = true; // Đánh dấu đã gửi tin nhắn hệ thống
    }

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

    var messageElement = document.createElement('li'); // Tạo phần tử tin nhắn

    // Xử lý tin nhắn loại JOIN
    if (message.type === 'JOIN') {
        messageElement.classList.add('event-message'); // Lớp riêng cho sự kiện JOIN
        messageElement.textContent = message.sender + ' Has Joined!';
    } 
    // Xử lý tin nhắn loại LEAVE
    else if (message.type === 'LEAVE') {
        messageElement.classList.add('event-message'); // Lớp riêng cho sự kiện LEAVE
        messageElement.textContent = message.sender + ' Has Left!';
    } 
    // Xử lý tin nhắn từ hệ thống
    else if (message.sender === 'System') {
        messageElement.classList.add('chat-message'); // Lớp chung cho tin nhắn
        messageElement.classList.add('system-message'); // Lớp bổ sung cho tin nhắn hệ thống

        // Tạo avatar giống như người dùng
        var avatarElement = document.createElement('i');
        avatarElement.textContent = 'S'; // Chữ cái đầu cho "System"
        avatarElement.classList.add('avatar');
        avatarElement.style.backgroundColor = '#ff5652'; // Màu cho avatar System

        var messageContent = document.createElement('div');
        messageContent.classList.add('message-content');

        var usernameElement = document.createElement('div');
        usernameElement.classList.add('username');
        usernameElement.textContent = 'CyberTech Zone'; // Tên hệ thống

        var textElement = document.createElement('div');
        textElement.classList.add('text-content');
        textElement.textContent = message.content;

        // Gắn các phần tử vào `messageContent`
        messageContent.appendChild(usernameElement);
        messageContent.appendChild(textElement);

        // Gắn avatar và nội dung vào `messageElement`
        messageElement.appendChild(avatarElement);
        messageElement.appendChild(messageContent);
    } 
    // Xử lý tin nhắn người dùng
    else {
        messageElement.classList.add('chat-message'); // Lớp chung cho tin nhắn

        var avatarElement = document.createElement('i');
        var avatarText = document.createTextNode(message.sender[0].toUpperCase());
        avatarElement.appendChild(avatarText);
        avatarElement.classList.add('avatar');
        avatarElement.style.backgroundColor = getAvatarColor(message.sender);

        var messageContent = document.createElement('div');
        messageContent.classList.add('message-content');

        var usernameElement = document.createElement('div');
        usernameElement.classList.add('username');
        usernameElement.textContent = message.sender.toUpperCase();

        var textElement = document.createElement('div');
        textElement.classList.add('text-content');
        textElement.textContent = message.content;

        // Gắn các phần tử vào `messageContent`
        messageContent.appendChild(usernameElement);
        messageContent.appendChild(textElement);

        // Gắn avatar và nội dung vào `messageElement`
        messageElement.appendChild(avatarElement);
        messageElement.appendChild(messageContent);
    }

    // Gắn tin nhắn vào khu vực hiển thị
    messageArea.appendChild(messageElement);
    messageArea.scrollTop = messageArea.scrollHeight; // Cuộn xuống cuối cùng
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
