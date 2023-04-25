package com.kinaboot.muscles.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties
public class CouponDto {
    int couponNo;
    int discount;
    int orderNo;
    String couponName;
    String couponCode;
    String userId;
}
