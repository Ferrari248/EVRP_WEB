package com.ly.service;

import com.ly.dao.CustomerDao;
import com.ly.dao.PlaceDao;
import com.ly.entity.Customer;
import com.ly.entity.Place;
import com.ly.uitl.DBUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CustomerService {

    @Autowired
    private CustomerDao customerDao;
    @Autowired
    private PlaceDao placeDao;

    public Customer findByPid(String pid) {
        return customerDao.queryByPid(pid);
    }

    public List<Customer> findAll() {
        return customerDao.queryAll();
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void saveOne(Customer customer) {
        String pid = customer.getPid();
        if (pid == null || "".equals(pid)) {
            pid = DBUtils.getOnePid(2);
        }
        while (placeDao.queryByPid(pid) != null) {
            pid = DBUtils.getOnePid(2);
        }
        customer.setPid(pid);
        customerDao.insertOne(customer);
        Place place = new Place(pid, 2, customer.getLng(), customer.getLat());
        placeDao.insertOne(place);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void updateOne(Customer customer) {
        String pid = customer.getPid();
        if (pid == null) {
            // 如果修改数据时，连pid都没指定，则直接退出
            System.out.println("未指定pid");
            return;
        }
        // 不修改经纬度
        customerDao.updateOne(customer);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public void deleteOne(String pid) {
        if (pid == null) {
            // 如果修改数据时，连pid都没指定，则直接退出
            System.out.println("未指定要删除对象的pid");
            return;
        }
        customerDao.deleteOne(pid);
        placeDao.deleteOne(pid);
    }
}
