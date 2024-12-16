package com.javaweb.dto;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class LoginDTO {
    private String username;
    private String password;
}
