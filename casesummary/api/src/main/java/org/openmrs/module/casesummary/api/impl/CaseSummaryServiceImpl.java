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

import java.util.List;
import org.openmrs.api.impl.BaseOpenmrsService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.api.APIException;
import org.openmrs.module.casesummary.api.CaseSummaryService;
import org.openmrs.module.casesummary.api.db.CaseSummaryDAO;
import org.openmrs.module.casesummary.model.DoctorProfile;
import org.openmrs.module.casesummary.model.PatientSearchCs;
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

}
