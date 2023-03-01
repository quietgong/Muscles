package com.kinaboot.muscles.dao;

import java.util.HashMap;
import java.util.Map;

public class leaveTest {
    public static void main(String[] args) {
        String userId = "test1";
        int[] typeValue = new int[]{0,0,0};
        String[] type = {"1", "3"};
        String opinion = "opiniontest";

        for(String s : type)
            typeValue[Integer.parseInt(s)-1]++;
        Map map = new HashMap();
        map.put("userId", userId);
        map.put("type1", String.valueOf(typeValue[0]));
        map.put("type2", String.valueOf(typeValue[1]));
        map.put("type3", String.valueOf(typeValue[2]));
        map.put("opinion", opinion);

        for(Object key : map.keySet()) {
            String value = (String) map.get(key);
            System.out.println(key + " : " + value);
        }
    }
}
