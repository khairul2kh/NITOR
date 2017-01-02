/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.casesummary.web.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.User;
import org.openmrs.api.context.Context;
import org.openmrs.module.casesummary.api.CaseSummaryService;
import org.openmrs.module.casesummary.model.OtNote;
import org.openmrs.module.casesummary.model.SailentFeature;
import org.openmrs.module.casesummary.model.SelectPatient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author Khairul
 */
@Controller("CaseSumAjaxController")
public class CaseSummaryAjaxController {

    protected final Log log = LogFactory.getLog(getClass());

    @Autowired
    CaseSummaryService caseSumService;

    @RequestMapping(value = "/module/casesummary/sailentFeatSave.htm", method = RequestMethod.POST)
    public void sailentFeatSave(
            @RequestParam(value = "id", required = false) int id,
            @RequestParam(value = "sailentFeat", required = false) String sailentFeat,
            @RequestParam(value = "unit", required = false) String unit) {
        User u = Context.getAuthenticatedUser();

        SelectPatient sp = caseSumService.getSelPatientById(id);
        System.out.println("****************" + id);
        System.out.println("****************" + sp);
        SailentFeature sailentFeature = caseSumService.getSailentById(sp.getId());
        System.out.println("****************" + sailentFeature);
        if (sailentFeature == null) {
            SailentFeature sf = new SailentFeature();
            sf.setSelectPatient(sp);
            sf.setSailentFeature(sailentFeat);
            sf.setCreatedDate(new Date());
            sf.setCreator(u.getUserId());
            caseSumService.saveSailentFeat(sf);
        } else {
            sailentFeature.setSailentFeature(sailentFeat);
            caseSumService.saveSailentFeat(sailentFeature);
        }
        System.out.println("****************" + sailentFeature);
        //return "/module/casesummary/selectedPatientSingle";
    }

    @RequestMapping(value = "/module/casesummary/otNoteSave.htm", method = RequestMethod.POST)
    public void otNoteSave(
            @RequestParam(value = "id", required = false) int id,
            @RequestParam(value = "date", required = false) String date,
            @RequestParam(value = "time", required = false) String time,
            @RequestParam(value = "nameOfOt", required = false) String nameOfOt,
            @RequestParam(value = "procDet", required = false) String procedureDetail) {
        User u = Context.getAuthenticatedUser();
        SelectPatient sp = caseSumService.getSelPatientById(id);

        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        Date dateCon = null;

        try {
            dateCon = sdf.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        System.out.println("*************" + dateCon);

        OtNote on = new OtNote();
        on.setSelectPatient(sp);
        on.setDate(dateCon);
        on.setTime(time);
        on.setNameOfOt(nameOfOt);
        on.setProcedureDetail(procedureDetail);
        on.setCreatedDate(new Date());
        on.setCreator(u.getUserId());
        caseSumService.saveOtNote(on);

        //return "/module/casesummary/selectedPatientSingle";
    }

    @RequestMapping(value = "/module/casesummary/otnoteajax.htm", method = RequestMethod.GET)
    public String selectedPatientSingle(@RequestParam("patientId") int patientId, ModelMap model) {
        User u = Context.getAuthenticatedUser();
        model.addAttribute("u", u);
        int userId = u.getUserId();
        SelectPatient sp = caseSumService.getSelectPatiByPatientIdUsreId(userId, patientId);

        List<OtNote> listOtNote = caseSumService.listOtNote(sp.getId());
        model.addAttribute("listOtNote", listOtNote);

        return "module/casesummary/ajax/otnoteresult";
    }

    @RequestMapping(value = "/module/casesummary/slideSave.htm", method = RequestMethod.POST)
    public void slideSave(
            @RequestParam(value = "id", required = false) int id,
            @RequestParam(value = "diagnosis", required = false) String diagnosis,
            @RequestParam(value = "plan", required = false) String plan) {
        User u = Context.getAuthenticatedUser();
        SelectPatient sp = caseSumService.getSelPatientById(id);

//        try {
//
//            MultipartFile filea = uploadItem.getFileData();
//
//            InputStream inputStream = null;
//            OutputStream outputStream = null;
//            if (filea.getSize() > 0) {
//                inputStream = filea.getInputStream();
//// File realUpload = new File("C:/");
//                outputStream = new FileOutputStream("C:\\test111\\"
//                        + filea.getOriginalFilename());
//                System.out.println("====22=========");
//                System.out.println(filea.getOriginalFilename());
//                System.out.println("=============");
//                int readBytes = 0;
//                byte[] buffer = new byte[8192];
//                while ((readBytes = inputStream.read(buffer, 0, 8192)) != -1) {
//                    System.out.println("===ddd=======");
//                    outputStream.write(buffer, 0, readBytes);
//                }
//                outputStream.close();
//                inputStream.close();
//                session.setAttribute("uploadFile", "C:\\test111\\" + filea.getOriginalFilename());
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }

        //return "/module/casesummary/selectedPatientSingle";
    }

    ////// /////////////////////////////////////
}
