/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.casesummary.web.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.Concept;
import org.openmrs.Patient;
import org.openmrs.User;
import org.openmrs.api.context.Context;
import org.openmrs.module.casesummary.api.CaseSummaryService;
import org.openmrs.module.casesummary.model.DoctorProfile;
import org.openmrs.module.casesummary.model.OtNote;
import org.openmrs.module.casesummary.model.PatientSearchCs;
import org.openmrs.module.casesummary.model.SailentFeature;
import org.openmrs.module.casesummary.model.SelectPatient;
import org.openmrs.module.casesummary.model.Slide;
import org.openmrs.module.casesummary.util.CaseSummaryConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author Khairul
 */
@Controller
public class PatientSerachInSystem {

    protected final Log log = LogFactory.getLog(getClass());

    @Autowired
    CaseSummaryService caseSumService;

    public static Integer getPatientId = 0;

    @RequestMapping(value = "/module/casesummary/patientSerach.htm", method = RequestMethod.GET)
    public String serachPatient(@RequestParam(value = "searchKey", required = false) String searchKey,
            ModelMap model) {

        List<PatientSearchCs> listPatient = caseSumService.patientSearchByIdName(searchKey);
        model.addAttribute("listPatient", listPatient);

        return "module/casesummary/patientSearch/patientSearchInSystem";
    }

    @RequestMapping(value = "/module/casesummary/selectPatient.htm", method = RequestMethod.GET)
    public String selectPatient(@RequestParam(value = "patientId", required = false) int patientId,
            ModelMap model) {
        User u = Context.getAuthenticatedUser();
        model.addAttribute("u", u);

        PatientSearchCs ps = caseSumService.getPatientSerByPatientId(patientId);
        model.addAttribute("ps", ps);

        SelectPatient sp = null;
        sp = caseSumService.getSelectPatiByPatientIdUsreId(u.getId(), patientId);

        if (sp == null) {
            model.addAttribute("check", "true");
        } else {
            model.addAttribute("check", "false");
        }

        Concept ipdList = Context.getConceptService().getConceptByName(CaseSummaryConstants.IPD_WARD_LIST);
        model.addAttribute("ipdList", ipdList.getAnswers());

        Concept unitList = Context.getConceptService().getConceptByName(CaseSummaryConstants.UNIT_NAME_LIST);
        model.addAttribute("unitList", unitList.getAnswers());

        return "module/casesummary/patientSearch/selectPatient";
    }

