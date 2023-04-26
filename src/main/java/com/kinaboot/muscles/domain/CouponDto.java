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
    Integer couponNo;
    Integer discount;
    Integer orderNo;
    String couponName;
    String couponCode;
    String userId;
}
