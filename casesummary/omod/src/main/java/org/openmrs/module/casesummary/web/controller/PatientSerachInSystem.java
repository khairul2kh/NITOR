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
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.Patient;
import org.openmrs.User;
import org.openmrs.api.context.Context;
import org.openmrs.module.casesummary.api.CaseSummaryService;
import org.openmrs.module.casesummary.model.DoctorProfile;
import org.openmrs.module.casesummary.model.PatientSearchCs;
import org.openmrs.module.casesummary.model.SelectPatient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Khairul
 */
@Controller
public class PatientSerachInSystem {

    protected final Log log = LogFactory.getLog(getClass());

    @Autowired
    CaseSummaryService caseSumService;

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

        return "module/casesummary/patientSearch/selectPatient";
    }

    @RequestMapping(value = "/module/casesummary/selectPatientSave.htm", method = RequestMethod.POST)
    public String selectPatientSave(@ModelAttribute("selectPatient") SelectPatient selectPatient, BindingResult result,
            @RequestParam(value = "patientId", required = false) int patientId,
            @RequestParam(value = "address", required = false) String address,
            @RequestParam(value = "fatherName", required = false) String fatherName,
            @RequestParam(value = "diagnosis", required = false) String diagnosis,
            @RequestParam(value = "icdCode", required = false) String icdCode,
            @RequestParam(value = "nameOfPresenter", required = false) String nameOfPresenter,
            @RequestParam(value = "pdate", required = false) String pdate,
            @RequestParam(value = "award", required = false) String award,
            @RequestParam(value = "abed", required = false) String abed,
            @RequestParam(value = "unit", required = false) String unit) {
        User u = Context.getAuthenticatedUser();
        System.out.println("*************888" + patientId);
        Patient patient = Context.getPatientService().getPatient(patientId);

        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        Date preDate = null;

        try {
            preDate = sdf.parse(pdate);
        } catch (ParseException e) {
            e.printStackTrace();
        }

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

        selectPatient.setCreatedDate(new Date());
        selectPatient.setUserId(u);
        caseSumService.saveSlectPatient(selectPatient);

        return "redirect:/module/casesummary/main.form";
    }

    @RequestMapping(value = "/module/casesummary/selectedPatient.htm", method = RequestMethod.GET)
    public String selectedPatient(ModelMap model) {
        User u = Context.getAuthenticatedUser();
        model.addAttribute("u", u);
        

        return "module/casesummary/patientSearch/selectedPatient";
    }

}
