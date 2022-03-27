package com.ly.dao;

import com.ly.entity.Place;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface PlaceDao {

    Place queryByPid(String pid);
    List<Place> queryAll();
    List<Place> queryByPtype(Integer ptype);

    void insertOne(Place place);

    void updateOne(Place place);

    void deleteOne(String pid);
}
