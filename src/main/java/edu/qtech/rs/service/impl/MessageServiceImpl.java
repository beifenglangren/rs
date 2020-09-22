package edu.qtech.rs.service.impl;

import edu.qtech.rs.dao.MessageDao;
import edu.qtech.rs.entity.MessageInfo;
import edu.qtech.rs.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class MessageServiceImpl implements MessageService
{
    @Autowired
    private MessageDao messageDao;
    @Override
    public List<MessageInfo> find(Integer rid) {
        return messageDao.select(rid);
    }

    @Override
    public void add(MessageInfo messageInfo) {
        messageDao.insert(messageInfo);
    }

    @Override
    public void remove(Integer id) {
        messageDao.delete(id);
    }
}
