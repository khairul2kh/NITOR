/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.casesummary.web.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.User;
import org.openmrs.api.context.Context;
import org.openmrs.module.casesummary.api.CaseSummaryService;
import org.openmrs.module.casesummary.model.DoctorProfile;
import org.openmrs.module.casesummary.model.OtNote;
import org.openmrs.module.casesummary.model.SailentFeature;
import org.openmrs.module.casesummary.model.SelectPatient;
import org.openmrs.module.casesummary.model.Slide;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 *
 * @author Khairul
 */
@Controller("CaseSumAjaxController")
public class CaseSummaryAjaxController {

    protected final Log log = LogFactory.getLog(getClass());

    private static final long serialVersionUID = 1L;
    public static final String SAVE_LOCATION = "C:/ImagesFolder/";

    User u = Context.getAuthenticatedUser();

    //   public static final String SAVE_LOCATION = "/root/ImagesFolder/";
    public static Integer file_name = 0;
    public static Integer slide_id = 0;

    @Autowired
    CaseSummaryService caseSumService;

    @RequestMapping(value = "/module/casesummary/sailentFeatSave.htm", method = RequestMethod.POST)
    public void sailentFeatSave(
            @RequestParam(value = "id", required = false) int id,
            @RequestParam(value = "sailentFeat", required = false) String sailentFeat,
            @RequestParam(value = "unit", required = false) String unit) {
        User u = Context.getAuthenticatedUser();

        SelectPatient sp = caseSumService.getSelPatientById(id);
        System.out.println("****************" + id);
        System.out.println("****************" + sp);
        SailentFeature sailentFeature = caseSumService.getSailentById(sp.getId());
        System.out.println("****************" + sailentFeature);
        if (sailentFeature == null) {
            SailentFeature sf = new SailentFeature();
            sf.setSelectPatient(sp);
            sf.setSailentFeature(sailentFeat);
            sf.setCreatedDate(new Date());
            sf.setCreator(u.getUserId());
            caseSumService.saveSailentFeat(sf);
        } else {
            sailentFeature.setSailentFeature(sailentFeat);
            caseSumService.saveSailentFeat(sailentFeature);
        }
        System.out.println("****************" + sailentFeature);
        //return "/module/casesummary/selectedPatientSingle";
    }

