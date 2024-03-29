package com.kinaboot.muscles.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties
public class OrderDto {
    private Integer orderNo;
    private Integer discount;
    private String userId;
    private String cancelReason;
    private String status;
    private List<OrderItemDto> orderItemDtoList;
    private DeliveryDto deliveryDto;
    private PaymentDto paymentDto;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date createdDate;
}
