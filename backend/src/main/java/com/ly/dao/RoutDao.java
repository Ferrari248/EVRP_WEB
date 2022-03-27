package com.ly.dao;

import com.ly.entity.Rout;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface RoutDao {

    Rout queryLastRout();
}
