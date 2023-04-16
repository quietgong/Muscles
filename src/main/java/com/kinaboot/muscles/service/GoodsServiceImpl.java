package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.GoodsDao;
import com.kinaboot.muscles.dao.ReviewDao;
import com.kinaboot.muscles.domain.*;
import com.kinaboot.muscles.handler.SearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class GoodsServiceImpl implements GoodsService {
    @Autowired
    GoodsDao goodsDao;
    @Autowired
    ReviewDao reviewDao;

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
    public int addGoods(GoodsDto goodsDto) {
        int goodsNo = goodsDao.selectGoodsNo();
        goodsDto.setGoodsNo(goodsNo);
        saveGoodsImgs(goodsDto);
        return goodsDao.insert(goodsDto);
    }
    private void saveGoodsImgs(GoodsDto goodsDto) {
        goodsDao.deleteAllGoodsDetail(goodsDto.getGoodsNo());
        List<GoodsImgDto> goodsImgDtoList = goodsDto.getGoodsImgDtoList();
        for(GoodsImgDto goodsImgDto : goodsImgDtoList){
            Map<String, String> map = new HashMap<>();
            map.put("goodsNo", String.valueOf(goodsImgDto.getGoodsNo()));
            map.put("filePath", goodsImgDto.getUploadPath());
            goodsDao.insertGoodsImg(map);
        }
    }
//    private void saveGoodsImgs(GoodsDto goodsDto) {
//        List<GoodsImgDto> newImgDtoList = goodsDto.getGoodsImgDtoList();
//        List<GoodsImgDto> goodsImgDtoList = goodsDao.selectGoodsDetailImg(goodsDto.getGoodsNo());
//        for (GoodsImgDto newImgDto : newImgDtoList) {
//            boolean alreadyExists = goodsImgDtoList.stream()
//                    .anyMatch(goodsImgDto -> goodsImgDto.getUploadPath().equals(newImgDto.getUploadPath()));
//            if (!alreadyExists) {
//                Map<String, String> map = new HashMap<>();
//                map.put("goodsNo", String.valueOf(newImgDto.getGoodsNo()));
//                map.put("filePath", newImgDto.getUploadPath());
//                goodsDao.insertGoodsImg(map);
//            }
//        }
//        if (goodsImgDtoList.size() == 0) {
//            for (GoodsImgDto newImgDto : newImgDtoList) {
//                Map<String, String> map = new HashMap<>();
//                map.put("goodsNo", String.valueOf(newImgDto.getGoodsNo()));
//                map.put("filePath", newImgDto.getUploadPath());
//                goodsDao.insertGoodsImg(map);
//            }
//        } else {
//            for (GoodsImgDto newImgDto : newImgDtoList) {
//                for (GoodsImgDto goodsImgDto : goodsImgDtoList) {
//                    if (!newImgDto.getUploadPath().equals(goodsImgDto.getUploadPath())) {
//                        Map<String, String> map = new HashMap<>();
//                        map.put("goodsNo", String.valueOf(newImgDto.getGoodsNo()));
//                        map.put("filePath", newImgDto.getUploadPath());
//                        goodsDao.insertGoodsImg(map);
//                    }
//                }
//            }
//        }
//    }

    @Override
    public int modifyGoods(GoodsDto goodsDto) {
        saveGoodsImgs(goodsDto);
        return goodsDao.updateGoods(goodsDto);
    }

    @Override
    public int removeGoodsImg(String type, String imgPath) {
        return type.equals("thumbnail") ? goodsDao.deleteGoodsThumbnail(imgPath) : goodsDao.deleteGoodsDetail(imgPath);
    }

    @Override
    public List<GoodsImgDto> getGoodsDetailImgList(Integer GoodsNo) {
        return goodsDao.selectGoodsDetailImg(GoodsNo);
    }

    @Override
    public List<FaqDto> findFaqs(Integer GoodsNo) {
        return goodsDao.selectFaqList(GoodsNo);
    }

    @Override
    public List<GoodsCategoryDto> findAllCategories() {
        return goodsDao.selectAllCategories();
    }

    @Override
    public int removeGoods(Integer goodsNo) {
        reviewDao.deleteGoodsReview(goodsNo); // 해당 상품에 대한 리뷰 데이터를 모두 삭제
        reviewDao.deleteGoodsFaq(goodsNo); // 해당 상품에 대한 문의 데이터를 모두 삭제
        return goodsDao.deleteGoods(goodsNo);
    }

    @Override
    public int addFaq(FaqDto faqDto) {
        return goodsDao.insertFaq(faqDto);
    }

    @Override
    public GoodsDto findGoods(Integer GoodsNo) {
        GoodsDto goodsDto = goodsDao.select(GoodsNo);
        goodsDto.setReviewDtoList(reviewDao.selectGoodsReview(GoodsNo));
        goodsDto.setGoodsImgDtoList(goodsDao.selectGoodsDetailImg(GoodsNo));
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
