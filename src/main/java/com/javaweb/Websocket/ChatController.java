package com.javaweb.Websocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;

@Controller
public class ChatController {

    private final SimpMessageSendingOperations messagingTemplate;

    @Autowired
    public ChatController(SimpMessageSendingOperations messagingTemplate) {
        this.messagingTemplate = messagingTemplate;
    }

    @MessageMapping("/chat.sendMessage")
    @SendTo("/topic/public")
    public ChatMessage sendMessage(@Payload ChatMessage chatMessage) {
        return chatMessage;
    }

    @MessageMapping("/chat.addUser")
    @SendTo("/topic/public")
    public ChatMessage addUser(@Payload ChatMessage chatMessage, SimpMessageHeaderAccessor headerAccessor) {
        // Add username in WebSocket session
        headerAccessor.getSessionAttributes().put("username", chatMessage.getSender());
        
     // Nếu username không phải là "VENDOR", gửi tin nhắn hệ thống
        if (!"VENDOR".equalsIgnoreCase(chatMessage.getSender())) {
            sendWelcomeMessage(chatMessage.getSender());
        }
        return chatMessage;
    }

    
    
    // Phương thức gửi tin nhắn tự động từ server
    private void sendWelcomeMessage(String username) {
        ChatMessage systemMessage = ChatMessage.builder()
                .sender("System")
                .content("Xin chào quý khách Tư vấn viên sẽ liên hệ với bạn sớm nhất có thể Kết nối với Zalo THTVS tại https://bit.ly/Zalo_CPS để được tư vấn và phục vụ nhanh chóng!")
                .type(MessageType.CHAT)
                .build();

        messagingTemplate.convertAndSend("/topic/public", systemMessage);
    }
}
