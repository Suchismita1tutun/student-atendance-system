<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Routine</title>
<link rel="stylesheet" type="text/css" href="resources/css/formstyle.css"> 
<style>
tr,td
{
width:6%;

}

</style>
<script type="text/javascript">

function show1()
{
	//document.getElementById("t").style.display="none";
	document.getElementById("yy").style.display="block";
	
	document.getElementById("tt").style.display="none";
}

function show2()
{
	//document.getElementById("t").style.display="none";
	document.getElementById("tt").style.display="block";
	document.getElementById("yy").style.display="none";
}
</script>

</head>
<body style="background-color: infobackground;">
<div style="background-color: #21beaa;width:100%;border-radius:8px;   height:150px;font-family:cooper book;color:white;font-size:35px;text-decoration: underline;text-align: center;box-shadow: 0 0px 18px 5px rgba(0,0,0,.35);">INSTITUTE OF ENGINEERING AND MANAGEMENT

<br>
 <label class="elegant-aero" style="float:right;background-color:#21beaa; ">
        <span>&nbsp;</span> 
        <input type="submit" class="button" value="View routine by year,sec,department"  onclick="show1()"/> 
      
     
        <span>&nbsp;</span> 
        <input type="submit" class="button" value="View routine by teacher name" onclick="show2()"/> 
  </label>
<marquee style="font-size:18px;color: red;"> Weekly Routine </marquee>
</div>


<div id="yy" style="display:none">
<form action="routine" method="get" class="elegant-aero" id="form" style="margin-top:10px;box-shadow: 0 0px 18px 5px rgba(0,0,0,.35);border-radius:8px 8px;border-width: 2px;border-color:button-face;border-style:ridge; ">
<input type="hidden" name="op" value="1">
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
     
       <input type="submit" class="button" value="View"  /> 
      
</form>

</div>

<c:if test="${requestScope.present eq true}">


<table border="2px" style="box-shadow: 0 0px 18px 5px rgba(0,0,0,.35);border-radius:12px 8px;border-color: #21ffaa " id="t">
<thead>
<tr>
<th>Day</th>
<th>Period1</th>
<th>Period2</th>
<th>Period3</th>
<th>Period4</th>
<th>Period5</th>
<th>Period6</th>
</tr>
</thead>
<tbody>
<c:forEach var="rec" items="${requestScope.routine}">

<tr>
<td>${rec.day}</td>
<c:forEach var="per" items="${rec.arrPeriod}">

<c:choose>
<c:when test="${per.teacherName ne ' '}"><td>  

TeacherName: ${per.teacherName}<br>
Subject : ${per.subCode}<br>
Subject Type : ${per.subType}<br>
Department : ${per.department}<br>
Year : ${per.year} Sec : ${per.sec}<br>
StartTime : ${per.start} <br>
EndTime : ${per.end}<br>

</td>
</c:when>
<c:otherwise><td></td>
</c:otherwise>
</c:choose>
</c:forEach>

</tr>
</c:forEach>


</tbody>


</table>
</c:if> 



<div id="tt" style="display:none">
<form action="routine" method="get" class="elegant-aero" id="form" style="margin-top:10px;box-shadow: 0 0px 18px 5px rgba(0,0,0,.35);border-radius:8px 8px;border-width: 2px;border-color:button-face;border-style:ridge; ">
<input type="hidden" name="op" value="2">
<label>
<span>Teacher Name:</span>

<sql:query var="rs" scope="page" dataSource="jdbc/iem" sql="select name from teacher"></sql:query>
       
       
       <select name="teach">
       <optgroup label="--- Teacher Name ---">
        
       <c:forEach var="tech" items="${rs.rows}">
        <option value="${tech.name}">${tech.name}</option>
        
        </c:forEach>
         </optgroup>
            </select>
     
    <input type="submit" class="button" value="View"  /> 
      
</label>
</form>
</div>

</body>
</html>