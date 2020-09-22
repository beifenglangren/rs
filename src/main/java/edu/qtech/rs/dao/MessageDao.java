package edu.qtech.rs.dao;

import edu.qtech.rs.entity.MessageInfo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("messageDao")
public interface MessageDao {
    List<MessageInfo> select(Integer rid);
    void insert(MessageInfo messageInfo);
    void delete(Integer id);
}
