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
package org.openmrs.module.casesummary.api.db;

import java.util.Date;
import java.util.List;
import org.openmrs.api.db.DAOException;
import org.openmrs.module.casesummary.api.CaseSummaryService;
import org.openmrs.module.casesummary.model.DoctorProfile;
import org.openmrs.module.casesummary.model.FollowUp;
import org.openmrs.module.casesummary.model.OtNote;
import org.openmrs.module.casesummary.model.PatientSearchCs;
import org.openmrs.module.casesummary.model.SailentFeature;
import org.openmrs.module.casesummary.model.SelectPatient;
import org.openmrs.module.casesummary.model.Slide;


public interface CaseSummaryDAO {

    public DoctorProfile saveDocPro(DoctorProfile doctorProfile) throws DAOException;

    public DoctorProfile docProFindByUserId(int userId) throws DAOException;

    public List<PatientSearchCs> patientSearchByIdName(String searchKey) throws DAOException;

    public PatientSearchCs getPatientSerByPatientId(int id) throws DAOException;
    
    public SelectPatient saveSlectPatient(SelectPatient selectPatient)throws DAOException;
    
    public List<SelectPatient> listSelectPatientByUser(int userId)throws DAOException;
    
    public SelectPatient getSelectPatiByPatientIdUsreId(int userId, int patientId)throws DAOException;
    
    public SailentFeature saveSailentFeat(SailentFeature sailentFeature)throws DAOException;
    
    public SelectPatient getSelPatientById(int id)throws DAOException;
    
    public SailentFeature getSailentById(int id)throws DAOException;
    
    public OtNote saveOtNote(OtNote otNote)throws DAOException;
    
    public List<OtNote> listOtNote(int id)throws DAOException;
    
    public Slide saveSlide(Slide slide)throws DAOException;
    
    public List<SelectPatient> listSelPatientByDate(Date date)throws DAOException;
    
    public List<Slide> listSlideBySelPatId(int id)throws DAOException;
    
    public Slide getSlideLastId(int userId)throws DAOException;
    
    public Slide getSlideById(int id)throws DAOException;
    
    public FollowUp saveFollowUp(FollowUp followUp) throws DAOException;

    public FollowUp getFollUpLastId(int userId) throws DAOException;

    public FollowUp getFollowUpById(int id) throws DAOException;

    public List<FollowUp> listFollUpBySelPatId(int id) throws DAOException;
    
}
