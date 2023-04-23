package com.kinaboot.muscles.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CouponDto {
    int couponNo;
    int discount;
    int orderNo;
    String couponName;
    String couponCode;
    String userId;
}
