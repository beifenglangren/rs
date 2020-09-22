package edu.qtech.rs.service;

import edu.qtech.rs.entity.ReviewInfo;

import java.util.List;

public interface ReviewService {
    void insert(ReviewInfo reviewInfo);
    List<ReviewInfo> findBySid(Integer sid);
    List<ReviewInfo> findByUid(Integer uid);
    ReviewInfo findById(Integer id);
    void remove(Integer id);
    List<ReviewInfo> findReply(Integer uid);
    List<ReviewInfo> findShopReview(Integer uid);
    List<ReviewInfo> findAll();
    List<ReviewInfo> findByKey(String key);
}
