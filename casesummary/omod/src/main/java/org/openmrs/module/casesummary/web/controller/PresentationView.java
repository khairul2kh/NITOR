/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.openmrs.module.casesummary.web.controller;

import java.util.List;
import org.openmrs.User;
import org.openmrs.api.context.Context;
import org.openmrs.module.casesummary.api.CaseSummaryService;
import org.openmrs.module.casesummary.model.DoctorProfile;
import org.openmrs.module.casesummary.model.FollowUp;
import org.openmrs.module.casesummary.model.OtNote;
import org.openmrs.module.casesummary.model.SailentFeature;
import org.openmrs.module.casesummary.model.SelectPatient;
import org.openmrs.module.casesummary.model.Slide;
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
public class PresentationView {
    
    @Autowired
    CaseSummaryService caseSumService;
    
    @RequestMapping(value = "/module/casesummary/selectPatientSlide.htm", method = RequestMethod.GET)
    public String selectPatientSlide(@RequestParam(value = "id", required = false) int id,
            @RequestParam(value="view",required = false)int view,
            ModelMap model) {
        User u = Context.getAuthenticatedUser();
        model.addAttribute("u", u);
        model.addAttribute("view",view);

        SelectPatient sp = caseSumService.getSelPatientById(id);
        model.addAttribute("sp", sp);
        model.addAttribute("age", sp.getPatientId().getAge());
        model.addAttribute("sex", sp.getPatientId().getGender());

        System.out.println("userId*********" + sp.getUserId().getId());

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

        sp.setStatus(true);
        caseSumService.saveSlectPatient(sp);

        return "module/casesummary/presentation/readyPresentation";
    }
    
    
}
