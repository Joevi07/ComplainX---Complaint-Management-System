<%@ page import="java.sql.*" %>
<%@ page import="com.complaints.DBConnection" %>

<%
String cid = request.getParameter("cid");

if(cid == null || cid.equals("")) {
    out.println("<p style='color:red'>Enter Complaint ID</p>");
    return;
}

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    con = DBConnection.getConnection();
    ps = con.prepareStatement(
        "SELECT * FROM complaint_updates WHERE complaint_id=? ORDER BY updated_at DESC"
    );
    ps.setInt(1, Integer.parseInt(cid));
    rs = ps.executeQuery();
%>

<h4>Complaint ID: <%= cid %></h4>

<%
    boolean found = false;
    while(rs.next()) {
        found = true;
%>
        <p>
        <b style="color:red"><%= rs.getString("old_status") %></b> 
        <b>&rAarr;</b> 
        <b style="color:green;"><%= rs.getString("new_status") %></b><br>
        Remarks: <%= rs.getString("remarks") %><br>
        Time: <%= rs.getTimestamp("updated_at") %>
        </p>
        <hr>
<%
    }

    if(!found) {
        out.println("<p>No updates found yet.</p>");
    }

} catch(Exception e) {
    out.println("<p style='color:red'>Error: "+e+"</p>");
}
%>
