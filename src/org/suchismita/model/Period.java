package org.suchismita.model;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.suchismita.helper.ConnectionProvider;

public class Period {

	private String teacherName;
	private String subCode;
	private String department;
	private String year;
	private String sec;
	private String day;
	private int period;
	private Timestamp startTime;
	private Timestamp endTime;
	private String subType;
	private String start,end;
	
	public String getSubType() {
		return subType;
	}
	public void setSubType(String subType) {
		this.subType = subType;
	}
	public Period() {
		super();
	}
	public String getTeacherName() {
		return teacherName;
	}
	public void setTeacherName(String teacherName) {
		if(teacherName!=null)
		this.teacherName = teacherName.toUpperCase();
	}
	public String getSubCode() {
		return subCode;
	}
	public void setSubCode(String subCode) {
		this.subCode = subCode.toUpperCase();
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department.toUpperCase();
	}
	public String getYear() {
		return year.toUpperCase();
	}
	public void setYear(String year) {
		this.year = year.toUpperCase();
	}
	public String getSec() {
		return sec;
	}
	public void setSec(String sec) {
		this.sec = sec;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day.toUpperCase().trim();
	}
	public int getPeriod() {
		return period;
	}
	public void setPeriod(int period) {
		this.period = period;
	}

public Timestamp getStartTime() {
		return startTime;
	}
	public void setStartTime(Timestamp startTime) {
		this.startTime = startTime;
		this.start=new SimpleDateFormat("hh:mm:ss a").format(new Date(this.startTime.getTime()));
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public Timestamp getEndTime() {
		return endTime;
	}
	public void setEndTime(Timestamp endTime) {
		this.endTime = endTime;
		this.end=new SimpleDateFormat("hh:mm:ss a").format(new Date(this.endTime.getTime()));
	}
	
	
	public void insertPeriod() throws Exception
	{
		Connection con=null;
		CallableStatement callableStatement=null;
		
		String st="{call student_routine_package.insert_routine(?,?,?,?,?,?,?,?,?)}";
	  
		try {
			con=ConnectionProvider.getConnection();
			callableStatement =con.prepareCall(st);
			callableStatement.setString(1,this.getTeacherName());
			callableStatement.setString(2, this.getSubCode());
			callableStatement.setString(3, this.getDepartment());
            callableStatement.setString(4,this.getYear());
            callableStatement.setString(5, this.getSec());
            callableStatement.setInt(7, this.getPeriod());
            callableStatement.setString(6, this.getDay());
			callableStatement.setTimestamp(8,this.getStartTime());
			callableStatement.setTimestamp(9, this.getEndTime());
			callableStatement.executeUpdate();
		}
		finally
		{
			
			if(con!=null)
				con.close();
		    if(callableStatement!=null)
		    	callableStatement.close();
		
		
		}
	}
		
	

	}
	
	
