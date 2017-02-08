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
import org.openmrs.module.casesummary.model.FollowUp;
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
public class SelectedPatientSingle {

    @Autowired
    CaseSummaryService caseSumService;

    @RequestMapping(value = "/module/casesummary/selectedPatientSingle.htm", method = RequestMethod.GET)
    public String selectedPatientSingle(@RequestParam("patientId") int patientId,
            @RequestParam(value = "id", required = false) int id,
            ModelMap model) {

        User u = Context.getAuthenticatedUser();
        model.addAttribute("u", u);
        SelectPatient sp = null;
        if (id == 0) {
            sp = caseSumService.getSelectPatiByPatientIdUsreId(u.getId(), patientId);
        } else {
            sp = caseSumService.getSelPatientById(id);
        }

        model.addAttribute("sp", sp);
        model.addAttribute("age", sp.getPatientId().getAge());
        SailentFeature sf = caseSumService.getSailentById(sp.getId());
        model.addAttribute("sf", sf);
        List<OtNote> listOtNote = caseSumService.listOtNote(sp.getId());
        model.addAttribute("listOtNote", listOtNote);

        List<Slide> listSlide = caseSumService.listSlideBySelPatId(sp.getId());
        model.addAttribute("listSlide", listSlide);
        
        List<FollowUp> listFollUp = caseSumService.listFollUpBySelPatId(sp.getId());
        model.addAttribute("listFollUp", listFollUp);

        return "module/casesummary/patientSearch/selectedPatientSingle";
    }

}
