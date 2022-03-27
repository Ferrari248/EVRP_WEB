package com.ly.service;

import com.ly.dao.PlaceDao;
import com.ly.entity.Place;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PlaceService {

    @Autowired
    private PlaceDao placeDao;

    public Place findByPid(String pid) {
        return placeDao.queryByPid(pid);
    }

    public List<Place> findAll() {
        return placeDao.queryAll();
    }

    public List<Place> findByPtype(Integer ptype) {
        return placeDao.queryByPtype(ptype);
    }
}
