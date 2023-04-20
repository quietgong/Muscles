package com.kinaboot.muscles.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

@Data
public class PostDto {
    private Integer postNo;
    private String type;
    private String title;
    private String content;
    private String userId;
    private Integer viewCnt;
    private List<CommentDto> commentDtoList;
    private List<PostImgDto> postImgDtoList;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date createdDate;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date modDate;
}
