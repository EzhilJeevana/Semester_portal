package com.edutrack.portal.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.edutrack.portal.db.DBConnection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    // Redirect GET requests to the JSP to avoid 404/405 errors
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection con = DBConnection.getConnection()) {
            String query = "SELECT email, role, student_id FROM users WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String role = rs.getString("role");
                String studentId = rs.getString("student_id");

                HttpSession session = request.getSession();
                session.setAttribute("role", role);
                session.setAttribute("user", ("student".equals(role) ? studentId : email));
                session.setAttribute("student_id", studentId);

                if ("admin".equals(role)) {
                    response.sendRedirect(request.getContextPath() + "/admin.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/student.jsp");
                }
            } else {
                // Return to login with error parameter
                response.sendRedirect("login.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Database connection failed");
        }
    }
}