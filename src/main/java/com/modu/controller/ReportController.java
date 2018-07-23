package com.modu.controller;

import com.modu.service.ModuGroupService;
import com.modu.service.ReportService;
import com.modu.vo.ModuGroupVo;
import com.modu.vo.ModuUserVo;
import com.modu.vo.ReportVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class ReportController {
    @Autowired
    ReportService reportService;
    @Autowired
    ModuGroupService groupService;

//    @RequestMapping(value = "/monthlyreport/{groupNo}/{fromYear}/{fromMonth}/{toYear}/{toMonth}",method = RequestMethod.GET)
//    public String monthlyReport(@PathVariable String groupNo,@PathVariable String fromYear,@PathVariable String toYear,@PathVariable String fromMonth,@PathVariable String toMonth,Model model){
//        System.out.println("월간 보고서로 이동");
//        model.addAttribute("groupNo",groupNo);
//        model.addAttribute("fromYear",fromYear);
//        model.addAttribute("toYear",toYear);
//        model.addAttribute("fromMonth",fromMonth);
//        model.addAttribute("toMonth",toMonth);
//        Map<String,Object> tmp = reportService.monthlyReport(groupNo,fromYear,fromMonth,toYear,toMonth);
//        model.addAttribute("monthlySpend",tmp.get("monthlySpend"));
//        model.addAttribute("monthlyTotalSum",tmp.get("monthlyTotalSum"));
//        model.addAttribute("monthlyTagList",tmp.get("monthlyTagList"));
//        System.out.println("월 보고서 데이터 다 가지고 나오면 출력");
//        System.out.println(tmp.get("monthlySpend").toString());
//        System.out.println(tmp.get("monthlyTotalSum").toString());
//        System.out.println(tmp.get("monthlyTagList").toString());
//        model.addAttribute("nullList",tmp.get("nullList"));
//        System.out.println("널 리스트 : "+tmp.get("nullList"));
//        return "/report/monthly_report";
//    }

    @RequestMapping(value = "/reportbytag/{tagNo}",method = RequestMethod.GET)
    public String reportByTag(@PathVariable int tagNo, HttpSession session,Model model){
        //모임 카테고리
        ModuUserVo userVo =  (ModuUserVo) session.getAttribute("authUser");
        List<ModuGroupVo> gList  = groupService.selectGroup(userVo.getUserNo());
        model.addAttribute("gList",gList);

        //클릭한 모임  메인 보여주기
        ModuGroupVo gvo = groupService.selectGroupImg(userVo.getGroupNo());
        model.addAttribute("gvo",gvo);
        System.out.println("태그별 보고서로 이동");
        Map<String,Object> map = reportService.reportByTag(userVo,tagNo);
        model.addAttribute("tagList",map.get("tagList"));
        model.addAttribute("accountbookListByTag",map.get("accountbookListByTag"));
        model.addAttribute("tagNo",tagNo);
        System.out.println("태그 리스트 나온값 : "+map.get("tagList").toString());
        System.out.println("accountbookList 나온값 : "+map.get("accountbookListByTag").toString());
        return "/report/report_by_tag";
    }

    @RequestMapping(value = "/report/getRecentTag/{groupNo}",method = RequestMethod.GET)
    public String getRecentEvent(@PathVariable String groupNo){
        System.out.println("태그별 보고서를 위한 그룹번호 : "+groupNo);
        int recentTag = reportService.getRecentTag(groupNo);
        return "redirect:/reportbytag/"+recentTag;
    }


    @RequestMapping(value = "/reportbyperiod/{groupNo}/{fromYear}/{fromMonth}/{toYear}/{toMonth}",method = RequestMethod.GET)
    public String reportByPeriod(@PathVariable String fromYear,@PathVariable String fromMonth,@PathVariable String toYear,@PathVariable String toMonth,@PathVariable int groupNo,Model model,HttpSession session){
        //모임 카테고리
        ModuUserVo uservo =  (ModuUserVo) session.getAttribute("authUser");
        List<ModuGroupVo> gList  = groupService.selectGroup(uservo.getUserNo());
        model.addAttribute("gList",gList);

        //클릭한 모임  메인 보여주기
        ModuGroupVo gvo = groupService.selectGroupImg(uservo.getGroupNo());
        model.addAttribute("gvo",gvo);

        System.out.println("기간별 보고서로 이동");
        model.addAttribute("fromYear",fromYear);
        model.addAttribute("fromMonth",fromMonth);
        model.addAttribute("toYear",toYear);
        model.addAttribute("toMonth",toMonth);
        model.addAttribute("groupNo",groupNo);
        Map<String,Object> map = reportService.reportByPeriod(groupNo,fromYear,fromMonth,toYear,toMonth);
        model.addAttribute("reportListByCategory",map.get("reportListByCategory"));
        model.addAttribute("monthlySpend",map.get("monthlySpend"));
        model.addAttribute("monthlyIncome",map.get("monthlyIncome"));
        model.addAttribute("monthlyTotal",map.get("monthlyTotal"));
        return "/report/report_by_period";
    }


}
