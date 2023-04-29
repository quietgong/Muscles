package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.GoodsDao;
import com.kinaboot.muscles.dao.ReviewDao;
import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class GoodsServiceImpl implements GoodsService {
    private final GoodsDao goodsDao;
    private final ReviewDao reviewDao;
    private final ReviewService reviewService;
    @Autowired
    public GoodsServiceImpl(GoodsDao goodsDao, ReviewDao reviewDao, ReviewService reviewService) {
        this.goodsDao = goodsDao;
        this.reviewDao = reviewDao;
        this.reviewService = reviewService;
    }

    @Override
    public List<GoodsDto> findBestGoods() {
        List<GoodsDto> goodsDtoList = goodsDao.selectBestGoods();
        for (GoodsDto goodsDto : goodsDtoList)
            goodsDto.setReviewDtoList(reviewDao.selectGoodsReview(goodsDto.getGoodsNo()));
        return goodsDtoList;
    }

    @Override
    public List<GoodsDto> findAllGoods() {
        return goodsDao.selectAll();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addGoods(GoodsDto goodsDto) {
        goodsDao.insert(goodsDto);
        int goodsNo = goodsDao.selectGoodsNo();
        goodsDto.setGoodsNo(goodsNo);
        goodsDao.deleteAllGoodsDetail(goodsNo);
        List<GoodsImgDto> goodsImgDtoList = goodsDto.getGoodsImgDtoList();
        for (GoodsImgDto goodsImgDto : goodsImgDtoList){
            goodsImgDto.setGoodsNo(goodsNo);
            goodsDao.insertGoodsImg(goodsImgDto);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int modifyGoods(GoodsDto goodsDto) {
        goodsDao.deleteAllGoodsDetail(goodsDto.getGoodsNo());
        List<GoodsImgDto> goodsImgDtoList = goodsDto.getGoodsImgDtoList();
        for (GoodsImgDto goodsImgDto : goodsImgDtoList){
            goodsImgDto.setGoodsNo(goodsDto.getGoodsNo());
            goodsDao.insertGoodsImg(goodsImgDto);
        }
        return goodsDao.updateGoods(goodsDto);
    }

    @Override
    public List<FaqDto> findFaqs(Integer goodsNo) {
        return goodsDao.selectFaqList(goodsNo);
    }

    @Override
    public List<GoodsCategoryDto> findAllCategories() {
        return goodsDao.selectAllCategories();
    }

    @Override
    @Transactional
    public int removeGoods(Integer goodsNo) {
        reviewDao.deleteGoodsReview(goodsNo); // 해당 상품에 대한 리뷰 데이터를 모두 삭제
        goodsDao.deleteGoodsFaq(goodsNo); // 해당 상품에 대한 문의 데이터를 모두 삭제
        return goodsDao.deleteGoods(goodsNo);
    }

    @Override
    public int addFaq(FaqDto faqDto) {
        return goodsDao.insertFaq(faqDto);
    }

    @Override
    public GoodsDto findGoods(Integer goodsNo) {
        GoodsDto goodsDto = goodsDao.select(goodsNo);
        goodsDto.setGoodsImgDtoList(goodsDao.selectGoodsDetailImg(goodsNo));

        List<ReviewDto> reviewDtoList = reviewDao.selectGoodsReview(goodsNo);
        for (ReviewDto reviewDto : reviewDtoList)
            reviewDto.setReviewImgDtoList(reviewService.findReviewImg(reviewDto.getReviewNo(), goodsNo));
        goodsDto.setReviewDtoList(reviewDtoList);
        return goodsDto;
    }

    @Override
    public int getTotalCntByCategory(SearchCondition sc) {
        return goodsDao.selectByCategoryCnt(sc);
    }

    @Override
    public List<GoodsDto> findGoods(SearchCondition sc) {
        List<GoodsDto> goodsDtoList = goodsDao.selectByCategory(sc);
        for (GoodsDto goodsDto : goodsDtoList)
            goodsDto.setReviewDtoList(reviewDao.selectGoodsReview(goodsDto.getGoodsNo()));
        return goodsDtoList;
    }
}
