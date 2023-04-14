package com.kinaboot.muscles.domain;

public class GoodsCategoryDto {
    private String category;
    private String subCategory;

    public GoodsCategoryDto() {
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getSubCategory() {
        return subCategory;
    }

    public void setSubCategory(String subCategory) {
        this.subCategory = subCategory;
    }

    @Override
    public String toString() {
        return "goodsCategoryDto{" +
                "category='" + category + '\'' +
                ", subCategory='" + subCategory + '\'' +
                '}';
    }
}
