/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.casesummary.model;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import org.openmrs.Patient;
import org.openmrs.User;

/**
 *
 * @author Khairul
 */
@Entity
@Table(name = "cs_select_patient")
public class SelectPatient implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private Patient patientId;
    private String address;
    private String fatherName;
    private String diagnosis;
    private String icdCode;
    private String nameOfPresenter;
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date presentationDate;
    private String admittedWard;
    private String admittedBed;
    private String unit;
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date createdDate;
    private User userId;
    private boolean status;

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Patient getPatientId() {
        return patientId;
    }

    public void setPatientId(Patient patientId) {
        this.patientId = patientId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getFatherName() {
        return fatherName;
    }

    public void setFatherName(String fatherName) {
        this.fatherName = fatherName;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public String getIcdCode() {
        return icdCode;
    }

    public void setIcdCode(String icdCode) {
        this.icdCode = icdCode;
    }

    public String getNameOfPresenter() {
        return nameOfPresenter;
    }

    public void setNameOfPresenter(String nameOfPresenter) {
        this.nameOfPresenter = nameOfPresenter;
    }

    public Date getPresentationDate() {
        return presentationDate;
    }

    public void setPresentationDate(Date presentationDate) {
        this.presentationDate = presentationDate;
    }

    public String getAdmittedWard() {
        return admittedWard;
    }

    public void setAdmittedWard(String admittedWard) {
        this.admittedWard = admittedWard;
    }

    public String getAdmittedBed() {
        return admittedBed;
    }

    public void setAdmittedBed(String admittedBed) {
        this.admittedBed = admittedBed;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public User getUserId() {
        return userId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }
    

    
    

}
