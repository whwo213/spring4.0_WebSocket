package com.spring.mvc.file.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;

/**
 * Created by apple6268 on 16. 3. 27.
 */

@Service
public class FileService {
    public boolean fileUpload(MultipartHttpServletRequest mRequest) {

        boolean isSuccess = false;

        String uploadPath = "C:/Users/young/Downloads/";

        File dir = new File(uploadPath);


        if (!dir.isDirectory()) {

            dir.mkdirs();

        }

        Iterator<String> iter = mRequest.getFileNames();

        while(iter.hasNext()) {

            String uploadFileName = iter.next();

            MultipartFile mFile = mRequest.getFile(uploadFileName);

            String originalFileName = mFile.getOriginalFilename();

            String saveFileName = originalFileName;



            if(saveFileName != null && !saveFileName.equals("")) {

                if(new File(uploadPath + saveFileName).exists()) {

                    saveFileName = saveFileName + "_" + System.currentTimeMillis();

                }

                try {
                    System.out.println(uploadPath + new String(saveFileName.getBytes("iso-8859-1"), "utf-8"));

                    mFile.transferTo(new File(uploadPath + new String(saveFileName.getBytes("iso-8859-1"), "utf-8")));

                    isSuccess = true;

                } catch (IllegalStateException e) {

                    e.printStackTrace();

                    isSuccess = false;

                } catch (IOException e) {

                    e.printStackTrace();

                    isSuccess = false;

                }

            } // if end

        } // while end

        return isSuccess;

    } // fileUpload end
}
