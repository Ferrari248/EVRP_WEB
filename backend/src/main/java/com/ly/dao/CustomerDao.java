package com.ly.dao;

import com.ly.entity.Customer;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface CustomerDao {

    Customer queryByPid(String pid);
    List<Customer> queryAll();

    void insertOne(Customer customer);

    void updateOne(Customer customer);

    void deleteOne(String pid);
}
