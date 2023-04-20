package com.kinaboot.muscles.domain;

import lombok.Data;

@Data
public class DeliveryDto {
    private int deliveryNo;
    private int orderNo;
    private String receiver;
    private String phone;
    private String address1;
    private String address2;
    private String message;
}
