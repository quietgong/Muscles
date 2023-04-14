package com.kinaboot.muscles.handler;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.Date;

public class SearchCondition {
    private static final int MIN_PAGE = 1;
    private static final int MAX_PAGE = 50;
    private static final int DEFAULT_PAGE_SIZE = 10;
    private Integer page = 1;
    private String option = "";
    private String keyword = "";
    private String type = "";
    private String category = "";
    private String subCategory = "";
    private String userId = "";
    private String period = "";
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
    public SearchCondition() {
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

    public String getSubCategory() {
        return subCategory;
    }

    public void setSubCategory(String subCategory) {
        this.subCategory = subCategory;
    }

    public String getPeriod() {
        return period;
    }

    public void setPeriod(String period) {
        this.period = period;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Date getStartDate() {
        return startDate;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(String minPrice) {
        this.minPrice = minPrice;
    }

    public String getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(String maxPrice) {
        this.maxPrice = maxPrice;
    }

    public Integer getOffset() {
        return (page - 1) * 10;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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

    @Override
    public String toString() {
        return "SearchCondition{" +
                "page=" + page +
                ", option='" + option + '\'' +
                ", keyword='" + keyword + '\'' +
                ", type='" + type + '\'' +
                ", category='" + category + '\'' +
                ", subCategory='" + subCategory + '\'' +
                ", userId='" + userId + '\'' +
                ", period='" + period + '\'' +
                ", minPrice='" + minPrice + '\'' +
                ", maxPrice='" + maxPrice + '\'' +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                '}';
    }
}
