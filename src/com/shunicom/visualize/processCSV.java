package com.shunicom.visualize;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class processCSV {
    private BufferedReader reader;
    private PrintWriter writer;
    String inputFileName;
    String outputFileName;

    public List<String> generate(String inputfile){  
        List<String> returnval = new ArrayList<String>();
        try {  
        	InputStreamReader read = new InputStreamReader(
            new FileInputStream(inputfile));//考虑到编码格式
            BufferedReader bufferedReader = new BufferedReader(read);
            String lineTxt = null;
            String[] output = null;
            int max = 0;
            while((lineTxt = bufferedReader.readLine()) != null){
            	returnval.add(lineTxt);
            }
            read.close();
        } catch (UnsupportedEncodingException e) {  
            e.printStackTrace();  
        } catch (Exception e) {  
            e.printStackTrace();  
        } 
        return returnval;
    }
    
    public static void main(String[] args ){
    	new processCSV().generate("E:/heatmap.csv");
    }
}
