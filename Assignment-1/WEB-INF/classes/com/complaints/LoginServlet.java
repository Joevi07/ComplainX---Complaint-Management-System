
package com.complaints;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {

            String role = null;
            int userId = 0; 

            String adminSql = "SELECT * FROM admin WHERE username=?";
            PreparedStatement adminPs = conn.prepareStatement(adminSql);
            adminPs.setString(1, username);
            ResultSet adminRs = adminPs.executeQuery();

            if (adminRs.next()) {
                if (adminRs.getString("password").equals(password)) {
                    role = "admin";
                } else {
                    response.sendRedirect("Login.html?error=invalid");
                    return;
                }
            } 
            else {
                String userSql = "SELECT user_id, name, password FROM users WHERE name=?";
                PreparedStatement userPs = conn.prepareStatement(userSql);
                userPs.setString(1, username);
                ResultSet userRs = userPs.executeQuery();

                if (userRs.next()) {
                    if (userRs.getString("password").equals(password)) {
                        role = "user";
                        userId = userRs.getInt("user_id");
                    } else {
                        response.sendRedirect("Login.html?error=invalid");
                        return;
                    }
                } else {
                    response.sendRedirect("SignUp.html");
                    return;
                }
            }

            // Create session
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", role);
            session.setAttribute("userId", userId); // ✅ STORE USER ID

            System.out.println("Logged User ID = " + userId); // debug

            if ("admin".equals(role)) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("userDashboard.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("Login.html?error=db");
        }
    }
}