    @RequestMapping(value = "/module/casesummary/selectPatientSave.htm", method = RequestMethod.POST)
    public String selectPatientSave(//@ModelAttribute("selectPatient") SelectPatient selectPatient, BindingResult result,
            @RequestParam(value = "patientId", required = false) int patientId,
            @RequestParam(value = "address", required = false) String address,
            @RequestParam(value = "fatherName", required = false) String fatherName,
            @RequestParam(value = "diagnosis", required = false) String diagnosis,
            @RequestParam(value = "icdCode", required = false) String icdCode,
            @RequestParam(value = "nameOfPresenter", required = false) String nameOfPresenter,
            @RequestParam(value = "pdate", required = false) String pdate,
            @RequestParam(value = "award", required = false) String award,
            @RequestParam(value = "abed", required = false) String abed,
            @RequestParam(value = "contactNo", required = false) String contactNo,
            @RequestParam(value = "adForm", required = false) String adForm,
            @RequestParam(value = "adDate", required = false) String adDate,
            @RequestParam(value = "unit", required = false) String unit, Model model) {

        //System.out.println("*************patientid=" + patientId);
        User u = Context.getAuthenticatedUser();
        Patient patient = Context.getPatientService().getPatient(patientId);

        getPatientId = patientId;

        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        Date preDate = null;
        Date admissionDate = null;

        try {
            preDate = sdf.parse(pdate);
            admissionDate = sdf.parse(adDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        SelectPatient selectPatient = new SelectPatient();
        selectPatient.setPatientId(patient);
        selectPatient.setAddress(address);
        selectPatient.setFatherName(fatherName);
        selectPatient.setDiagnosis(diagnosis);
        selectPatient.setIcdCode(icdCode);
        selectPatient.setNameOfPresenter(nameOfPresenter);
        selectPatient.setPresentationDate(preDate);
        selectPatient.setAdmittedWard(award);
        selectPatient.setAdmittedBed(abed);
        selectPatient.setUnit(unit);
        selectPatient.setAdmittedForm(adForm);
        selectPatient.setContactNo(contactNo);
        selectPatient.setDateOfAdmission(admissionDate);

        selectPatient.setCreatedDate(new Date());
        selectPatient.setUserId(u);
        selectPatient = caseSumService.saveSlectPatient(selectPatient);

        System.out.println("****************" + selectPatient.getId());
        model.addAttribute("id", selectPatient.getId());
        return "redirect:/module/casesummary/main.form";
        // return "redirect:/module/casesummary/selectedPatientSingle.htm?patientId=" + patientId +"&id="+selectPatient.getId();
        //selectedPatientSingle.htm?patientId=" + patientId;
    }

    @RequestMapping(value = "/module/casesummary/pictureSavePatFile.htm", method = RequestMethod.POST)
    public void savePatientFile(@RequestParam("patImage") MultipartFile multipartFile,
            //  @RequestParam(value = "patientId", required = false) int patientId,
            HttpServletRequest request, HttpServletResponse response,
            Model model) {

        System.out.println("*****************" + getPatientId);
        User u = Context.getAuthenticatedUser();

        SelectPatient sp = caseSumService.getSelectPatiByPatientIdUsreId(u.getUserId(), getPatientId);
        String fullName = sp.getId() + "-" + getPatientId + "pId";

        String fileName = multipartFile.getOriginalFilename();
        System.out.println("******" + fileName);
        if ((multipartFile != null && multipartFile.getSize() > 0)) {
            if (saveFilePatient(multipartFile, request)) {
                sp.setImageName(fullName + "-" + fileName);
                caseSumService.saveSlectPatient(sp);
            }
        }
    }

    public boolean saveFilePatient(MultipartFile multipartFile, HttpServletRequest request) {
        String fileLocation = request.getSession().getServletContext().getRealPath("/imageFolder/");
        boolean result = false;
        User u = Context.getAuthenticatedUser();
        String fileName = multipartFile.getOriginalFilename();
        File pathFile = new File(fileLocation);
        if (!pathFile.exists()) {
            pathFile.mkdir();
        }
        SelectPatient sp = caseSumService.getSelectPatiByPatientIdUsreId(u.getUserId(), getPatientId);
        pathFile = new File(pathFile
                + File.separator
                + sp.getId()
                + "-"
                + getPatientId
                + "pId"
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

//    @RequestMapping(value = "/module/casesummary/selectedPatientSingle.htm", method = RequestMethod.GET)
//    public String selectedPatientSingle(@RequestParam("patientId") int patientId,
//            @RequestParam(value = "id", required = false) int id,
//            ModelMap model) {
//        User u = Context.getAuthenticatedUser();
//        model.addAttribute("u", u);
//        SelectPatient sp = null;
//        if (id == 0) {
//            sp = caseSumService.getSelectPatiByPatientIdUsreId(u.getId(), patientId);
//        } else {
//            sp = caseSumService.getSelPatientById(id);
//        }
//        model.addAttribute("sp", sp);
//        model.addAttribute("age", sp.getPatientId().getAge());
//        SailentFeature sf = caseSumService.getSailentById(sp.getId());
//        model.addAttribute("sf", sf);
//        List<OtNote> listOtNote = caseSumService.listOtNote(sp.getId());
//        model.addAttribute("listOtNote", listOtNote);
//        List<Slide> listSlide=caseSumService.listSlideBySelPatId(sp.getId());
//        model.addAttribute("listSlide", listSlide);
//        return "module/casesummary/patientSearch/selectedPatientSingle";
//    }

    @RequestMapping(value = "/module/casesummary/selectedPatientList.htm", method = RequestMethod.GET)
    public String selectedPatientList(ModelMap model) {
        User u = Context.getAuthenticatedUser();
        model.addAttribute("u", u);
        int userId = u.getUserId();

        List<SelectPatient> listSelPatient = caseSumService.listSelectPatientByUser(userId);
        model.addAttribute("listSelPat", listSelPatient);

        HashMap<Integer, String> hashMap = new HashMap<Integer, String>();

        for (Integer i = 0; i < listSelPatient.size(); i++) {
            hashMap.put(listSelPatient.get(i).getPatientId().getPatientId(),
                    listSelPatient.get(i).getPatientId().getAge().toString());
        }
        model.addAttribute("hashMap", hashMap);

        return "module/casesummary/patientSearch/selectedPatientList";
    }

}
