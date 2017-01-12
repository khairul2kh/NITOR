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
@Table(name = "cs_follow_up")
public class FollowUp {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private SelectPatient selectPatient;
    private String diagnosis;
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date dateOfSurgery;
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date dateOfFollowUp;
    private String comment;
    private String subsequentPlan;
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date createdDate;
    private int creator;
    private String imgNameOne;
    private String imgNameTwo;

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

    public Date getDateOfSurgery() {
        return dateOfSurgery;
    }

    public void setDateOfSurgery(Date dateOfSurgery) {
        this.dateOfSurgery = dateOfSurgery;
    }

    public Date getDateOfFollowUp() {
        return dateOfFollowUp;
    }

    public void setDateOfFollowUp(Date dateOfFollowUp) {
        this.dateOfFollowUp = dateOfFollowUp;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getSubsequentPlan() {
        return subsequentPlan;
    }

    public void setSubsequentPlan(String subsequentPlan) {
        this.subsequentPlan = subsequentPlan;
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
    

}
