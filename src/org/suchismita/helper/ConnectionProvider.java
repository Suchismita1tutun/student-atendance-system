package org.suchismita.helper;


import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;



public class ConnectionProvider {


	public static Connection getConnection() throws NamingException, SQLException
	{
		
		Context ctx=new InitialContext();
		Context evctx=(Context)ctx.lookup("java:comp/env");
		DataSource ds=(DataSource)evctx.lookup("jdbc/iem");
		Connection conn=ds.getConnection();
		return conn;
	}
}

