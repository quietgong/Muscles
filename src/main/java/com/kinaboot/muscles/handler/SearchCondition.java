package com.kinaboot.muscles.handler;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.Date;
@Data
@NoArgsConstructor
public class SearchCondition {
    private static final int MIN_PAGE = 1;
    private static final int MAX_PAGE = 50;
    private static final int DEFAULT_PAGE_SIZE = 10;
    private Integer page = 1;
    private String option = "";
    private Integer offset = 0;
    private String keyword = "";
    private String type = "";
    private String category = "";
    private String subCategory = "";
    private String userId = "";
    private String period = "";
    private String status = "";
    private String minPrice = "";
    private String maxPrice = "";
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date startDate;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date endDate;

    public String getQueryString() {
        return getQueryString(this.page);
    }

    public String getQueryString(int page) {
        return UriComponentsBuilder.newInstance()
                .queryParam("page", page)
                .queryParam("keyword", keyword)
                .queryParam("option", option)
                .build().toString();
    }
    public SearchCondition(Integer page) {
        this(page, "", "");
    }

    public SearchCondition(int page, String keyword) {
        this.page = page;
        this.keyword = keyword;
    }

    public SearchCondition(Integer page, String option, String keyword) {
        this.page=page;
        this.option = option;
        this.keyword = keyword;
    }

    public SearchCondition(Date startDate, Date endDate) {
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public Integer getOffset() {
        return (page-1)*10;
    }
}
