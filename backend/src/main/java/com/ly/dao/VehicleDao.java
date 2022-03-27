package com.ly.dao;

import com.ly.entity.Vehicle;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface VehicleDao {

    List<Vehicle> queryAll();

    Integer getVehicleCount();

    void insertOne(Vehicle vehicle);

    void updateOne(Vehicle vehicle);

    void deleteOne(Integer vid);
}
