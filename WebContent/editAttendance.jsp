<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="resources/css/formstyle.css"> 

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Attendance</title>

<style>
tr,td
{
border-style:outset;
width:10%;
text-align:center;
border-color:#21beaa;
box-shadow: 0 0px 18px 5px rgba(0,0,0,.35);border-radius:8px 8px;
}
table
{
border-style:outset;
box-shadow: 0 0px 18px 5px rgba(0,0,0,.35);border-radius:8px 8px;
margin-left:20%;
margin-right: 10%;
}
</style>
<script> 

var xmlHttp;
                       
                        function getHttpObject(){                            
                            //all ajax enabled browser supportsd XmlHttpRequest
                            //The object of XmlHttpRequest actually used to post partial post to the server asynchronously.
                            //window object is  supported by the browser, each browser window has one window object as root element of the DPOM model
                            //each document under a browser is an element under window object.
                            if (window.XMLHttpRequest)
                                    return new XMLHttpRequest();
                             else if (window.ActiveXObject) //only for IE versions < 6.0
                                    return new ActiveXObject("Microsoft.XMLHTTP");
                             else if (window.ActiveXObject) //only for IE versions < 6.0
                                 return new ActiveXObject("Msxml2.XMLHTTP");
                          
                              else return null;
                        }

                        function fetch(){ 
                  
                            
                             
                             xmlHttp = getHttpObject();
                            if (xmlHttp==null){
                                msg.innerHTML="<b>your browser does not support AJAX</b>";
                                return;
                            }                          
      
                            var dno = document.getElementById("dno").value;
                            var year = document.getElementById("year").value;
                            var sec = document.getElementById("sec").value;
                            
                            //set the method that is suppose to handle the response
                            xmlHttp.onreadystatechange=handleCallback;
                            xmlHttp.open("GET","giveAttendance?dept="+dno+"&year="+year+"&sec="+sec+"&action=1",true);      
                            //for post request you need to set URIEncoding
                            //Example here : http://www.javascriptkit.com/dhtmltutors/ajaxgetpost2.shtml
                            xmlHttp.send(null);                            
                        }

                      function handleCallback(){
                              var strMsg="";
                             
                              //alert("Hello !! I got call 5");
                                switch(xmlHttp.readyState){
                                    case 0: strMsg="Not Initialized";
                                                    break;
                                    case 1:strMsg ="Connection Established";
                                                    break;
                                    case 2:strMsg="Request Received";
                                                    break;
                                    case 3:strMsg="Processing...";
                                                    break;
                                    case 4:
                                                    if (xmlHttp.status==200){
                                                            strMsg=xmlHttp.responseText;
                                                          }
                                                    else
                                                            strMsg="404 Resource Not Found...";

                                }
                             showStudentList(strMsg);
                        }            


             function showStudentList(strJson)
             {
            	
            	 var jsonObject=JSON.parse(strJson);
            	 var ptable=document.getElementById("tab");
            	 
            	 var i;
            	 for (i=ptable.rows.length-1;i>0;i--)
            		 {
            		  ptable.deleteRow(i);
            		 
            		 } 
            	 
            	 for(i=0;i<jsonObject.length;i++)
         		{
            		 
            		
            		 var cr=ptable.insertRow(i+1);
            		
            		 
         		var c1=cr.insertCell(0);
         		var c2=cr.insertCell(1);
         		var c3=cr.insertCell(2);
         		var c4=cr.insertCell(3);
         		
         		c2.innerHTML=jsonObject[i].first_name;
         		c1.innerHTML=jsonObject[i].rollNo;
         		c3.innerHTML=jsonObject[i].last_name;
                c4.innerHTML="<input type='checkbox' style='margin-left:10%' value= "+jsonObject[i].rollNo+" name='list1' >";
             }




             }





                        </script>

</head>
<body style="background-color: infobackground;color: black">
<div style="background-color: #21beaa;width:100%;border-radius:8px;   height:150px;font-family:cooper book;color:white;font-size:35px;text-decoration: underline;text-align: center;box-shadow: 0 0px 18px 5px rgba(0,0,0,.35);">INSTITUTE OF ENGINEERING AND MANAGEMENT

<br>
<marquee style="font-size:15px;color: red;"> Weekly Routine </marquee>
</div>
<sql:query var="rs" scope="page" dataSource="jdbc/iem" sql="select id,name from teacher"></sql:query>
<sql:query var="sub" scope="page" dataSource="jdbc/iem" sql="select name,sub_code from subject"></sql:query>       
<sql:query var="dept" dataSource="jdbc/iem" sql="select * from department"></sql:query>
<sql:query var="sec" dataSource="jdbc/iem" sql="select distinct sec from department_section"></sql:query>       
<sql:query var="year" dataSource="jdbc/iem" sql="select distinct year from department_section"></sql:query>


<form action="routine" method="get" class="elegant-aero" id="form" style="margin-top:10px;box-shadow: 0 0px 18px 5px rgba(0,0,0,.35);border-radius:8px 8px;border-width: 2px;border-color:button-face;border-style:ridge; ">
<label>
<input type="hidden" name="action" value="1">
        <span>Department:</span>
       <select name="dept" id="dno" >
            <optgroup label="----Department-----"></optgroup>
            <c:forEach var="dept" items="${dept.rows}">
            <option value="${dept.dept_no}">${dept.dept_name}</option>
            </c:forEach>
            
        </select>
        <span>Year:</span>
            <select name="year" id="year">
            <optgroup label="----Year-----"></optgroup>
            <c:forEach var="year" items="${year.rows}">
            <option value="${year.year}">${year.year}</option>
            </c:forEach>
            
        </select>
        <span>Sec</span>
        <select name="sec"  id="sec" onchange="fetch()" >
            <optgroup label="----Year-----"></optgroup>
            <c:forEach var="sec" items="${sec.rows}">
            <option value="${sec.sec}">${sec.sec}</option>
            </c:forEach>
            
        </select>
</form>
<form action="giveAttendance" method="post" class="elegant-aero" id="form" style="margin-top:10px;box-shadow: 0 0px 18px 5px rgba(0,0,0,.35);border-radius:8px 8px;border-width: 2px;border-color:button-face;border-style:ridge; ">


<span>Teacher Name:</span>

       <select name="teach">
       <optgroup label="--- Teacher Name ---">
        
       <c:forEach var="tech" items="${rs.rows}">
        <option value="${tech.id}">${tech.name}</option>
        
        </c:forEach>
         </optgroup>
            </select>
            <br>
        <span>Subject :</span>    
       <select name="sub" >
            <optgroup label="----Subject-----"></optgroup>
            <c:forEach var="sub" items="${sub.rows}">
            <option value="${sub.sub_code}">${sub.name}(${sub.sub_code})</option>
            </c:forEach>
            
        </select>
<br>
     <span>Class Date</span>
    <input type="date" name="date">
    </label>
    <br>
    
    <span>Class Start Time</span>
    <input type="time" name="start">
    
    <span>Class End Time</span>
    <input type="time" name="end" ></label>

<br>
<br>

<table id="tab" border="2px"  >
<thead><tr>
<th>Roll No</th>
<th>First Name</th>
<th>Last Name</th>
<th style="width:5%">Status</th>

</tr></thead>
<tbody>

</tbody>
</table>

<input type="submit" class="button" value="giveAttendance"  /> 

</form>
</body>
</html>