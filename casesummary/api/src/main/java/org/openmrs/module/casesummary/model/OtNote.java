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

/**
 *
 * @author Khairul
 */
@Entity
@Table(name = "cs_ot_note")
public class OtNote implements Serializable {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private SelectPatient selectPatient;
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date date;
    private String time;
    private String nameOfOt;
    private String procedureDetail;
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date createdDate;
    private int creator;
    private String nameOfSurgeon;
    private String typeAnesthesia;

    public String getNameOfSurgeon() {
        return nameOfSurgeon;
    }

    public void setNameOfSurgeon(String nameOfSurgeon) {
        this.nameOfSurgeon = nameOfSurgeon;
    }

    public String getTypeAnesthesia() {
        return typeAnesthesia;
    }

    public void setTypeAnesthesia(String typeAnesthesia) {
        this.typeAnesthesia = typeAnesthesia;
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

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getNameOfOt() {
        return nameOfOt;
    }

    public void setNameOfOt(String nameOfOt) {
        this.nameOfOt = nameOfOt;
    }

    public String getProcedureDetail() {
        return procedureDetail;
    }

    public void setProcedureDetail(String procedureDetail) {
        this.procedureDetail = procedureDetail;
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
