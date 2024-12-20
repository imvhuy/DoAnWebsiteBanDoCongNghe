package com.javaweb.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@Data
public abstract class BaseDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Date createdDate;

    private String createdBy;

    private Date modifiedDate;

    private String modifiedBy;
}
