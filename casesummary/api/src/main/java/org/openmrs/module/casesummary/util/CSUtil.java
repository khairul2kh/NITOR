/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.casesummary.util;

/**
 *
 * @author Khairul
 */
public class CSUtil {

    public static String validationDia(String diagnosis) {
        String dia = null;

        if (diagnosis == "") {
            dia = "";
        } else {
            dia = diagnosis;
        }
        return dia;
    }

    public static String validationPaName(String patientName) {
        String pa = null;
        if (patientName == "") {
            pa = "";
        } else {
            pa = patientName;
        }
        return pa;
    }

    public static String validationPaId(String patientId) {
        String paId = null;
        if (patientId == "") {
            paId = "";
        } else {
            paId = patientId;
        }
        return paId;
    }

    public static String validationConNo(String contactNo) {
        String con = null;
        if (contactNo == "") {
            con = "";
        } else {
            con = contactNo;
        }
        return con;
    }

}
