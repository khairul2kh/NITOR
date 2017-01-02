/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.openmrs.module.casesummary.model;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import org.openmrs.module.casesummary.model.SelectPatient;

/**
 *
 * @author Khairul
 */
@Entity
@Table(name = "cs_sailent_feat")
public class SailentFeature {
    private static final long serialVersionUID = 1L;
    
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private String sailentFeature;
    private SelectPatient selectPatient;
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date createdDate;
    private int creator;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSailentFeature() {
        return sailentFeature;
    }

    public void setSailentFeature(String sailentFeature) {
        this.sailentFeature = sailentFeature;
    }

    public SelectPatient getSelectPatient() {
        return selectPatient;
    }

    public void setSelectPatient(SelectPatient selectPatient) {
        this.selectPatient = selectPatient;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public int getCreator() {
        return creator;
    }

    public void setCreator(int creator) {
        this.creator = creator;
    }
 
    
}
