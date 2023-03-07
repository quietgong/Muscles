package com.kinaboot.muscles.domain;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.List;

public class JsonToObjectTest {
    public static List<CartDto> JsonToJava(String rowData) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.readValue(rowData, new TypeReference<List<CartDto>>() {});
    }

    public static void main(String[] args) throws JsonProcessingException {
        String rowData = "[{\"productNo\":1,\"productQty\":10},{\"productNo\":3,\"productQty\":30},{\"productNo\":4,\"productQty\":40}]";
        List<CartDto> cartDtoList = JsonToJava(rowData);
        // 출력
        System.out.println("cartDtoList = " + cartDtoList);
        // cartDtoList = [CartDto{cartNo=0, userId='null', productName='null', productNo=1, productPrice=0, productQty=10}, CartDto{cartNo=0, userId='null', productName='null', productNo=3, productPrice=0, productQty=30}, CartDto{cartNo=0, userId='null', productName='null', productNo=4, productPrice=0, productQty=40}]
    }
}
