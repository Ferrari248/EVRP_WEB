package com.ly.dao;

import com.ly.entity.ChargingStation;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface ChargingStationDao {

    ChargingStation queryByPid(String pid);
    List<ChargingStation> queryAll();

    void insertOne(ChargingStation chargingStation);

    void updateOne(ChargingStation chargingStation);

    void deleteOne(String pid);
}
