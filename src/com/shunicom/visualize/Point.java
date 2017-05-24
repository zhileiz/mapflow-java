package com.shunicom.visualize;

public class Point {
	private double longitude;
	private double latitude;
	private int totalpeople;
	
	public Point(double longitude, double latitude, int totalpeople){
		this.longitude = longitude;
		this.latitude = latitude;
		this.totalpeople = totalpeople;
	}
	
	public double longitude(){
		return this.longitude;
	}
	
	public double latitude(){
		return this.latitude;
	}
	
	public int totalpeople(){
		return this.totalpeople;
	}

}
