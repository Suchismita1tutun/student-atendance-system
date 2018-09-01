package org.suchismita.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.suchismita.model.Period;
import org.suchismita.model.Routine;

public class RoutineController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RoutineController() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    	{
    		String department=request.getParameter("dept");
   		  String year=request.getParameter("year");
   	      String sec=request.getParameter("sec");
   	      String action=request.getParameter("op");
   	      Routine r=new Routine();
   	   ArrayList<Routine>list=null;
   	      if(action.equals("1"))
   	      {
   	    	 try {
				list=r.fetchRoutineBydept(department, year, sec);
		
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
   	    	  
   	    	  
   	      }
   	      
   	      else
   	      {
   	    	  
   	    	  
   	    	  String teach_name=request.getParameter("teach");
   	    	  try {
				list=r.fetchRoutineByTeacherName(teach_name);
				 
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
   	    	  
   	      }
   	      
   	   request.setAttribute("present", true);
		request.setAttribute("routine", list);
		this.getServletContext().getRequestDispatcher("/getroutine.jsp").forward(request, response);
		
   	    	  
   	      
   	
    		
    		
    		
    	}
    
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String teacherName=request.getParameter("name");
		String subCode=request.getParameter("sub");
	 String department=request.getParameter("dept");
		 String year=request.getParameter("year");
	 String sec=request.getParameter("sec");
		 String day=request.getParameter("day");
		 int period=Integer.parseInt(request.getParameter("period"));
		 Timestamp startTime = null,endTime=null;
          
	   	 startTime= Timestamp.valueOf((new SimpleDateFormat("yyyy-MM-dd").format(new Date())+" "+request.getParameter("stime")+ ":00 "));
		endTime=Timestamp.valueOf((new SimpleDateFormat("yyyy-MM-dd").format(new Date())+" "+request.getParameter("etime")+ ":00 "));
		
	   Period routine=new Period();
	   routine.setTeacherName(teacherName);
	   routine.setSubCode(subCode);
	   routine.setDepartment(department);
	   routine.setYear(year);
	   routine.setSec(sec);
	   routine.setDay(day);
	   routine.setPeriod(period);
	   routine.setStartTime(startTime);
	   routine.setEndTime(endTime);
	   try {
		routine.insertPeriod();
		response.sendRedirect("routine.jsp");
		
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}	
		
	}

}
