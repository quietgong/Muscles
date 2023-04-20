package com.kinaboot.muscles.domain;

import lombok.Data;

@Data
public class PostImgDto {
    private Integer postImgNo;
    private Integer postNo;
    private String uploadPath;
    private String uploadName;
    private String type;
}
