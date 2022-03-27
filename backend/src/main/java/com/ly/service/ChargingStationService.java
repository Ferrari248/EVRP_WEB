package com.ly.service;

import com.ly.dao.ChargingStationDao;
import com.ly.dao.PlaceDao;
import com.ly.entity.ChargingStation;
import com.ly.entity.Place;
import com.ly.uitl.DBUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ChargingStationService {

    @Autowired
    private ChargingStationDao chargingStationDao;
    @Autowired
    private PlaceDao placeDao;

    public ChargingStation findByPid(String pid) {
        return chargingStationDao.queryByPid(pid);
    }

    public List<ChargingStation> findAll() {
        return chargingStationDao.queryAll();
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void saveOne(ChargingStation chargingStation) {
        String pid = chargingStation.getPid();
        if (pid == null || "".equals(pid)) {
            pid = DBUtils.getOnePid(3);
        }
        while (placeDao.queryByPid(pid) != null) {
            pid = DBUtils.getOnePid(3);
        }
        chargingStation.setPid(pid);
        chargingStationDao.insertOne(chargingStation);
        Place place = new Place(pid, 3, chargingStation.getLng(), chargingStation.getLat());
        placeDao.insertOne(place);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void updateOne(ChargingStation chargingStation) {
        String pid = chargingStation.getPid();
        if (pid == null) {
            // 如果修改数据时，连pid都没指定，则直接退出
            System.out.println("未指定pid");
            return;
        }
        // 不修改经纬度
        chargingStationDao.updateOne(chargingStation);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteOne(String pid) {
        if (pid == null) {
            // 如果修改数据时，连pid都没指定，则直接退出
            System.out.println("未指定要删除对象的pid");
            return;
        }
        chargingStationDao.deleteOne(pid);
        placeDao.deleteOne(pid);
    }
}
