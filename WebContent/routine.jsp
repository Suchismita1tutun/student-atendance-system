<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Routine</title>
<link rel="stylesheet" type="text/css" href="resources/css/formstyle.css"> 
</head>

<body style="background-color: infobackground;">
<div style="background-color: #21beaa;width:100%;border-radius:8px;   height:150px;font-family:cooper book;color:white;font-size:35px;text-decoration: underline;text-align: center;box-shadow: 0 0px 18px 5px rgba(0,0,0,.35);">INSTITUTE OF ENGINEERING AND MANAGEMENT
<br><span style="font-size:25px;font-family: sans-serif;color:orange;text-shadow: black;">---Update Weekly Routine---</span>
</div>
<sql:query var="tec" dataSource="jdbc/iem" scope="page" sql="select name from teacher"></sql:query>
<sql:query var="sb" dataSource="jdbc/iem" scope="page" sql="select name,sub_code from subject"></sql:query>

<form action="routine" method="post" class="elegant-aero" id="form" style="margin-top:10px;box-shadow: 0 0px 18px 5px rgba(0,0,0,.35);border-radius:8px 8px;border-width: 2px;border-color:button-face;border-style:ridge; ">
   <input type="hidden" name="action" value="update"/>
    <h1>Update Class Routine From Here....
        <span>Please fill all the texts in the fields.</span>
    </h1>
   
    <label>
        <span>Teacher Name :</span>
         <select name="name" required="required">
     <optgroup label="---Subject---"></optgroup>
     <c:forEach var="rec" items="${tec.rows}">
     <option value="${rec.name}">${rec.name}
     </option>
     
     </c:forEach>
     
     </select>
          
       


    </label>
    
    <label>
        <span>Subject Code :</span>
     
     <select name="sub">
     <optgroup label="---Subject---"></optgroup>
     <c:forEach var="rec" items="${sb.rows}">
     <option value="${rec.sub_code}">${rec.name} (${rec.sub_code}) 
     </option>
     
     </c:forEach>
     
     </select>
          
      </label>
    
 <label>
        <span>Department</span>
     <sql:query var="rs" scope="page" dataSource="jdbc/iem" sql="select dept_name from department"></sql:query>
       
       
       <select name="dept">
       <optgroup label="---Select Department---">
        
       <c:forEach var="dept" items="${rs.rows}">
        <option value="${dept.dept_name}">${dept.dept_name}</option>
        </c:forEach>
         </optgroup>
            </select>
       </label>
       
           
      <label>
        <span>Year:</span>
      
       <select name="year" >
       <optgroup label="---Select Year---">
        <option value="1ST">FIRST</option>
       <option value="2ND">SECOND</option>
       <option value="3RD">THIRD</option>
       <option value="4TH">FOURTH</option>
        </optgroup>
        </select>
       </label>    
     
     <label>
        <span>Sec:</span>
      
       <select name="sec" >
       <optgroup label="---Select Year---">
        <option value="A">A</option>
       <option value="B">B</option>
       <option value="C">C</option>
       <option value="D">D</option>
        </optgroup>
        </select>
       </label>  
     
     
     <label>
        <span>Day:</span>
      
       <select name="day" >
       <optgroup label="---Select Class Day---">
        <option value="MONDAY">MONDAY</option>
       <option value="TUESDAY">TUESDAY</option>
       <option value="WEDNESDAY">WEDNESDAY</option>
       <option value="THURSDAY">THERSDAY</option>
       <option value="FRIDAY">FRISDAY</option>
       <option value="SATURDAY">SATURDAY</option>
       
       
        </optgroup>
        </select>
       </label>    
       
       
       <label>
       <span>Period:</span>
       <input type="number" name="period" min="1" required="required" >
       </label>
     
      <label>
       <span>Start Time:</span>
       <input type="time" name="stime" required="required">
       </label>
      <label>
       <span>End Time:</span>
       <input type="time" name="etime" required="required">
       </label>
     
     
      <label>
        <span>&nbsp;</span> 
        <input type="submit" class="button" value="Submit"  id="submit"/> 
      
     
        <span>&nbsp;</span> 
        <input type="reset" class="button" value="Reset" /> 
  </label>
    </form>  

      
</body>
</html>