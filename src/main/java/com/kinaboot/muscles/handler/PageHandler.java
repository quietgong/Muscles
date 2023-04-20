package com.kinaboot.muscles.handler;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PageHandler {
    private SearchCondition sc;
    int totalPage;
    int totalCnt;
    int page;
    int navSize = 10;
    int pageSize = 10;
    boolean showPrev;
    boolean showNext;
    int beginPage; // nav 첫 페이지
    int endPage; // nav 끝 페이지

    public PageHandler(int totalCnt, SearchCondition sc) {
        this.totalCnt = totalCnt;
        this.sc = sc;
        doPaging(totalCnt, sc);
    }

    void doPaging(int totalCnt, SearchCondition sc) {
        this.totalCnt = totalCnt;
        this.page=sc.getPage();
        totalPage = (int) Math.ceil((double) totalCnt / this.getPageSize());
        beginPage = sc.getPage() / (navSize + 1) * navSize + 1;
        endPage = Math.min(beginPage + this.getPageSize() - 1, totalPage);
        showPrev = beginPage != 1;
        showNext = endPage != totalPage;
    }
    void print() {
        System.out.println("page = " + page);
        if (showPrev)
            System.out.print("< ");
        for (int i = beginPage; i <= endPage; i++) {
            System.out.print(i + " ");
        }
        if (showNext)
            System.out.println(">");
    }
}
