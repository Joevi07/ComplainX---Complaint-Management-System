package com.complaints;

import java.io.IOException;
import java.sql.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ComplaintServlet")
public class ComplaintServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String category = request.getParameter("category");
        String description = request.getParameter("description");

        try {
            HttpSession session = request.getSession(false);

            if (session == null || session.getAttribute("userId") == null) {
                response.sendRedirect("Login.html");
                return;
            }

            int userId = (int) session.getAttribute("userId");

            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO complaints(user_id, category, description, status) VALUES (?, ?, ?, 'Pending')";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, category);
            ps.setString(3, description);
            ps.executeUpdate();

            response.sendRedirect("userDashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("DB Error: " + e);
        }
    }
}
