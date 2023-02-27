package com.kinaboot.muscles.domain;

public class PageHandler {
    int totalPage;
    int totalCnt;
    int page;
    int navSize = 10;
    int pageSize = 10;
    boolean showPrev;
    boolean showNext;
    int beginPage; // nav 첫 페이지
    int endPage; // nav 끝 페이지

    public PageHandler() {
    }

    public PageHandler(int totalCnt, int page) {
        this.totalCnt = totalCnt;
        this.page = page;

        doPaging(totalCnt, page);
    }

    public PageHandler(int totalCnt) {
        this.totalCnt=totalCnt;
    }

    void doPaging(int totalCnt, int page) {
        this.totalCnt = totalCnt;
        this.page=page;
        totalPage = (int) Math.ceil((double) totalCnt / this.getPageSize());
        beginPage = this.getPage() / (navSize + 1) * navSize + 1;
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

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getTotalCnt() {
        return totalCnt;
    }

    public void setTotalCnt(int totalCnt) {
        this.totalCnt = totalCnt;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getNavSize() {
        return navSize;
    }

    public void setNavSize(int navSize) {
        this.navSize = navSize;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public boolean isShowPrev() {
        return showPrev;
    }

    public void setShowPrev(boolean showPrev) {
        this.showPrev = showPrev;
    }

    public boolean isShowNext() {
        return showNext;
    }

    public void setShowNext(boolean showNext) {
        this.showNext = showNext;
    }

    public int getBeginPage() {
        return beginPage;
    }

    public void setBeginPage(int beginPage) {
        this.beginPage = beginPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    @Override
    public String toString() {
        return "PageHandler{" +
                "totalPage=" + totalPage +
                ", totalCnt=" + totalCnt +
                ", page=" + page +
                ", navSize=" + navSize +
                ", pageSize=" + pageSize +
                '}';
    }
}
