package com.shunicom.visualize;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.HashSet;
import java.util.Iterator;

public class processCSV {
    private Set<Point> points;
    String inputFileName;
    String outputFileName;
    
    public processCSV(){
    	points = new HashSet<Point>();
    }

    private List<String> generate(String inputfile){  
        List<String> returnval = new ArrayList<String>();
        try {  
        	InputStreamReader read = new InputStreamReader(
            new FileInputStream(inputfile));  //考虑到编码格式
            BufferedReader bufferedReader = new BufferedReader(read);
            String lineTxt = null;
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
    
    public List<String> reprocess(String inputfile){
    	List<String> result = generate(inputfile);
    	List<String> toReturn = new ArrayList<String>();
        String[] output = null;
        for(String s : result){
          output = s.split(",");
          Double[] coordinates = transform.transform(Double.parseDouble(output[2]), Double.parseDouble(output[1]));
          toReturn.add("{\"lng\":\""+coordinates[0]+"\",\"lat\":\""+coordinates[1]+"\",\"count\":\""+output[3]+"\"},");
          points.add(new Point(coordinates[0],coordinates[1],Integer.parseInt(output[3])));
        }
        return toReturn;
    }
    
    
    public static void main(String[] args ){
    	new processCSV().generate("E:/heatmap.csv");
    }
    
    public Iterator<Point> iterator(){
    	return this.points.iterator();
    }
}
