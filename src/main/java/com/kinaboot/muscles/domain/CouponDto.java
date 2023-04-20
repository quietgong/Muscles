package com.kinaboot.muscles.domain;

import lombok.Data;

@Data
public class CouponDto {
    int couponNo;
    int discount;
    int orderNo;
    String couponName;
    String couponCode;
    String userId;
}
