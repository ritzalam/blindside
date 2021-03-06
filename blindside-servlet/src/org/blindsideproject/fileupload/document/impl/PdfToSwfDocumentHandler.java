package org.blindsideproject.fileupload.document.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.ConnectException;
import java.util.ArrayList;
import java.util.Iterator;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
/**
 * Class to convert pdf slide presentation files to swf format slide.
 * It invokes tools to do operations like pdfExtractor and swftoolConverter.
 * [pdfExtractor: splits pdf presentation slide pages into single page pdf files]  
 * [swftoolConverter: converts pdf to swf]
 * 			  
 * 
 * @author ritzalam 
 *
 */
public class PdfToSwfDocumentHandler {
	private static final Log logger = LogFactory.getLog(PdfToSwfDocumentHandler.class);
	// message sender used to send messages to blindside server using ActiveMQ
	private UpdatesMessageSender updatesMsgSender = null;
	
	// used to invoke the tools to do the operations
	private String swftoolConverter;
	private String pdfExtractor;
	private Integer room;
	/**
	 * Setter for message sender used to send messages to blindside server using ActiveMQ.
	 * @param updatesMsgSender
	 */
    public void setUpdatesMsgSender(UpdatesMessageSender updatesMsgSender) {
		this.updatesMsgSender = updatesMsgSender;
	}
    /**
     * Setter for swftoolConverter name to be used to generate command to invoke the tool.
     * @param swftoolConverter
     */
	public void setSwftoolConverter(String swftoolConverter) {
		this.swftoolConverter = swftoolConverter;
	}
	/**
     * Setter for PdfExtractor name to be used to generate command to invoke the tool.
     * @param pdfExtractor
     */
	public void setpdfExtractor(String pdfExtractor) {
		this.pdfExtractor = pdfExtractor;
	}
	/**
	 * Convert all the presentation slide from source directory, to swf format(for the conference room given).
	 * First by splitting it into single page pdf files and saving them in destination directory.
	 * And then converting them to SWF files by invoking convertPDFtoSWF() on every pdf file in source directory.
	 * 
	 * @param room conference ID
	 * @param fileSource source directory where pdf files are.
	 * @param destDir destination directory
	 */
    public synchronized void convert(Integer room, File fileSource, File destDir) {
    	this.room = room;
    	
        updatesMsgSender.sendMessage(room, ReturnCode.UPDATE, "Generating slides.");
        //extract pages
        extractPages(fileSource, destDir);
        
		ArrayList<File> files = getConvertedSlides(destDir.toString());
		
		int curSlide = 1;
		for (Iterator<File> it = files.iterator(); it.hasNext();) {
			File aFile = (File) it.next();
			String fname = aFile.getName();
			System.out.println("Filename = [" + fname + "]");
			
			int dot = fname.lastIndexOf('.');
			fname = fname.substring(0, dot);
			fname += ".swf";
			
			File outFile = new File(aFile.getParent() + File.separator + fname);
			
			System.out.println("Input = [" + aFile.getAbsolutePath() + "]");
			System.out.println("Output = [" + outFile.getAbsolutePath() + "]");
			convertPDFtoSWF(aFile, outFile);
			updatesMsgSender.sendMessage(room, ReturnCode.CONVERT, files.size(), curSlide++);
		}        
    }

	private void extractPages(File input, File output) {
		String SPACE = " ";
		String BURST = "burst";
		String filenameFormat = room + "-slide-%1d.pdf";
		
        String s = null;
        String command = pdfExtractor + SPACE + input.getAbsolutePath() + SPACE + BURST
        		+ SPACE + "output " + output.getAbsolutePath() + File.separator + filenameFormat;
        
        logger.info("extracting command[" + command + "]");
        
        try {
                     
            Process p = Runtime.getRuntime().exec(command);
            
            BufferedReader stdInput = new BufferedReader(new 
                 InputStreamReader(p.getInputStream()));

            BufferedReader stdError = new BufferedReader(new 
                 InputStreamReader(p.getErrorStream()));

            // read the output from the command            	            
        	logger.debug("Here is the standard output of the command:\n");
            while ((s = stdInput.readLine()) != null) {
                logger.debug(s);
            }
            
            // read any errors from the attempted command
            logger.debug("Here is the standard error of the command (if any):\n");
            while ((s = stdError.readLine()) != null) {
            	logger.error(s);
            }
            stdInput.close();
            stdError.close();
        }
        catch (IOException e) {
            logger.error("exception happened - here's what I know: ");
            e.printStackTrace();
            updatesMsgSender.sendMessage(room, ReturnCode.SWFTOOLS, "Failed while trying to convert document to SWF.");
        }						
	}    
    
	private void convertPDFtoSWF(File input, File output) {
		String SPACE = " ";
		
        String s = null;
        String command = swftoolConverter + SPACE + input.getAbsolutePath() + " " + output.getAbsolutePath();
        try {
                     
            Process p = Runtime.getRuntime().exec(command);
            
            BufferedReader stdInput = new BufferedReader(new 
                 InputStreamReader(p.getInputStream()));

            BufferedReader stdError = new BufferedReader(new 
                 InputStreamReader(p.getErrorStream()));

            // read the output from the command            	            
        	logger.debug("Here is the standard output of the command:\n");
            while ((s = stdInput.readLine()) != null) {
                logger.debug(s);
            }
            
            // read any errors from the attempted command
            logger.debug("Here is the standard error of the command (if any):\n");
            while ((s = stdError.readLine()) != null) {
            	logger.error(s);
            }
            stdInput.close();
            stdError.close();
        }
        catch (IOException e) {
            logger.error("exception happened - here's what I know: ");
            e.printStackTrace();
            updatesMsgSender.sendMessage(room, ReturnCode.SWFTOOLS, "Failed while trying to convert document to SWF.");
        }						
	}
	
    private ArrayList<File> getConvertedSlides(String sourceFolder) 
    {
    	File file = new File(sourceFolder);
    		
    	File[] files = file.listFiles();
    		
    	ArrayList<File> listOfFiles = new ArrayList<File>();
    		
    	for (int i= 0; i < files.length; i++) {
    		if (!files [i].isDirectory()) {
    			String filename = (String)files[i].getName();
    			if (filename.toLowerCase().endsWith(".pdf")) {
    				listOfFiles.add(files[i]);	
    			}
    		}
    	}
    		
    	return listOfFiles;
    }        
    
}
