package com.kinaboot.muscles.domain;

import lombok.Data;

@Data
public class ImgDto {
    private Integer imgNo;
    private Integer no;
    private String uploadPath;
    private String uploadName;

    public ImgDto(Integer no, String uploadPath, String uploadName) {
        this.no = no;
        this.uploadPath = uploadPath;
        this.uploadName = uploadName;
    }
}
