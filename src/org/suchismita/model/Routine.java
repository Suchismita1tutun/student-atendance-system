package org.suchismita.model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Struct;
import java.sql.Timestamp;
import java.util.ArrayList;

import oracle.jdbc.internal.OracleTypes;

import org.suchismita.helper.ConnectionProvider;

public class Routine {

	private ArrayList<Period> arrPeriod=null;
    private String day;
    
	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public Routine() {
		super();
		this.arrPeriod=new ArrayList<>();
	}

	public ArrayList<Period> getArrPeriod() {
		return arrPeriod;
	}

	public void setArrPeriod(ArrayList<Period> arrPeriod) {
		this.arrPeriod = arrPeriod;
	}
	 

	  public  ArrayList<Routine> fetchRoutineByTeacherName(String teach_name) throws Exception
	{
	 	
		  ArrayList<Routine> arr=new ArrayList<>();
	    	System.out.println("Teacher Name:"+teach_name);
	    	Connection conn=null;
	    	CallableStatement callableStatement=null;
	    	String qry="{call STUDENT_ROUTINE_PACKAGE.getClassRoutine(?,?)}";
	    	ResultSet rs=null;
	    	try{
	    	conn=ConnectionProvider.getConnection();
	    	callableStatement=conn.prepareCall(qry);
	    	callableStatement.setString(1,teach_name);
	    	callableStatement.registerOutParameter(2, OracleTypes.CURSOR);
	    	callableStatement.execute();
	    	rs=(ResultSet)(callableStatement.getObject(2));
	    	while(rs.next())
	    	{
	        
	    		 Routine r=new Routine();
		            r.setDay(rs.getString(1));     
		    		ArrayList<Period> per=r.getArrPeriod();
		            for(int  i=1 ;i<=6 ;i++)
		    		{
		            	Period p=new Period();
		    		
		    		p.setDay(rs.getString(1));
		    		Struct period=(Struct)rs.getObject(i+1);
		    		Object [] rst=period.getAttributes();
		    		
		    		p.setTeacherName((String)rst[0]);
		    		p.setSubCode((String)rst[1]);
		    		p.setSubType((String)rst[2]);
		    		p.setDepartment((String)rst[3]);
		    		p.setYear((String)rst[4]);
		    		p.setSec((String)rst[5]);
		    		p.setStartTime((Timestamp)rst[6]);
		    		p.setEndTime((Timestamp)rst[7]);
		    	   if(p.getTeacherName().equals("  "))
		    			
		    			{
		    			p.setTeacherName(" ");System.out.println("entered");
		    			}
		      		per.add(p);   
		    		}
		            r.setArrPeriod(per);
		            arr.add(r);
		        }
	    	
	    	return arr;
	    	}
	    	finally
	    	{
	    		if(rs!=null) {
	    		rs.close();
	    		}
					if(conn!=null)
					conn.close();
				
	    		if(callableStatement!=null)
	    			callableStatement.close();
	    	}
	    	
	    	
	}
	
		
	    public  ArrayList<Routine> fetchRoutineBydept(String dname,String year,String sec) throws Exception
	    {
	    	ArrayList<Routine> arr=new ArrayList<>();
	    	
	    	Connection conn=null;
	    	CallableStatement callableStatement=null;
	    	String qry="{call STUDENT_ROUTINE_PACKAGE.getClassRoutine(?,?,?,?)}";
	    	ResultSet rs=null;
	    	try{
	    	conn=ConnectionProvider.getConnection();
	    	callableStatement=conn.prepareCall(qry);
	    	callableStatement.setString(1, dname);
	    	callableStatement.setString(2, year);
	    	callableStatement.setString(3, sec);
	    	callableStatement.registerOutParameter(4, OracleTypes.CURSOR);
	    	callableStatement.execute();
	    	rs=(ResultSet)(callableStatement.getObject(4));
	    	while(rs.next())
	    	{
	            Routine r=new Routine();
	            r.setDay(rs.getString(1));     
	    		ArrayList<Period> per=r.getArrPeriod();
	            for(int  i=1 ;i<=6 ;i++)
	    		{
	            	Period p=new Period();
	    		
	    		p.setDay(rs.getString(1));
	    		Struct period=(Struct)rs.getObject(i+1);
	    		Object [] rst=period.getAttributes();
	    		
	    		p.setTeacherName((String)rst[0]);
	    		p.setSubCode((String)rst[1]);
	    		p.setSubType((String)rst[2]);
	    		p.setDepartment((String)rst[3]);
	    		p.setYear((String)rst[4]);
	    		p.setSec((String)rst[5]);
	    		p.setStartTime((Timestamp)rst[6]);
	    		p.setEndTime((Timestamp)rst[7]);
	    		if(p.getTeacherName().equals("  "))
	    			
	    			{
	    			p.setTeacherName(" ");
	    			}
	      		per.add(p);   
	    		}
	            r.setArrPeriod(per);
	            arr.add(r);
	            
	    	}
	    	
	    	return arr;
	    	}
	    	finally
	    	{
	    		if(rs!=null) {
	    		rs.close();
	    		}
					if(conn!=null)
					conn.close();
				
	    		if(callableStatement!=null)
	    			callableStatement.close();
	    	}
	    	
	    	
	    }
	    
	
}
