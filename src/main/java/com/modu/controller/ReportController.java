package com.modu.controller;

import com.modu.service.ReportService;
import com.modu.vo.ModuUserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ReportController {
    @Autowired
    ReportService reportService;

    @RequestMapping(value = "/annualreport/{year}",method = RequestMethod.GET)
    public String annualReport(@PathVariable String year,Model model){
        model.addAttribute("year",year);
        System.out.println("연간 보고서로 이동");
        return "/report/annual_report";
    }

    @RequestMapping(value = "/monthlyreport/{month}",method = RequestMethod.GET)
    public String monthlyReport(@PathVariable String month){
        System.out.println("월간 보고서로 이동");
        return "/report/monthly_report";
    }

    @RequestMapping(value = "/eventreport/{eventNo}",method = RequestMethod.GET)
    public String eventReport(@PathVariable String eventNo){
        System.out.println("행사별 보고서로 이동");
        return "/report/event_report";
    }

    @RequestMapping(value = "/getRecentEvent/{groupNo}",method = RequestMethod.GET)
    public String getRecentEvent(@RequestParam String groupNo){
        System.out.println(groupNo);
        int recentEvent = reportService.getRecentEvent(groupNo);
        return "redirect:/eventreport/"+recentEvent;
    }

}
