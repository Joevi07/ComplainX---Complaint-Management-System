package com.complaints;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateComplaintServlet")
public class UpdateComplaintServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int cid = Integer.parseInt(request.getParameter("cid"));
        String newStatus = request.getParameter("status");
        String remarks = request.getParameter("remarks");

        Connection con = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        PreparedStatement ps3 = null;

        try {
            con = DBConnection.getConnection();

            // 1️⃣ Get old status
            String oldStatus = "Pending";
            ps1 = con.prepareStatement("SELECT status FROM complaints WHERE complaint_id=?");
            ps1.setInt(1, cid);
            var rs = ps1.executeQuery();
            if (rs.next()) {
                oldStatus = rs.getString("status");
            }

            // 2️⃣ Update complaints table
            ps2 = con.prepareStatement("UPDATE complaints SET status=? WHERE complaint_id=?");
            ps2.setString(1, newStatus);
            ps2.setInt(2, cid);
            ps2.executeUpdate();

            // 3️⃣ Insert into complaint_updates table (history)
            ps3 = con.prepareStatement(
                "INSERT INTO complaint_updates(complaint_id, old_status, new_status, remarks) VALUES(?,?,?,?)"
            );
            ps3.setInt(1, cid);
            ps3.setString(2, oldStatus);
            ps3.setString(3, newStatus);
            ps3.setString(4, remarks);
            ps3.executeUpdate();

            // Redirect back to dashboard
            response.sendRedirect("adminDashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e);
        }
    }
}
