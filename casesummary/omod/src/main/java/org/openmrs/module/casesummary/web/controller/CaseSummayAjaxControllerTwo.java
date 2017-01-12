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
@Controller("CaseSumAjaxControllerTwo")
public class CaseSummayAjaxControllerTwo {

    protected final Log log = LogFactory.getLog(getClass());
    User u = Context.getAuthenticatedUser();

    @Autowired
    CaseSummaryService caseSumService;

    public static Integer select_patient = 0;
    //public static int patientId = 0;

    @RequestMapping(value = "/module/casesummary/followUpSave.htm", method = RequestMethod.POST)
    public void slideSave(
            @RequestParam(value = "id", required = false) int id,
            @RequestParam(value = "diagnosisFoll", required = false) String diagnosisFoll,
            @RequestParam(value = "dateSurgery", required = false) String dateSurgery,
            @RequestParam(value = "dateFollup", required = false) String dateFollup,
            @RequestParam(value = "comment", required = false) String comment,
            @RequestParam(value = "subPlan", required = false) String subPlan,
            Model model) throws IOException {

        SelectPatient sp = caseSumService.getSelPatientById(id);

        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        Date dateOfSur = null;
        Date dateOfFoll = null;

        try {
            dateOfSur = sdf.parse(dateSurgery);
            dateOfFoll = sdf.parse(dateFollup);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        FollowUp fup = new FollowUp();
        fup.setSelectPatient(sp);
        fup.setDiagnosis(diagnosisFoll);
        fup.setDateOfSurgery(dateOfSur);
        fup.setDateOfFollowUp(dateOfFoll);
        fup.setComment(comment);
        fup.setSubsequentPlan(subPlan);
        fup.setCreatedDate(new Date());
        fup.setCreator(u.getUserId());
        fup.setImgNameOne(null);
        fup.setImgNameTwo(null);
        caseSumService.saveFollowUp(fup);
        select_patient = sp.getId();

    }

    @RequestMapping(value = "/module/casesummary/pictureSaveFollUP.htm", method = RequestMethod.POST)
    public void FileUpload(@RequestParam("follUpImg1") MultipartFile multipartFile,
            @RequestParam("follUpImg2") MultipartFile multipartFile1,
            HttpServletRequest request, HttpServletResponse response,
            Model model) {

        //Slide slide = caseSumService.getSlideLastId(u.getUserId());
        FollowUp follup = caseSumService.getFollUpLastId(u.getUserId());

//        Calendar now = Calendar.getInstance();
//        String curYear = String.valueOf(now.get(Calendar.YEAR));
        DateFormat df = new SimpleDateFormat("yy"); // Just the year, with 2 digits
        String curYear = df.format(Calendar.getInstance().getTime());

        String fullName = select_patient.toString() + "-" + "f" + follup.getId() + "-" + curYear;

        //long fileSize = multipartFile.getSize();
        String fileName = multipartFile.getOriginalFilename();
        if ((multipartFile != null && multipartFile.getSize() > 0)) {
            if (saveFileFoll(multipartFile, request)) {

                follup.setImgNameOne(fullName + "-" + fileName);
                caseSumService.saveFollowUp(follup);
            }
        }

        //long fileSize1 = multipartFile1.getSize();
        String fileName1 = multipartFile1.getOriginalFilename();

        if ((multipartFile1 != null && multipartFile1.getSize() > 0)) {
            if (saveFileFoll(multipartFile1, request)) {

                follup.setImgNameTwo(fullName + "-" + fileName1);
                caseSumService.saveFollowUp(follup);
            }
        }
    }

    public boolean saveFileFoll(MultipartFile multipartFile, HttpServletRequest request) {
        String fileLocation = request.getSession().getServletContext().getRealPath("/imageFolder/");
        boolean result = false;
        String fileName = multipartFile.getOriginalFilename();
        File pathFile = new File(fileLocation);
        if (!pathFile.exists()) {
            pathFile.mkdir();
        }
        DateFormat df = new SimpleDateFormat("yy"); // Just the year, with 2 digits
        String curYear = df.format(Calendar.getInstance().getTime());

        FollowUp fu = caseSumService.getFollUpLastId(u.getUserId());
        String folId = "f" + fu.getId();

        pathFile = new File(pathFile
                + File.separator
                + select_patient.toString()
                + "-"
                + folId
                + "-"
                + curYear
                + "-"
                + fileName);
        try {
            multipartFile.transferTo(pathFile);
            result = true;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping(value = "/module/casesummary/reschedulePresentation.htm", method = RequestMethod.POST)
    public String updateReschedule(@RequestParam(value = "id", required = false) int id,
            @RequestParam(value="reDate",required =false ) String reDate, ModelMap model) {
        
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        Date reschedule = null;

        try {
            reschedule = sdf.parse(reDate);
            
        } catch (ParseException e) {
            e.printStackTrace();
        }
        
        SelectPatient sp = caseSumService.getSelPatientById(id);
        sp.setPresentationDate(reschedule);
        sp.setStatus(false);
        caseSumService.saveSlectPatient(sp);
        //model.addAttribute("sp",sp);

        return "module/casesummary/thickbox/success_1";
    }
}
