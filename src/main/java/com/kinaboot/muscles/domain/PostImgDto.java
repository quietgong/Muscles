package com.kinaboot.muscles.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PostImgDto {
    private Integer postImgNo;
    private Integer postNo;
    private String uploadPath;
    private String fileName;
    private String type;
}
