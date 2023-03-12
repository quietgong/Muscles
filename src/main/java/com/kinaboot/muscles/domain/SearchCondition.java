package com.kinaboot.muscles.domain;

import org.springframework.web.util.UriComponentsBuilder;

public class SearchCondition {
    private static final int MIN_PAGE = 1;
    private static final int MAX_PAGE = 50;
    private static final int DEFAULT_PAGE_SIZE = 10;
    private Integer page = 1;

    public Integer getOffset() {
        return (page - 1) * 10;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    private String option = "";
    private String keyword = "";
    private String type = "";

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    SearchCondition() {
    }
    public SearchCondition(Integer page) {
        this(page, "", "");
    }
    public SearchCondition(Integer page, String option, String keyword) {
        this.page=page;
        this.option = option;
        this.keyword = keyword;
    }

    public String getOption() {
        return option;
    }

    public void setOption(String option) {
        this.option = option;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getQueryString() {
        return getQueryString(this.page);
    }

    public String getQueryString(int page) {
        //list?page=1&option=A&keyword=test
        return UriComponentsBuilder.newInstance()
                .queryParam("page", page)
                .queryParam("option", option)
                .queryParam("keyword", keyword)
                .build().toString();
    }

    @Override
    public String toString() {
        return "SearchCondition{" +
                "page=" + page +
                ", option='" + option + '\'' +
                ", keyword='" + keyword + '\'' +
                '}';
    }
}
