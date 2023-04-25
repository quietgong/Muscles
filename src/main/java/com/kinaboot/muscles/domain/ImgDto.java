package com.kinaboot.muscles.domain;

import lombok.Data;

@Data
public class ImgDto {
    private Integer imgNo;
    private Integer no;
    private String uploadPath;
    private String fileName;

    public ImgDto(Integer no, String uploadPath, String fileName) {
        this.no = no;
        this.uploadPath = uploadPath;
        this.fileName = fileName;
    }
}
