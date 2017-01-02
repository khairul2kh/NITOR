/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.casesummary.web.controller;

import java.util.Date;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.module.casesummary.api.CaseSummaryService;
import org.openmrs.module.casesummary.model.DoctorProfile;
import org.openmrs.module.casesummary.model.SailentFeature;
import org.openmrs.module.casesummary.model.SelectPatient;
import org.openmrs.scheduler.tasks.AbstractTask;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author Khairul
 */
public class DataTest extends AbstractTask {

    @Autowired
    CaseSummaryService caseSumService;
    
    private Log log = LogFactory.getLog(DataTest.class);

    @Override
    public void execute() {
        SailentFeature sf=new SailentFeature();
        sf.setSailentFeature("sdfdsf");
        caseSumService.saveSailentFeat(sf);
       
        System.out.println("*********************");
    }

}
