package com.kinaboot.muscles.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class PaymentDto {
    private int paymentNo;
    private int orderNo;
    private int price;
    private String type;
}
