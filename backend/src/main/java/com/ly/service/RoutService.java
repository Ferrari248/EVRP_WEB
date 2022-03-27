package com.ly.service;

import com.ly.dao.RoutDao;
import com.ly.entity.Rout;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RoutService {

    @Autowired
    private RoutDao routDao;

    public Rout findLastRout() {
        return routDao.queryLastRout();
    }
}
