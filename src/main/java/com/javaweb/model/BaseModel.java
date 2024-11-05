package com.javaweb.model;

import jakarta.persistence.Column;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;

import java.io.Serializable;
import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@Data
public abstract class BaseModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private Date createdDate;

    private String createdBy;

    private Date modifiedDate;

    private String modifiedBy;
}
