package com.kinaboot.muscles.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties
public class DeliveryDto {
    private Integer deliveryNo;
    private Integer orderNo;
    private String receiver;
    private String phone;
    private String address1;
    private String address2;
    private String message;
}
