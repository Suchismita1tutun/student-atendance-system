<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="resources/css/formstyle.css"> 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>







<style>

#tab > tr,td
{
width:10%;
border-color: #251156;
}
#tab
{
text-align: center;
margin-left: 10%;
margin-right: 10%;

margin-top:5%;
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
                            var sub=document.getElementById("sub").value;
                            //set the method that is suppose to handle the response
                            xmlHttp.onreadystatechange=handleCallback;
                            xmlHttp.open("GET","giveAttendance?dept="+dno+"&year="+year+"&sec="+sec+"&action=2&sub="+sub,true);      
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
            	 
            	 for (i=ptable.rows.length-1;i>=1;i--)
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
         		var c5=cr.insertCell(4);
         		var c6=cr.insertCell(5);
         		var c7=cr.insertCell(6);
         		
         		
         		
         		c1.innerHTML=jsonObject[i].teacherName;
         		c3.innerHTML=jsonObject[i].strStart;
         		c4.innerHTML=jsonObject[i].strEnd;
                c2.innerHTML=jsonObject[i].strDate;
                c5.innerHTML=jsonObject[i].rollNo;
                c6.innerHTML=jsonObject[i].name;
            	c7.innerHTML='Present'; 
             }




             }





                        </script>















</head>








<body style="background-color: infobackground;color: black">
<div style="background-color: #21beaa;width:100%;border-radius:8px;   height:150px;font-family:cooper book;color:white;font-size:35px;text-decoration: underline;text-align: center;box-shadow: 0 0px 18px 5px rgba(0,0,0,.35);">INSTITUTE OF ENGINEERING AND MANAGEMENT

<br>
<marquee style="font-size:15px;color: red;"> Attendance </marquee>
</div>
<sql:query var="sub" scope="page" dataSource="jdbc/iem" sql="select name,sub_code from subject"></sql:query>       
<sql:query var="dept" dataSource="jdbc/iem" sql="select * from department"></sql:query>
<sql:query var="sec" dataSource="jdbc/iem" sql="select distinct sec from department_section"></sql:query>       
<sql:query var="year" dataSource="jdbc/iem" sql="select distinct year from department_section"></sql:query>

<form  class="elegant-aero" id="form" style="margin-top:10px;box-shadow: 0 0px 18px 5px rgba(0,0,0,.35);border-radius:8px 8px;border-width: 2px;border-color:button-face;border-style:ridge; ">
<label >

        <span>Department:</span>
       <select name="dept" id="dno" onchange="fetch()" >
            <optgroup label="----Department-----"></optgroup>
            <c:forEach var="dept" items="${dept.rows}">
            <option value="${dept.dept_name}">${dept.dept_name}</option>
            </c:forEach>            
        </select>
</label>
        
        <label>
        <span>Year:</span>
            <select name="year" id="year" onchange="fetch()" >
            <optgroup label="----Year-----"></optgroup>
            <c:forEach var="year" items="${year.rows}">
            <option value="${year.year}">${year.year}</option>
            </c:forEach>
            
        </select>
        <span>Sec</span>
        <select name="sec"  id="sec" onchange="fetch()"  >
            <optgroup label="----Sec-----"></optgroup>
            <c:forEach var="sec" items="${sec.rows}">
            <option value="${sec.sec}">${sec.sec}</option>
            </c:forEach>
            
        </select>
         <span>Subject Code</span>
        <select name="sub"  id="sub" onchange="fetch()" >
            <optgroup label="----Subject-----"></optgroup>
            <option>-select subject--</option>
            <c:forEach var="sub" items="${sub.rows}">
            <option value="${sub.sub_code}">${sub.name}(${sub.sub_code})</option>
            </c:forEach>
            
        </select>
</label>
</form>
 <table id="tab" border="2px" style="box-shadow: 0 0px 18px 5px rgba(0,0,0,.35);border-radius:12px 8px;border-color: #21ffaa ">
        <thead>
        
        <tr>
        <th>TeacheName</th>
        <th>ClassDate</th>
        <th>StartTime</th>
        <th>EndTime</th>
        <th>RollNo</th>
        <th>Name</th>
        <th>Status</th>
        </tr>
        </thead>
        <tbody></tbody>
        </table>        


</body>
</html>