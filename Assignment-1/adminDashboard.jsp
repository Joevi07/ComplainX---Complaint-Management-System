<%@ page import="java.sql.*" %>
<%@ page import="com.complaints.DBConnection" %>
<%@ page import="jakarta.servlet.http.*" %>

<%
HttpSession session1 = request.getSession(false);
if(session1 == null || session1.getAttribute("role") == null|| !session1.getAttribute("role").equals("admin")){
    response.sendRedirect("Login.html");
    return;
}
String adminName = (String) session1.getAttribute("username");
%>

<!DOCTYPE html>
<html>
<head>
<title>ComplainX - Admin Dashboard</title>
<meta charset="UTF-8">
<link rel="stylesheet" href="CSS/dashboard.css">
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Outfit:wght@600;700&display=swap" rel="stylesheet">

<style>
*{margin:0;padding:0;box-sizing:border-box;}

body{
    font-family:'DM Sans',sans-serif;
    background:linear-gradient(135deg,#2d3436,#6c5ce7);
    padding:20px;min-height:100vh;
}
.container{max-width:1500px;margin:auto;}


</style>
</head>

<body>
<div class="container">
<!-- HEADER -->
<div class="header">
    <div style="display:flex;gap:15px;align-items:center;">
        <div class="logo"><img src="assets/dashboard.png"></div>
        <div>
            <h1>Admin Dashboard</h1>
            <p>Welcome, <b><%= adminName %></b></p>
        </div>
    </div>
    <div class="user-avatar"><%= adminName.trim().substring(0,1).toUpperCase() %></div>
</div>

<div class="main-grid">

<!-- SIDEBAR -->
<div class="sidebar">
    <a class="nav-item" href="adminDashboard.jsp">Dashboard</a>
    <a class="nav-item" href="LogoutServlet">Logout</a>
</div>

<!-- MAIN CARD -->
<div class="card">

<!-- STATUS ANALYSIS -->
<div class="stats">
<%
Connection con = DBConnection.getConnection();
PreparedStatement psStat = con.prepareStatement(
"SELECT status, COUNT(*) cnt FROM complaints GROUP BY status");
ResultSet rsStat = psStat.executeQuery();

int pending=0,progress=0,resolved=0;
while(rsStat.next()){
    if(rsStat.getString("status").equalsIgnoreCase("Pending")) pending=rsStat.getInt("cnt");
    if(rsStat.getString("status").equalsIgnoreCase("In Progress")) progress=rsStat.getInt("cnt");
    if(rsStat.getString("status").equalsIgnoreCase("Resolved")) resolved=rsStat.getInt("cnt");
}
%>
<div class="stat-box pending">Pending: <%= pending %></div>
<div class="stat-box progress">In Progress: <%= progress %></div>
<div class="stat-box resolved">Resolved: <%= resolved %></div>
</div>

<!-- COMPLAINT TABLE -->
<h3>All Complaints</h3>
<table>
<tr>
<th>ID</th>
<th>User ID</th>
<th>Category</th>
<th>Description</th>
<th>Status</th>
<th>Update</th>
</tr>

<%
PreparedStatement ps = con.prepareStatement("SELECT * FROM complaints ORDER BY complaint_id");
ResultSet rs = ps.executeQuery();
while(rs.next()){
%>
<tr>
<td><%= rs.getInt("complaint_id") %></td>
<td><%= rs.getInt("user_id") %></td>
<td><%= rs.getString("category") %></td>
<td><%= rs.getString("description") %></td>
<td><b><%= rs.getString("status") %></b></td>

<td>
<form action="UpdateComplaintServlet" method="post">
<input type="hidden" name="cid" value="<%= rs.getInt("complaint_id") %>">

<select name="status" class="status-select">
<option>Pending</option>
<option>In Progress</option>
<option>Resolved</option>
</select>

<input type="text" name="remarks" placeholder="Remarks">

<button type="submit" class="update-btn">Update</button>
</form>
</td>

</tr>
<% } %>
</table>

</div>
</div>
</div>
</body>
</html>
