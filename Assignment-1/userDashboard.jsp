<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="com.complaints.DBConnection" %>

<%
HttpSession session1 = request.getSession(false);
if(session1 == null || session1.getAttribute("userId") == null) {
    response.sendRedirect("Login.html");
    return;
}

String username = (String) session1.getAttribute("username");
int userId = (int) session1.getAttribute("userId");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ComplainX - User Dashboard</title>
<link rel="stylesheet" href="CSS/dashboard.css"> 
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Outfit:wght@600;700&display=swap" rel="stylesheet">

<style>
*{margin:0;padding:0;box-sizing:border-box;}

body {
    font-family:'DM Sans',sans-serif;
    background: linear-gradient(135deg,#2d3436,#6c5ce7);
    padding:20px;
    min-height:100vh;
}
.container {max-width:1400px;margin:auto;}

</style>
</head>

<body>

<div class="container">

<!-- HEADER -->
<div class="header">
    <div style="display:flex;gap:15px;align-items:center;">
        <div class="logo"><img src="assets/dashboard.png"></div>
        <div>
            <h1>My Dashboard</h1>
            <p>Welcome, <b><%= username %></b></p>
        </div>
    </div>
    <div class="user-avatar"><%= username.trim().substring(0,1).toUpperCase() %></div>
</div>

<!-- MAIN GRID -->
<div class="main-grid">

<!-- SIDEBAR -->
<div class="sidebar">
    <a href="userDashboard.jsp" class="nav-item">Dashboard</a>
    <a href="#" class="nav-item" onclick="openTrackModal()">Track</a>
    <a href="LogoutServlet" class="nav-item">Logout</a>
</div>

<!-- COMPLAINTS CARD -->
<div class="card">
    <div class="card-header">
        <h2>My Complaints</h2>
        <a href="complaint-form.html" class="btn-new">+ New Complaint</a>
    </div>

    <!-- LOAD COMPLAINTS FROM DB -->
    <div id="complaintsList">
    <%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = DBConnection.getConnection();
        ps = con.prepareStatement("SELECT * FROM complaints WHERE user_id=? ORDER BY complaint_id");
        ps.setInt(1, userId);
        rs = ps.executeQuery();

        while(rs.next()) {
    %>
        <div class="complaint-item">
            <b>ID:</b> <%= rs.getInt("complaint_id") %><br>
            <b>Category:</b> <%= rs.getString("category") %><br>
            <b>Description:</b> <%= rs.getString("description") %><br>
            <b>Status:</b> <span style="color:green;"><%= rs.getString("status") %></span>
        </div>
    <%
        }
    } catch(Exception e) {
        out.println("Error: " + e);
    }
    %>
    </div>

</div>

<!-- PROFILE -->
<div class="profile-card">
    <h3>My Profile</h3>
    <p>Username: <%= username %></p>
    <p>User ID: <%= userId %></p>
</div>

</div>
</div>

<!-- TRACK MODAL -->
<div class="modal" id="trackModal">
    <div class="modal-content">
        <h3>Track Complaint</h3>
        <input type="text" id="trackId" placeholder="Enter Complaint ID">
        <button onclick="trackComplaint()">Track</button>
        <div id="trackResult"></div>
        <button onclick="closeTrackModal()">Close</button>
    </div>
</div>

<!-- JS -->
<script src="JS/dashboard.js"></script>

</body>
</html>
