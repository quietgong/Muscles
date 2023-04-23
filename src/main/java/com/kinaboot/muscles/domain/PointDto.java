package com.kinaboot.muscles.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PointDto {
    String userId;
    int pointNo;
    int orderNo;
    int point;
}
