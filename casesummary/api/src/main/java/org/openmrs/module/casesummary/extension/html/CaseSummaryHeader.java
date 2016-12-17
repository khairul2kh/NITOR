/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.casesummary.extension.html;

/**
 *
 * @author Khairul
 */
import org.openmrs.module.Extension;

public class CaseSummaryHeader extends Extension {

    @Override
    public MEDIA_TYPE getMediaType() {
        return MEDIA_TYPE.html;
    }
    public String getRequiredPrivilege() {
        return "Access Case Summary";
    }

    public String getLabel() {
        return "casesummary.title";
    }

    public String getUrl() {
        return "/module/casesummary/manage.form";
    }
}
