package com.kinaboot.muscles.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties
public class PointDto {
    String userId;
    Integer pointNo;
    Integer orderNo;
    Integer point;
}
