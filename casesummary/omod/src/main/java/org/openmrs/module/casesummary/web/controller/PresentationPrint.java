/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.casesummary.web.controller;

import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.module.casesummary.api.CaseSummaryService;
import org.openmrs.module.casesummary.model.DoctorProfile;
import org.openmrs.module.casesummary.model.FollowUp;
import org.openmrs.module.casesummary.model.OtNote;
import org.openmrs.module.casesummary.model.SailentFeature;
import org.openmrs.module.casesummary.model.SelectPatient;
import org.openmrs.module.casesummary.model.Slide;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author Khairul
 */
@Controller
public class PresentationPrint {

    protected final Log log = LogFactory.getLog(getClass());

    @Autowired
    CaseSummaryService caseSumService;

    @RequestMapping(value = "/module/casesummary/presentationPrint.htm", method = RequestMethod.GET)
    public String selectedPatientSerarch(@RequestParam(value = "id", required = false) int id,
            @RequestParam(value = "preIn", required = false) String preIn,
            @RequestParam(value = "patIn", required = false) String patIn,
            @RequestParam(value = "sliIn", required = false) String sliIn,
            @RequestParam(value = "otIn", required = false) String otIn,
            @RequestParam(value = "folIn", required = false) String folIn,
            Model model) {

        SelectPatient sp = caseSumService.getSelPatientById(id);
        model.addAttribute("sp", sp);
        model.addAttribute("age", sp.getPatientId().getAge());
        model.addAttribute("sex", sp.getPatientId().getGender());
 
        DoctorProfile dp = caseSumService.docProFindByUserId(sp.getUserId().getId());
        model.addAttribute("dp", dp);

        SailentFeature sf = caseSumService.getSailentById(id);
        model.addAttribute("sf", sf);

        List<Slide> listSlide = caseSumService.listSlideBySelPatId(id);
        model.addAttribute("listSlide", listSlide);

        List<OtNote> otNote = caseSumService.listOtNote(id);
        model.addAttribute("listOtNote", otNote);

        List<FollowUp> listFollUp = caseSumService.listFollUpBySelPatId(id);
        model.addAttribute("listFollUp", listFollUp);

        model.addAttribute("preIn", preIn);
        model.addAttribute("patIn", patIn);
        model.addAttribute("sliIn", sliIn);
        model.addAttribute("otIn", otIn);
        model.addAttribute("folIn", folIn);
        
        return "module/casesummary/presentation/presentationPrint";

    }
}
