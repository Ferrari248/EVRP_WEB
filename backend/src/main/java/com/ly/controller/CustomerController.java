package com.ly.controller;

import com.ly.entity.Customer;
import com.ly.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@CrossOrigin
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    CustomerService customerService;

    @GetMapping("/{pid}")
    @ResponseBody
//    http://localhost:9090/customer/c0002
    public Customer findOneCustomer(@PathVariable("pid") String pid) {
        Customer customer = customerService.findByPid(pid);
        if (customer == null) {
            customer = new Customer();
        }
        return customer;
    }

    @GetMapping("/findall")
    @ResponseBody
//    http://localhost:9090/customer/findall
    public List<Customer> findAllCustomers() {
        List<Customer> customers = customerService.findAll();
        return customers;
    }

    @PostMapping("/save")
    public String saveOneCustomer(Customer customer) {
        customerService.saveOne(customer);
        return "redirect:/customer/findall";
    }

    @PutMapping("/update")
    public String updateOneChargingStation(Customer customer) {
        customerService.updateOne(customer);
        return "redirect:/customer/findall";
    }

    @DeleteMapping("/deleteById")
    public String deleteOneCustomerById(String pid) {
        customerService.deleteOne(pid);
        return "redirect:/customer/findall";
    }

}
