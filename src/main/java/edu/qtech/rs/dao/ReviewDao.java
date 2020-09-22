package edu.qtech.rs.dao;

import edu.qtech.rs.entity.ReviewInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("reviewDao")
public interface ReviewDao {
    void insert(ReviewInfo reviewInfo);
    List<ReviewInfo> selectBySid(Integer sid);
    List<ReviewInfo> selectByUid(Integer uid);
    ReviewInfo selectById(Integer id);
    void delete(Integer id);
    List<ReviewInfo> selectReply(Integer uid);
    List<ReviewInfo> selectShopReview(Integer uid);
    List<ReviewInfo> selectAll();
    List<ReviewInfo> selectByKey(@Param("key") String key);
}
