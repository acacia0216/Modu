package com.modu.controller;

import com.modu.service.ReportService;
import com.modu.vo.ModuUserVo;
import com.modu.vo.ReportVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;

@Controller
public class ReportController {
    @Autowired
    ReportService reportService;

    @RequestMapping(value = "/annualreport/{groupNo}/{year}",method = RequestMethod.GET)
    public String annualReport(@PathVariable String year,@PathVariable int groupNo,Model model){
        model.addAttribute("year",year);
        System.out.println("연간 보고서로 이동");
        Map<String,Object> tmp = reportService.annualReport(groupNo,year);
        model.addAttribute("list",tmp.get("outputList"));
        model.addAttribute("annualSum",tmp.get("annualSum"));
        model.addAttribute("monthlyIncome",tmp.get("monthlyIncome"));
        model.addAttribute("monthlySpend",tmp.get("monthlySpend"));
        return "/report/annual_report";
    }

    @RequestMapping(value = "/monthlyreport/{year}/{month}",method = RequestMethod.GET)
    public String monthlyReport(@PathVariable String year,@PathVariable String month,Model model){
        model.addAttribute("year",year);
        model.addAttribute("month",month);
        System.out.println("월간 보고서로 이동");
        return "/report/monthly_report";
    }

    @RequestMapping(value = "/eventreport/{eventNo}",method = RequestMethod.GET)
    public String eventReport(@PathVariable String eventNo){
        System.out.println("행사별 보고서로 이동");
        return "/report/event_report";
    }

    @RequestMapping(value = "/getRecentEvent/{groupNo}",method = RequestMethod.GET)
    public String getRecentEvent(@PathVariable String groupNo){
        System.out.println("행사별 보고서를 위한 그룹번호 : "+groupNo);
        int recentEvent = reportService.getRecentEvent(groupNo);
        return "redirect:/eventreport/"+recentEvent;
    }

}
