package org.suchismita.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.suchismita.model.AttendanceList;
import org.suchismita.model.Student;

import com.google.gson.Gson;
import com.sun.corba.se.spi.presentation.rmi.PresentationManager.ClassData;


public class AttendanceController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AttendanceController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
      String dname=request.getParameter("dept");
      String sec=request.getParameter("sec");
      String year=request.getParameter("year");
      String sub=request.getParameter("sub");
      String strJson = null,action=request.getParameter("action");
      Gson gson=new Gson();
		
      response.setContentType("application/json");
	  
      if(action.equals("1"))
      {
      try {
    	  Integer dno=Integer.parseInt(request.getParameter("dept"));
    	     
    	  ArrayList<Student> arst=Student.getStudentList(dno, year, sec);
		
		 strJson=gson.toJson(arst);
		System.out.println(strJson);
		 response.getWriter().write(strJson);
			} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}	
      }
      else
      {
    	  try {
			
    		  ArrayList<AttendanceList> arst=AttendanceList.getAttendance(dname, year, sec, sub);
		     System.out.println("Ebter------------");
			strJson=gson.toJson(arst);
			 response.getWriter().write(strJson);
    	  } catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	 

      }
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String [] rollList=request.getParameterValues("list1");
		int teacher_id=Integer.parseInt(request.getParameter("teach"));
		String subCode=request.getParameter("sub");
		Date  classDate = null;
		try {
			classDate=new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("date"));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Timestamp start=Timestamp.valueOf(new SimpleDateFormat("yyyy-MM-dd").format(new Date()) +" "+request.getParameter("start")+ ":00 ");
		Timestamp end=Timestamp.valueOf(new SimpleDateFormat("yyyy-MM-dd").format(new Date()) +" "+request.getParameter("end")+ ":00 ");
 
if(rollList!=null){
   int [] roll=new int[rollList.length];	
  
		for(int j=0;j<rollList.length;j++)
		{
	roll[j]=Integer.parseInt(rollList[j]);
			
		}
		
		AttendanceList att=new AttendanceList();
		att.setTeacher_id(teacher_id);
		att.setSub_code(subCode);
		att.setRoll(roll);
		att.setStartTime(start);
		att.setEndTime(end);
		att.setClassDate(classDate);
		try {
			att.insertAttendance();
			response.sendRedirect("editAttendance.jsp");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	}

}