    @RequestMapping(value = "/module/casesummary/otNoteSave.htm", method = RequestMethod.POST)
    public void otNoteSave(
            @RequestParam(value = "id", required = false) int id,
            @RequestParam(value = "date", required = false) String date,
            @RequestParam(value = "time", required = false) String time,
            @RequestParam(value = "nameOfOt", required = false) String nameOfOt,
            @RequestParam(value = "nameOfSur", required = false) String nameOfSur,
            @RequestParam(value = "typeAnest", required = false) String typeAnest,
            @RequestParam(value = "procDet", required = false) String procedureDetail) {
        User u = Context.getAuthenticatedUser();
        SelectPatient sp = caseSumService.getSelPatientById(id);

        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        Date dateCon = null;

        try {
            dateCon = sdf.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        System.out.println("*************" + dateCon);

        OtNote on = new OtNote();
        on.setSelectPatient(sp);
        on.setDate(dateCon);
        on.setTime(time);
        on.setNameOfOt(nameOfOt);
        on.setProcedureDetail(procedureDetail);
        on.setNameOfSurgeon(nameOfSur);
        on.setTypeAnesthesia(typeAnest);
        on.setCreatedDate(new Date());
        on.setCreator(u.getUserId());
        caseSumService.saveOtNote(on);

        //return "/module/casesummary/selectedPatientSingle";
    }

    @RequestMapping(value = "/module/casesummary/otnoteajax.htm", method = RequestMethod.GET)
    public String selectedPatientSingle(@RequestParam("patientId") int patientId, ModelMap model) {
       // User u = Context.getAuthenticatedUser();
        model.addAttribute("u", u);
        int userId = u.getUserId();
        SelectPatient sp = caseSumService.getSelectPatiByPatientIdUsreId(userId, patientId);

        List<OtNote> listOtNote = caseSumService.listOtNote(sp.getId());
        model.addAttribute("listOtNote", listOtNote);
        return "module/casesummary/ajax/otnoteresult";
    }

    @RequestMapping(value = "/module/casesummary/slideSave.htm", method = RequestMethod.POST)
    public void slideSave(
            @RequestParam(value = "id", required = false) int id,
            @RequestParam(value = "diagnosis", required = false) String diagnosis,
            @RequestParam(value = "plan", required = false) String plan,
            Model model) throws IOException {

        SelectPatient sp = caseSumService.getSelPatientById(id);
        Slide s = new Slide();
        s.setSelectPatient(sp);
        s.setPlan(plan);
        s.setDiagnosis(diagnosis);
        s.setCreator(u.getUserId());
        s.setCreatedDate(new Date());
        caseSumService.saveSlide(s);
        file_name = sp.getId();

        System.out.println("******************Test--" + file_name);

    }

    @RequestMapping(value = "/module/casesummary/pictureSave.htm", method = RequestMethod.POST)
    public void FileUpload(@RequestParam("imgInp") MultipartFile multipartFile,
            @RequestParam("imgInp1") MultipartFile multipartFile1,
            HttpServletRequest request, HttpServletResponse response,
            Model model) {
        
        Slide slide = caseSumService.getSlideLastId(u.getUserId());
        
        Calendar now = Calendar.getInstance();
        String curYear = String.valueOf(now.get(Calendar.YEAR));
        
        String fullName=file_name.toString()+"-"+slide.getId()+"-"+curYear;
        
        long fileSize = multipartFile.getSize();
        String fileName = multipartFile.getOriginalFilename();
        if ((multipartFile != null && multipartFile.getSize() > 0)) {
            if (saveFile(multipartFile, request)) {
               
                slide.setImgNameOne(fullName+"-"+fileName);
                caseSumService.saveSlide(slide);
            }
        }

        long fileSize1 = multipartFile1.getSize();
        String fileName1 = multipartFile1.getOriginalFilename();

        if ((multipartFile1 != null && multipartFile1.getSize() > 0)) {
            if (saveFile(multipartFile1, request)) {
                
                slide.setImgNameTwo(fullName+"-"+fileName1);
                caseSumService.saveSlide(slide);
            }
        }
    }

    public boolean saveFile(MultipartFile multipartFile, HttpServletRequest request) {
        String fileLocation = request.getSession().getServletContext().getRealPath("/imageFolder/");
        boolean result = false;
        String fileName = multipartFile.getOriginalFilename();
        File pathFile = new File(fileLocation);
        if (!pathFile.exists()) {
            pathFile.mkdir();
        }
        Calendar now = Calendar.getInstance();
        String curYear = String.valueOf(now.get(Calendar.YEAR));

        Slide s = caseSumService.getSlideLastId(u.getUserId());

        pathFile = new File(pathFile
                + File.separator
                + file_name.toString()
                + "-"
                + s.getId()
                + "-"
                + curYear
                + "-"
                + fileName);
         String st = Integer.toString(s.getId());
        //save the actual file
        try {
            multipartFile.transferTo(pathFile);
            result = true;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping(value = "/module/casesummary/listSelectPat.htm", method = RequestMethod.GET)
    public String serachPatient(@RequestParam(value = "pdate", required = false) String pdate,
            ModelMap model) {

        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        //SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = null;
        try {
            date = sdf.parse(pdate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<SelectPatient> listSP = caseSumService.listSelPatientByDate(date);
        model.addAttribute("listSelPat", listSP);

        return "module/casesummary/presentation/finalPresentationList";
    }

    @RequestMapping(value = "/module/casesummary/selectPatientSlide.htm", method = RequestMethod.GET)
    public String selectPatientSlide(@RequestParam(value = "id", required = false) int id,
            ModelMap model) {
        User u = Context.getAuthenticatedUser();
        model.addAttribute("u", u);

        DoctorProfile dp = caseSumService.docProFindByUserId(u.getUserId());
        model.addAttribute("dp", dp);

        SelectPatient sp = caseSumService.getSelPatientById(id);
        model.addAttribute("sp", sp);
        model.addAttribute("age", sp.getPatientId().getAge());
        model.addAttribute("sex", sp.getPatientId().getGender());

        SailentFeature sf = caseSumService.getSailentById(id);
        model.addAttribute("sf", sf);

        List<Slide> listSlide = caseSumService.listSlideBySelPatId(id);
        model.addAttribute("listSlide", listSlide);
        
        List<OtNote> otNote=caseSumService.listOtNote(id);
        model.addAttribute("listOtNote", otNote);
        
        sp.setStatus(true);
        caseSumService.saveSlectPatient(sp);

        return "module/casesummary/presentation/readyPresentation";
    }

}
