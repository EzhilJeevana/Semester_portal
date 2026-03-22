package com.edutrack.portal.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.edutrack.portal.db.DBConnection;

/**
 * Servlet implementation for adding new users (Students/Admins)
 */
@WebServlet("/AddUserServlet")
public class AddUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Security Check: Ensure only logged-in admins can add users
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Retrieve parameters from the form
        String sid = request.getParameter("student_id");
        String nm = request.getParameter("name");
        String em = request.getParameter("email");
        String pw = request.getParameter("password");
        String rl = request.getParameter("role");

        // 3. Database operation
        // Using try-with-resources to ensure connection closure
        try (Connection con = DBConnection.getConnection()) {
            
            // The query matches your table structure: name, email, password, role, student_id
            String sql = "INSERT INTO users (name, email, password, role, student_id) VALUES (?, ?, ?, ?, ?)";
            
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, nm);
                ps.setString(2, em);
                ps.setString(3, pw);
                ps.setString(4, rl);
                ps.setString(5, sid);
                
                int result = ps.executeUpdate();
                
                if (result > 0) {
                    // Redirect back with success message
                    response.sendRedirect("admin.jsp?msg=added");
                } else {
                    response.sendRedirect("admin.jsp?msg=failed");
                }
            }
            
        } catch (SQLException e) {
            // Handle SQL specific errors (like duplicate email or student_id)
            e.printStackTrace();
            // Check for duplicate entry error code (MySQL specific 1062)
            if (e.getErrorCode() == 1062) {
                response.sendRedirect("addStudent.jsp?msg=duplicate");
            } else {
                response.sendRedirect("admin.jsp?msg=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp?msg=error");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect GET requests to the admin dashboard
        response.sendRedirect("admin.jsp");
    }
}