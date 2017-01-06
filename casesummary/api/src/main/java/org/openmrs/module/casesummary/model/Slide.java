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

/**
 *
 * @author Khairul
 */
@Entity
@Table(name = "cs_slide")
public class Slide {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private SelectPatient selectPatient;
    private String diagnosis;
    private String plan;
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date createdDate;
    private int creator;
    private String imgNameOne;
    private String imgNameTwo;

    public String getImgNameOne() {
        return imgNameOne;
    }

    public void setImgNameOne(String imgNameOne) {
        this.imgNameOne = imgNameOne;
    }

    public String getImgNameTwo() {
        return imgNameTwo;
    }

    public void setImgNameTwo(String imgNameTwo) {
        this.imgNameTwo = imgNameTwo;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public SelectPatient getSelectPatient() {
        return selectPatient;
    }

    public void setSelectPatient(SelectPatient selectPatient) {
        this.selectPatient = selectPatient;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public String getPlan() {
        return plan;
    }

    public void setPlan(String plan) {
        this.plan = plan;
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
