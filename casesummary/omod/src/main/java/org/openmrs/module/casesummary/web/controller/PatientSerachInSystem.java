/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.casesummary.web.controller;

import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.User;
import org.openmrs.api.context.Context;
import org.openmrs.module.casesummary.api.CaseSummaryService;
import org.openmrs.module.casesummary.model.PatientSearchCs;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
        
        PatientSearchCs ps=caseSumService.getPatientSerByPatientId(patientId);
        model.addAttribute("ps",ps);

        return "module/casesummary/patientSearch/selectPatient";
    }
}
