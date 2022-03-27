package com.ly.service;

import com.ly.dao.VehicleDao;
import com.ly.entity.Vehicle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VehicleService {

    @Autowired
    private VehicleDao vehicleDao;

    public List<Vehicle> findAll() {
        return vehicleDao.queryAll();
    }

    public Integer getCount() {
        return vehicleDao.getVehicleCount();
    }

    public void saveOne(Vehicle vehicle) {
        vehicleDao.insertOne(vehicle);
    }

    public void updateOne(Vehicle vehicle) {
        Integer vid = vehicle.getVid();
        if (vid == null) {
            System.out.println("未提供vid");
            return;
        }
        vehicleDao.updateOne(vehicle);
    }

    public void deleteOne(Integer vid) {
        vehicleDao.deleteOne(vid);
    }
}
