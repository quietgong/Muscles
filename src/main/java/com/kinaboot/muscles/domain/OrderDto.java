package com.kinaboot.muscles.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class OrderDto {
    private List<OrderItemDto> orderItemDtoList;
    private DeliveryDto deliveryDto;
    private PaymentDto paymentDto;
    private int orderNo;
    private int discount;
    private String userId;
    private String cancelReason;
    private String status;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date createdDate;
}
