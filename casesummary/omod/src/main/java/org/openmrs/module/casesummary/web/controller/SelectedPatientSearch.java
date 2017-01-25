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
import liquibase.util.StringUtils;
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
import org.openmrs.module.casesummary.util.CSUtil;

/**
 *
 * @author Khairul
 */
@Controller
public class SelectedPatientSearch {

    protected final Log log = LogFactory.getLog(getClass());

    @Autowired
    CaseSummaryService caseSumService;

    @RequestMapping(value = "/module/casesummary/selectedPatientSerach.htm", method = RequestMethod.GET)
    public String selectedPatientSerarch(//@RequestParam(value = "sDate", required = false) String sDate,
            @RequestParam(value = "diagnosis", required = false) String diagnosis,
            @RequestParam(value = "patientId", required = false) String patientId,
            @RequestParam(value = "patientName", required = false) String patientName,
            @RequestParam(value = "contactNo", required = false) String contactNo,
            ModelMap model) {

        
        System.out.println("******"+patientId);
        
        String dia = CSUtil.validationDia(diagnosis);
        String paId = CSUtil.validationPaId(patientId);
        String paName = CSUtil.validationPaName(patientName);
        String contNo = CSUtil.validationConNo(contactNo);
        
        System.out.println("******"+paId);
        
        System.out.println("******"+paName);
         
        List<SelectPatient> listSelPat = caseSumService.listSelPatByIdName(patientId, paName, contNo, dia);

        model.addAttribute("listSelPat", listSelPat);

        System.out.println("******** listSelPat " + listSelPat.size());

        return "module/casesummary/ajax/selPatSearch";
    }
}

//        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
//        Date date = null;
//        try {
//            date = sdf.parse(sDate);
//        } catch (ParseException e) {
//            e.printStackTrace();
//        }
