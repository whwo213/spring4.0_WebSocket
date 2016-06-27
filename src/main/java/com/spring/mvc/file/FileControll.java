package com.spring.mvc.file;

import com.spring.mvc.file.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.util.Iterator;

/**
 * Created by apple6268 on 16. 3. 28.
 */
@Controller
public class FileControll {

    @Autowired
    private FileService fileService;

    @RequestMapping(value = { "/file"}, method = RequestMethod.POST)
    public ModelAndView defaultPage3(MultipartHttpServletRequest mRequest) {
        System.out.println("fileService");

        ModelAndView mav = new ModelAndView();
        String uploadPath = "C:/Users/young/Downloads/";


        Iterator<String> iter = mRequest.getFileNames();

        while (iter.hasNext()){
            String uploadFileName = iter.next();

            MultipartFile mFile = mRequest.getFile(uploadFileName);

            String originalFileName = mFile.getOriginalFilename();

            String saveFileName = originalFileName;

            if(saveFileName != null && !saveFileName.equals("")) {

                if(new File(uploadPath + saveFileName).exists()) {
                    saveFileName = saveFileName + "_" + System.currentTimeMillis();
                }

                System.out.println(originalFileName);
                System.out.println(saveFileName);
                System.out.println(mFile.getSize());
                System.out.println(mFile.getName());


            } // if end
        }


        if(fileService.fileUpload(mRequest)) {

            mav.addObject("result", "SUCCESS");

        } else {

            mav.addObject("result", "FAIL");

        }



        mav.setViewName("file");



        return mav;

    }
}
