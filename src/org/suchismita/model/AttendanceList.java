package org.suchismita.model;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.concurrent.Callable;

import javax.naming.NamingException;

import oracle.jdbc.internal.OracleTypes;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;

import org.suchismita.helper.ConnectionProvider;

import com.sun.glass.ui.MenuItem.Callback;
public class AttendanceList {
private int teacher_id;
private String teacherName;
private String name;
private int rollNo;
private String sub_code;
private int [] roll;
private Date classDate;
private String strDate;
private Timestamp startTime;
private Timestamp endTime;
private String strStart;
private String strEnd;
private int status;

public int getStatus() {
	return status;
}
public void setStatus(int status) {
	this.status = status;
}


static
{
	try {
		Class.forName("oracle.jdbc.OracleDriver");
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
    
}

public String getStrDate() {
	return strDate;
}
public String getStrStart() {
	return strStart;
}
public void setStrStart(String strStart) {
	this.strStart = strStart;
}
public String getStrEnd() {
	return strEnd;
}
public void setStrEnd(String strEnd) {
	this.strEnd = strEnd;
}
public AttendanceList() {
	super();
}
public int getTeacher_id() {
	return teacher_id;
}
public void setTeacher_id(int teacher_id) {
	this.teacher_id = teacher_id;
}
public String getSub_code() {
	return sub_code;
}
public void setSub_code(String sub_code) {
	this.sub_code = sub_code;
}
public int[] getRoll() {
	return roll;
}
public void setRoll(int[] roll) {
	this.roll = roll;
}
public Date getClassDate() {
	return classDate;
}
public void setClassDate(Date classDate) {
	this.classDate = classDate;
	this.strDate=new SimpleDateFormat("dd-MM-yyyy").format(this.classDate);
}
public Timestamp getStartTime() {
	return startTime;
}
public void setStartTime(Timestamp startTime) {
	this.startTime = startTime;
	this.setStrStart(new SimpleDateFormat("hh:mm a").format(new Date(this.startTime.getTime())));
}
public Timestamp getEndTime() {
	return endTime;
}
public void setEndTime(Timestamp endTime) {
	this.endTime = endTime;
	this.setStrEnd(new SimpleDateFormat("hh:mm a").format(new Date(this.endTime.getTime())));
}


public String getTeacherName() {
	return teacherName;
}
public void setTeacherName(String teacherName) {
	this.teacherName = teacherName;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public int getRollNo() {
	return rollNo;
}
public void setRollNo(int rollNo) {
	this.rollNo = rollNo;
}
public void insertAttendance() throws Exception
{
	
	Connection conn=null;
	CallableStatement callableStatement=null;
	String sql="{call STUDENT_ATTENDANCE_PACKAGE.give_attendance(?,?,?,?,?,?)}";
	try
	{
		
        conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","suchismita","suchismita");
		callableStatement=conn.prepareCall(sql);
		ArrayDescriptor des = ArrayDescriptor.createDescriptor("SUCHISMITA.NUMBER_ARRAY",conn);
        ARRAY array_to_pass = new ARRAY(des,conn,this.getRoll());
		callableStatement.setInt(1,this.getTeacher_id());
		callableStatement.setString(2, this.getSub_code());
		callableStatement.setArray(3, array_to_pass);
		callableStatement.setDate(4, new java.sql.Date(this.getClassDate().getTime()));
		callableStatement.setTimestamp(5, this.getStartTime());
		callableStatement.setTimestamp(6, this.getEndTime());
		callableStatement.executeUpdate();
	}
	finally
	{
		if(conn!=null)
			conn.close();
		
		if(callableStatement!=null)
			callableStatement.close();
	}
	
	
}


public static ArrayList<AttendanceList> getAttendance(String dname,String year,String sec,String sub_code) throws Exception

{
	System.out.println(dname+sec+year+sub_code);
	ArrayList<AttendanceList> arr=null;
	Connection conn=null;
	CallableStatement call=null;
	String sql="{call STUDENT_ATTENDANCE_PACKAGE.get_attendance(?,?,?,?,?)}";
	ResultSet rs=null;
	try
	{
		arr=new ArrayList<>();
	conn=ConnectionProvider.getConnection();
	System.out.println("Connection opened---------");
	call=conn.prepareCall(sql);
	call.setString(1, dname);
	call.setString(2, year);
	call.setString(3, sec);
	call.setString(4, sub_code);
	call.registerOutParameter(5,OracleTypes.CURSOR);
	System.out.println("Set parametr-----");
	call.execute();
	System.out.print("Succssfully executed----------\n");
    rs=(ResultSet)(call.getObject(5));
    if(rs!=null){
	while(rs.next())
	{
		System.out.println("Entered-----------");
		AttendanceList at=new AttendanceList();
		at.setTeacherName(rs.getString("tname"));
		at.setClassDate(rs.getDate(2));
		at.setStartTime(rs.getTimestamp(3));
		at.setEndTime(rs.getTimestamp(4));
		at.setRollNo(rs.getInt(5));
		at.setName(rs.getString("stname"));
		at.setStatus(rs.getInt(7));
		arr.add(at);
	}
	}
	}
	finally
	{  
		if(rs!=null)
		rs.close();
		if(call!=null)
			call.close();
		if(conn!=null)
			conn.close();
	}
	return arr;
}
}
