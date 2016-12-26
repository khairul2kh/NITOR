/**
 * The contents of this file are subject to the OpenMRS Public License Version
 * 1.0 (the "License"); you may not use this file except in compliance with the
 * License. You may obtain a copy of the License at http://license.openmrs.org
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 * the specific language governing rights and limitations under the License.
 *
 * Copyright (C) OpenMRS, LLC. All Rights Reserved.
 */
package org.openmrs.module.casesummary.web.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.User;
import org.openmrs.api.context.Context;
import org.openmrs.module.casesummary.api.CaseSummaryService;
import org.openmrs.module.casesummary.model.DoctorProfile;
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
//import org.springframework.web.bind.annotation.RestController;

/**
 * The main controller.
 */
@Controller
//@RestController
public class CaseSummaryManageController {

    protected final Log log = LogFactory.getLog(getClass());

    //CaseSummaryService css = Context.getService(CaseSummaryService.class);
    @Autowired
    CaseSummaryService caseSumService;

    @RequestMapping(value = "/module/casesummary/manage", method = RequestMethod.GET)
    public void manage(ModelMap model) {
        model.addAttribute("user", Context.getAuthenticatedUser());
    }

    @RequestMapping(value = "/module/casesummary/main.form", method = RequestMethod.GET)
    public String mainPage(Map<String, Object> map, Model model) {
        User user = Context.getAuthenticatedUser();
        map.put("user", user);
        DoctorProfile docPro = caseSumService.docProFindByUserId(user.getId());
        model.addAttribute("docPro", docPro);
        User u = Context.getAuthenticatedUser();
        model.addAttribute("u", u);
        return "module/casesummary/main/mainpage";
    }

    @RequestMapping(value = "/module/casesummary/createDoctor.htm", method = RequestMethod.POST)
    public ResponseEntity<Void> createUser(@RequestBody DoctorProfile doctorProfile) {
        //System.out.println("Creating User " + user.getUsername());
        doctorProfile.setCreatedDate(new Date());
        doctorProfile.setUser(Context.getAuthenticatedUser());
        caseSumService.saveDocPro(doctorProfile);
        HttpHeaders headers = new HttpHeaders();
        // headers.setLocation(ucBuilder.path("/user/{id}").buildAndExpand(user.getId()).toUri());
        return new ResponseEntity<Void>(headers, HttpStatus.CREATED);
    }

//    @RequestMapping(value = "/module/casesummary/findDocPro.htm", method = RequestMethod.GET)
//    public ResponseEntity<DoctorProfile> getDocPro(@PathVariable("id") int userId) {
//        //System.out.println("Creating User " + user.getUsername());
//        DoctorProfile docPro = caseSumService.docProFindByUserId(userId);
//        if (docPro == null) {
//            System.out.println("Doctor profile" + userId + "Not found");
//            return new ResponseEntity<DoctorProfile>(docPro, HttpStatus.NOT_FOUND);
//        }
//        return new ResponseEntity<DoctorProfile>(docPro, HttpStatus.OK);
//    }
//
//    @RequestMapping(value = "/module/casesummary/findDoc.htm", method = RequestMethod.GET)
//    public String listCertificate(@RequestParam(value = "id", required = false) int id,
//            Model model) {
//        // map.put("registration", new BirthRegistration());
//        DoctorProfile docPro = caseSumService.docProFindByUserId(id);
//        model.addAttribute("docPro", docPro);
//        System.out.println("*********docPro" + docPro);
//
//        return "module/casesummary/main/docUpdate";
//
//    }
 
    
    @RequestMapping(value = "/module/casesummary/update.form", method = RequestMethod.POST)
    public String updateDoc( 
            @ModelAttribute("doctorProfile") DoctorProfile doctorProfile, BindingResult result,
            @RequestParam(value = "id", required = false) int id,
            @RequestParam(value = "doctorName", required = false) String docName,
            @RequestParam(value = "designation", required = false) String designation,
            @RequestParam(value = "course", required = false) String course,
            @RequestParam(value = "session", required = false) String session) {
       
        doctorProfile=caseSumService.docProFindByUserId(id);
        doctorProfile.setDoctorName(docName);
        doctorProfile.setDesignation(designation);
        doctorProfile.setCourse(course);
        doctorProfile.setSession(session);
        caseSumService.saveDocPro(doctorProfile);
                
        return "module/casesummary/thickbox/success_1";
    }
   
}

 