package com.complaints;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String role = request.getParameter("role"); // "admin" or "user"

        try (Connection conn = DBConnection.getConnection()) {

            if ("admin".equalsIgnoreCase(role)) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String email = request.getParameter("email");

                String checkAdminSql = "SELECT * FROM admin WHERE username=?";
                PreparedStatement checkAdminPs = conn.prepareStatement(checkAdminSql);
                checkAdminPs.setString(1, username);
                ResultSet adminRs = checkAdminPs.executeQuery();

                if (adminRs.next()) {
                    response.sendRedirect("SignUp.html?error=exists");
                    return;
                }

                String insertAdminSql = "INSERT INTO admin(username, password, email) VALUES (?, ?, ?)";
                PreparedStatement insertAdminPs = conn.prepareStatement(insertAdminSql);
                insertAdminPs.setString(1, username);
                insertAdminPs.setString(2, password);
                insertAdminPs.setString(3, email);
                insertAdminPs.executeUpdate();

            } else {
                String name = request.getParameter("username");
                String password = request.getParameter("password");
                String email = request.getParameter("email");

                String checkUserSql = "SELECT * FROM users WHERE name=? OR email=?";
                PreparedStatement checkUserPs = conn.prepareStatement(checkUserSql);
                checkUserPs.setString(1, name);
                checkUserPs.setString(2, email);
                ResultSet userRs = checkUserPs.executeQuery();

                if (userRs.next()) {
                    response.sendRedirect("SignUp.html?error=exists");
                    return;
                }

                String insertUserSql = "INSERT INTO users(name, password, email) VALUES (?, ?, ?)";
                PreparedStatement insertUserPs = conn.prepareStatement(insertUserSql);
                insertUserPs.setString(1, name);
                insertUserPs.setString(2, password);
                insertUserPs.setString(3, email);
                insertUserPs.executeUpdate();
            }

            response.sendRedirect("Login.html?signup=success");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("SignUp.html?error=db");
        }
    }
}
