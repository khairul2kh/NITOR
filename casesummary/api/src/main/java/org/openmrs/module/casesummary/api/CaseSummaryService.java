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
package org.openmrs.module.casesummary.api;

import java.util.Date;
import java.util.List;
import org.openmrs.api.APIException;
import org.openmrs.api.OpenmrsService;
import org.openmrs.module.casesummary.model.DoctorProfile;
import org.openmrs.module.casesummary.model.FollowUp;
import org.openmrs.module.casesummary.model.OtNote;
import org.openmrs.module.casesummary.model.PatientSearchCs;
import org.openmrs.module.casesummary.model.SailentFeature;
import org.openmrs.module.casesummary.model.SelectPatient;
import org.openmrs.module.casesummary.model.Slide;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface CaseSummaryService extends OpenmrsService {

    public DoctorProfile saveDocPro(DoctorProfile doctorProfile) throws APIException;

    public DoctorProfile docProFindByUserId(int userId) throws APIException;

    public List<PatientSearchCs> patientSearchByIdName(String searchKey) throws APIException;

    public PatientSearchCs getPatientSerByPatientId(int id) throws APIException;

    public SelectPatient saveSlectPatient(SelectPatient selectPatient) throws APIException;

    public List<SelectPatient> listSelectPatientByUser(int userId) throws APIException;

    public SelectPatient getSelectPatiByPatientIdUsreId(int userId, int patientId) throws APIException;

    public SailentFeature saveSailentFeat(SailentFeature sailentFeature) throws APIException;

    public SelectPatient getSelPatientById(int id) throws APIException;

    public SailentFeature getSailentById(int id) throws APIException;

    public OtNote saveOtNote(OtNote otNote) throws APIException;

    public List<OtNote> listOtNote(int id) throws APIException;

    public Slide saveSlide(Slide slide) throws APIException;

    public List<SelectPatient> listSelPatientByDate(Date date) throws APIException;

    public List<Slide> listSlideBySelPatId(int id) throws APIException;

    public Slide getSlideLastId(int userId) throws APIException;

    public Slide getSlideById(int id) throws APIException;

    public FollowUp saveFollowUp(FollowUp followUp) throws APIException;

    public FollowUp getFollUpLastId(int userId) throws APIException;

    public FollowUp getFollowUpById(int id) throws APIException;

    public List<FollowUp> listFollUpBySelPatId(int id) throws APIException;

}
