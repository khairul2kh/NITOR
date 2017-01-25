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
package org.openmrs.module.casesummary.api.impl;

import java.util.Date;
import java.util.List;
import org.openmrs.api.impl.BaseOpenmrsService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.api.APIException;
import org.openmrs.module.casesummary.api.CaseSummaryService;
import org.openmrs.module.casesummary.api.db.CaseSummaryDAO;
import org.openmrs.module.casesummary.model.DoctorProfile;
import org.openmrs.module.casesummary.model.FollowUp;
import org.openmrs.module.casesummary.model.OtNote;
import org.openmrs.module.casesummary.model.PatientSearchCs;
import org.openmrs.module.casesummary.model.SailentFeature;
import org.openmrs.module.casesummary.model.SelectPatient;
import org.openmrs.module.casesummary.model.Slide;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * It is a default implementation of {@link CaseSummaryService}.
 */
@Service
public class CaseSummaryServiceImpl extends BaseOpenmrsService implements CaseSummaryService {

    protected final Log log = LogFactory.getLog(this.getClass());

    @Autowired
    private CaseSummaryDAO dao;

    public void setDao(CaseSummaryDAO dao) {
        this.dao = dao;
    }

    public CaseSummaryDAO getDao() {
        return dao;
    }

    @Override
    public DoctorProfile saveDocPro(DoctorProfile doctorProfile) throws APIException {
        return dao.saveDocPro(doctorProfile);
    }

    @Override
    public DoctorProfile docProFindByUserId(int userId) throws APIException {
        return dao.docProFindByUserId(userId);
    }

    @Override
    public List<PatientSearchCs> patientSearchByIdName(String searchKey) throws APIException {
        return dao.patientSearchByIdName(searchKey);
    }

    @Override
    public PatientSearchCs getPatientSerByPatientId(int id) throws APIException {
        return dao.getPatientSerByPatientId(id);
    }

    @Override
    public SelectPatient saveSlectPatient(SelectPatient selectPatient) throws APIException {
        return dao.saveSlectPatient(selectPatient);
    }

    @Override
    public List<SelectPatient> listSelectPatientByUser(int userId) throws APIException {
        return dao.listSelectPatientByUser(userId);
    }

    @Override
    public SelectPatient getSelectPatiByPatientIdUsreId(int userId, int patientId) throws APIException {
        return dao.getSelectPatiByPatientIdUsreId(userId, patientId);
    }

    @Override
    public SailentFeature saveSailentFeat(SailentFeature sailentFeature) throws APIException {
        return dao.saveSailentFeat(sailentFeature);
    }

    @Override
    public SelectPatient getSelPatientById(int id) throws APIException {
        return dao.getSelPatientById(id);
    }

    @Override
    public SailentFeature getSailentById(int id) throws APIException {
        return dao.getSailentById(id);
    }

    @Override
    public OtNote saveOtNote(OtNote otNote) throws APIException {
        return dao.saveOtNote(otNote);
    }

    @Override
    public List<OtNote> listOtNote(int id) throws APIException {
        return dao.listOtNote(id);
    }

    @Override
    public Slide saveSlide(Slide slide) throws APIException {
        return dao.saveSlide(slide);
    }

    @Override
    public List<SelectPatient> listSelPatientByDate(Date date) throws APIException {
        return dao.listSelPatientByDate(date);
    }

    @Override
    public List<Slide> listSlideBySelPatId(int id) throws APIException {
        return dao.listSlideBySelPatId(id);
    }

    @Override
    public Slide getSlideLastId(int userId) throws APIException {
        return dao.getSlideLastId(userId);
    }

    @Override
    public Slide getSlideById(int id) throws APIException {
        return dao.getSlideById(id);
    }

    @Override
    public FollowUp saveFollowUp(FollowUp followUp) throws APIException {
        return dao.saveFollowUp(followUp);
    }

    @Override
    public FollowUp getFollUpLastId(int userId) throws APIException {
        return dao.getFollUpLastId(userId);
    }

    @Override
    public FollowUp getFollowUpById(int id) throws APIException {
        return dao.getFollowUpById(id);
    }

    @Override
    public List<FollowUp> listFollUpBySelPatId(int id) throws APIException {
        return dao.listFollUpBySelPatId(id);
    }

    @Override
    public List<SelectPatient> listSelectPatientBySearch(Date date, String patientId, String patientName, String contactNo) throws APIException {
        return dao.listSelectPatientBySearch(date, patientId, patientName, contactNo);
    }

    @Override
    public List<SelectPatient> listSelPatByIdName(String patientId, String patientName, String contactNo, String diagnosis) throws APIException {
        return dao.listSelPatByIdName(patientId, patientName, contactNo, diagnosis);
    }

}
