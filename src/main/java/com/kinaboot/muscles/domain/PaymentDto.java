package com.kinaboot.muscles.domain;

import lombok.Data;

@Data
public class PaymentDto {
    private int paymentNo;
    private int orderNo;
    private int price;
    private String type;
}
