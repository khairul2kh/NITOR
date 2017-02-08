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
@Controller("EditFollowup")
public class EditFollowup {

    @Autowired
    CaseSummaryService caseSumService;

    public static Integer followupId = 0;

    @RequestMapping(value = "/module/casesummary/getFollowupEdit.htm", method = RequestMethod.GET)
    public String getSlideEdit(@RequestParam(value = "fId", required = false) int id,
            ModelMap model) {
        FollowUp f = caseSumService.getFollowUpById(id);
        model.addAttribute("f", f);
        System.out.println("**********" + f);
        followupId = id;

        return "module/casesummary/ajax/followupEdit";
    }

    @RequestMapping(value = "/module/casesummary/followupUpdate.htm", method = RequestMethod.POST)
    public void updateFollowup(@RequestParam(value = "fId", required = false) int id,
            @RequestParam(value = "diagnosisFoll", required = false) String diagnosis,
            @RequestParam(value = "comment", required = false) String comment,
            @RequestParam(value = "subsequentPlan", required = false) String subsequentPlan,
            @RequestParam(value = "dateSurgery", required = false) String dateSurgery,
            @RequestParam(value = "dateFollow", required = false) String dateFollow,
            ModelMap model) {

        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        Date dateOfSur = null;
        Date dateOfFoll = null;

        try {
            dateOfSur = sdf.parse(dateSurgery);
            dateOfFoll = sdf.parse(dateFollow);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        FollowUp f = caseSumService.getFollowUpById(id);
        f.setDiagnosis(diagnosis);
        f.setComment(comment);
        f.setSubsequentPlan(subsequentPlan);
        f.setDateOfSurgery(dateOfSur);
        f.setDateOfFollowUp(dateOfFoll);
        caseSumService.saveFollowUp(f);
        followupId = id;
    }

    @RequestMapping(value = "/module/casesummary/pictureUpdateFollUp.htm", method = RequestMethod.POST)
    public void UpdateFollUpPic(@RequestParam("imgInpEdit1") MultipartFile multipartFile,
            @RequestParam("imgInpEdit2") MultipartFile multipartFile1,
            HttpServletRequest request, HttpServletResponse response,
            Model model) {

        // Slide slide = caseSumService.getSlideById(slideId);
        FollowUp f = caseSumService.getFollowUpById(followupId);
        DateFormat df = new SimpleDateFormat("yy"); // Just the year, with 2 digits
        String curYear = df.format(Calendar.getInstance().getTime());
        String fileLocation = request.getSession().getServletContext().getRealPath("/imageFolder/");

        if ((multipartFile != null && multipartFile.getSize() > 0)) {
            String imageName = multipartFile.getOriginalFilename();

            boolean result = false;
            File pathFile = new File(fileLocation);

            String fileName = f.getSelectPatient().getId() + "-" + "f" + followupId.toString() + "-" + curYear + "-" + imageName;
            if (f.getImgNameOne() == null) {
                pathFile = new File(pathFile + File.separator + fileName);
                f.setImgNameOne(fileName);
                caseSumService.saveFollowUp(f);
            } else {
                pathFile = new File(pathFile + File.separator + f.getImgNameOne());
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
            String fileName = f.getSelectPatient().getId() + "-" + "f" + followupId.toString() + "-" + curYear + "-" + imageName1;
            if (f.getImgNameTwo() == null) {
                pathFile = new File(pathFile + File.separator + fileName);
                f.setImgNameTwo(fileName);
                caseSumService.saveFollowUp(f);
            } else {
                pathFile = new File(pathFile + File.separator + f.getImgNameTwo());
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

}
