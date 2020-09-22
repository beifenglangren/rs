package edu.qtech.rs.service;

import edu.qtech.rs.entity.MessageInfo;

import java.util.List;

public interface MessageService {
    List<MessageInfo> find(Integer rid);
    void add(MessageInfo messageInfo);
    void remove(Integer id);
}
