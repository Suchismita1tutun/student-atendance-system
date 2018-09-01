package org.suchismita.model;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import javax.naming.NamingException;

import org.suchismita.helper.ConnectionProvider;
public class Student {
	int rollNo;
	String first_name ;
	String last_name;
	String year ;
	String sec ;
	Date dob;
	String phone_no ;
	String email_id ;
	String address ;
	int dept_no ;



	public int getRollNo() {
		return rollNo;
	}



	public void setRollNo(int rollNo) {
		this.rollNo = rollNo;
	}



	public Student() {
		super();
	}



	public String getFirst_name() {
		return first_name;
	}



	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}



	public String getLast_name() {
		return last_name;
	}



	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}



	public String getYear() {
		return year;
	}



	public void setYear(String year) {
		this.year = year;
	}



	public String getSec() {
		return sec;
	}



	public void setSec(String sec) {
		this.sec = sec;
	}



	public Date getDob() {
		return dob;
	}



	public void setDob(Date dob) {
		this.dob = dob;
	}



	public String getPhone_no() {
		return phone_no;
	}



	public void setPhone_no(String phone_no) {
		this.phone_no = phone_no;
	}



	public String getEmail_id() {
		return email_id;
	}



	public void setEmail_id(String email_id) {
		this.email_id = email_id;
	}



	public String getAddress() {
		return address;
	}



	public void setAddress(String address) {
		this.address = address;
	}



	public int getDept_no() {
		return dept_no;
	}



	public void setDept_no(int dept_no) {
		this.dept_no = dept_no;
	}

	public static ArrayList<Student> getStudentList(int dno,String year,String sec) throws Exception
	
	{
	ArrayList<Student> starr=null;
	Connection conn=null;
	PreparedStatement pres=null;
	ResultSet rs=null;
	System.out.println(sec+dno);
	String sql="select enroll,first_name,last_name,sec from student where dept_no=? and  year=?  and sec=? ";
	try
	{
		conn=ConnectionProvider.getConnection();
        pres=conn.prepareStatement(sql);		
        pres.setInt(1,dno);
        pres.setString(2,year);
        pres.setString(3,sec);
         rs=pres.executeQuery();
        starr=new ArrayList<>();
        while(rs.next())
        { 
        	
        	Student st=new Student();
        	st.setRollNo(rs.getInt(1));
        	st.setFirst_name(rs.getString(2));
        	st.setLast_name(rs.getString(3));
        	st.setSec(rs.getString(4));
        	starr.add(st);
        }
		return starr;
	}
	finally
	{
		if(rs!=null)
			rs.close();
		if(pres!=null)
			pres.close();
		if(conn!=null)
			conn.close();
	}
		
	}
	
}
