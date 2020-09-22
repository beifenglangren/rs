package edu.qtech.rs.service.impl;

import edu.qtech.rs.dao.ReviewDao;
import edu.qtech.rs.entity.ReviewInfo;
import edu.qtech.rs.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService {
    @Autowired
    private ReviewDao reviewDao;
    @Override
    public void insert(ReviewInfo reviewInfo) {
        reviewDao.insert(reviewInfo);
    }

    @Override
    public List<ReviewInfo> findBySid(Integer sid) {
        return reviewDao.selectBySid(sid);
    }

    @Override
    public List<ReviewInfo> findByUid(Integer uid) {
        return reviewDao.selectByUid(uid);
    }

    @Override
    public ReviewInfo findById(Integer id) {
        return reviewDao.selectById(id);
    }

    @Override
    public void remove(Integer id) {
        reviewDao.delete(id);
    }

    @Override
    public List<ReviewInfo> findReply(Integer uid) {
        return reviewDao.selectReply(uid);
    }

    @Override
    public List<ReviewInfo> findShopReview(Integer uid) {
        return reviewDao.selectShopReview(uid);
    }

    @Override
    public List<ReviewInfo> findAll() {
        return reviewDao.selectAll();
    }

    @Override
    public List<ReviewInfo> findByKey(String key) {
        return reviewDao.selectByKey(key);
    }
}
