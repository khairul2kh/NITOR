/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.casesummary.web.controller;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.User;
import org.openmrs.api.context.Context;
import org.openmrs.module.casesummary.api.CaseSummaryService;
import org.openmrs.module.casesummary.model.DoctorProfile;
import org.openmrs.module.casesummary.model.FollowUp;
import org.openmrs.module.casesummary.model.OtNote;
import org.openmrs.module.casesummary.model.SailentFeature;
import org.openmrs.module.casesummary.model.SelectPatient;
import org.openmrs.module.casesummary.model.Slide;
import org.openmrs.module.casesummary.util.CaseSummaryConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author Khairul
 */
@Controller("EditSlide")
public class EditSlide {

    @Autowired
    CaseSummaryService caseSumService;

    public static Integer slideId = 0;

//    @RequestMapping(value = "/module/casesummary/listSelectPat1.htm", method = RequestMethod.GET)
//    public String serachPatient1(@RequestParam(value = "sId", required = false) String pdate,
//            ModelMap model) {
//        return "module/casesummary/ajax/slideUpadate";
//    }
    @RequestMapping(value = "/module/casesummary/getSlideEdit.htm", method = RequestMethod.GET)
    public String getSlideEdit(@RequestParam(value = "sId", required = false) int id,
            ModelMap model) {
        Slide s = caseSumService.getSlideById(id);
        model.addAttribute("s", s);
        System.out.println("**********" + s);
        slideId = id;

        return "module/casesummary/ajax/slideUpadate";
    }

    @RequestMapping(value = "/module/casesummary/getSlideUpdate.htm", method = RequestMethod.POST)
    public void updateSlide(@RequestParam(value = "sId", required = false) int id,
            @RequestParam(value = "upDiagnosis", required = false) String diagnosis,
            @RequestParam(value = "upPlan", required = false) String plan,
            ModelMap model) {
        Slide s = caseSumService.getSlideById(id);
        s.setDiagnosis(diagnosis);
        s.setPlan(plan);
        caseSumService.saveSlide(s);
        System.out.println("**********" + id);

        slideId = id;
    }

    @RequestMapping(value = "/module/casesummary/pictureUpdate.htm", method = RequestMethod.POST)
    public void UpdateSlidePic(@RequestParam("imgInpEdit1") MultipartFile multipartFile,
            @RequestParam("imgInpEdit2") MultipartFile multipartFile1,
            HttpServletRequest request, HttpServletResponse response,
            Model model) {
        
       // Slide slide = caseSumService.getSlideById(slideId);
        Slide s = caseSumService.getSlideById(slideId);
        DateFormat df = new SimpleDateFormat("yy"); // Just the year, with 2 digits
        String curYear = df.format(Calendar.getInstance().getTime());
        String fileLocation = request.getSession().getServletContext().getRealPath("/imageFolder/");
        
        if ((multipartFile != null && multipartFile.getSize() > 0)) {
            String imageName = multipartFile.getOriginalFilename();
            
            boolean result = false;
            File pathFile = new File(fileLocation);
            
            String fileName = s.getSelectPatient().getId() + "-" +"s"+slideId.toString() + "-" + curYear + "-" + imageName;
            if (s.getImgNameOne()== null) {
                pathFile = new File(pathFile + File.separator + fileName);
                  s.setImgNameOne(fileName);
                  caseSumService.saveSlide(s);
            } else {
                pathFile = new File(pathFile + File.separator + s.getImgNameOne());
            }
            //save the actual file
            try {
                multipartFile.transferTo(pathFile);
                result = true;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        if ((multipartFile1 != null && multipartFile1.getSize() > 0)) {
            String imageName1 = multipartFile1.getOriginalFilename();
           // String fileLocation = request.getSession().getServletContext().getRealPath("/imageFolder/");
            boolean result = false;
            File pathFile = new File(fileLocation);
            //Slide s = caseSumService.getSlideById(slideId);
            String fileName = s.getSelectPatient().getId() + "-" +"s"+slideId.toString() + "-" + curYear + "-" + imageName1;
            if (s.getImgNameTwo() == null) {
                pathFile = new File(pathFile + File.separator + fileName);
                  s.setImgNameTwo(fileName);
                  caseSumService.saveSlide(s);
            } else {
                pathFile = new File(pathFile + File.separator + s.getImgNameTwo());
            }
            //save the actual file
            try {
                multipartFile1.transferTo(pathFile);
                result = true;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

//    public boolean updateFile(MultipartFile multipartFile, HttpServletRequest request) {
//        String fileLocation = request.getSession().getServletContext().getRealPath("/imageFolder/");
//        boolean result = false;
//        File pathFile = new File(fileLocation);
//        Slide s = caseSumService.getSlideById(slideId);
//        pathFile = new File(pathFile
//                + File.separator
//                + s.getImgNameOne());
//        //save the actual file
//        try {
//            multipartFile.transferTo(pathFile);
//            result = true;
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        return result;
//    }

}
