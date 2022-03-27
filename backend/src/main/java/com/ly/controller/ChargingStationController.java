package com.ly.controller;

import com.ly.entity.ChargingStation;
import com.ly.service.ChargingStationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@CrossOrigin
@RequestMapping("/chargingstation")
public class ChargingStationController {

    @Autowired
    ChargingStationService chargingStationService;

    @GetMapping("/{pid}")
    @ResponseBody
//    http://localhost:9090/chargingstation/e0002
    public ChargingStation findOneChargingStation(@PathVariable("pid") String pid) {
        ChargingStation chargingStation = chargingStationService.findByPid(pid);
        if (chargingStation == null) {
            chargingStation = new ChargingStation();
        }
        return chargingStation;
    }

    @GetMapping("/findall")
    @ResponseBody
//    http://localhost:9090/chargingstation/findall
    public List<ChargingStation> findAllChargingStations() {
        List<ChargingStation> chargingStation = chargingStationService.findAll();
        return chargingStation;
    }

    @PostMapping("/save")
    public String saveOneChargingStation(ChargingStation chargingStation) {
        chargingStationService.saveOne(chargingStation);
        return "redirect:/chargingstation/findall";
    }

    @PutMapping("/update")
    public String updateOneChargingStation(ChargingStation chargingStation) {
        chargingStationService.updateOne(chargingStation);
        return "redirect:/chargingstation/findall";
    }

    @DeleteMapping("/deleteById")
    public String deleteOneChargingStationById(String pid) {
        chargingStationService.deleteOne(pid);
        return "redirect:/chargingstation/findall";
    }
}
