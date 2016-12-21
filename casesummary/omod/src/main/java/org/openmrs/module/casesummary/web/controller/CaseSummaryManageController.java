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
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.User;
import org.openmrs.api.context.Context;
import org.openmrs.module.casesummary.api.CaseSummaryService;
import org.openmrs.module.casesummary.model.DoctorProfile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * The main controller.
 */
@Controller
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
        map.put("user", Context.getAuthenticatedUser());

        User u = Context.getAuthenticatedUser();
        model.addAttribute("u", u);

        return "module/casesummary/main/mainpage";
    }

    @RequestMapping(value = "/module/casesummary/addDoctor.htm", method = RequestMethod.POST)
    public String createDocProfile(@ModelAttribute("birthRegistration") DoctorProfile doctorProfile,
            BindingResult result) {

        doctorProfile.setCreatedDate(new Date());
        caseSumService.saveDocPro(doctorProfile);

        return "/module/casesummary/main.from";

    }

//    @RequestMapping(value = "/module/casesummary/createDoctor.htm", method = RequestMethod.POST)
//    public ResponseEntity<Void> createUser(@RequestBody DoctorProfile doctorProfile, UriComponentsBuilder ucBuilder) {
//        //System.out.println("Creating User " + user.getUsername());
//
//        if (userService.isUserExist(user)) {
//            System.out.println("A User with name " + user.getUsername() + " already exist");
//            return new ResponseEntity<Void>(HttpStatus.CONFLICT);
//        }
//
//        userService.saveUser(user);
//
//        HttpHeaders headers = new HttpHeaders();
//        headers.setLocation(ucBuilder.path("/user/{id}").buildAndExpand(user.getId()).toUri());
//        return new ResponseEntity<Void>(headers, HttpStatus.CREATED);
//    }
}

/*
public String addCerficate(@ModelAttribute("birthRegistration") 
BirthRegistration birthRegistration, BindingResult result) {
        User u = Context.getAuthenticatedUser();
        birthRegistration.setCreator(u);
        birthRegistration.setCreatedDate(new Date());
        birthCertificateService.addbirthCertificate(birthRegistration);
        return "redirect:/module/birthcertificate/birthView.htm?id=" + birthRegistration.getId();
    }
*/
