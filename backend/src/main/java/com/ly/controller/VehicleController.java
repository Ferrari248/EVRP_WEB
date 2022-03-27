package com.ly.controller;

import com.ly.entity.Vehicle;
import com.ly.service.VehicleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@CrossOrigin
@RequestMapping("/vehicle")
public class VehicleController {

    @Autowired
    VehicleService vehicleService;

    @GetMapping("/findall")
    @ResponseBody
//    http://localhost:9090/vehicle/findall
    public List<Vehicle> findAllVehicles() {
        List<Vehicle> vehicles = vehicleService.findAll();
        return vehicles;
    }

    @GetMapping("/count")
    @ResponseBody
    public Integer getCount() {
        return vehicleService.getCount();
    }

    @PostMapping("/save")
    public String saveOneVehicle(Vehicle vehicle) {
        vehicleService.saveOne(vehicle);
        return "redirect:/vehicle/findall";
    }

    @PutMapping("/update")
    public String updateOneVehicle(Vehicle vehicle) {
        vehicleService.updateOne(vehicle);
        return "redirect:/vehicle/findall";
    }

    @DeleteMapping("/deleteById")
    public String deleteOneVehicleById(Integer vid) {
        vehicleService.deleteOne(vid);
        return "redirect:/vehicle/findall";
    }

}
