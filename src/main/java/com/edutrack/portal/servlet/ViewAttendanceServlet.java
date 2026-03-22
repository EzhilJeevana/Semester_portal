package com.edutrack.portal.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.edutrack.portal.db.DBConnection;

@WebServlet("/viewAttendance")
public class ViewAttendanceServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if(session == null){
            response.sendRedirect("login.jsp");
            return;
        }

        String studentId = (String) session.getAttribute("student_id");
        ArrayList<String[]> attendanceList = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT student_id, subject, attendance_percentage FROM attendance WHERE student_id=?"
            );
            ps.setString(1, studentId);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                attendanceList.add(new String[]{
                    rs.getString("student_id"),
                    rs.getString("subject"),
                    rs.getString("attendance_percentage")
                });
            }

            rs.close();
            ps.close();
            con.close();

            request.setAttribute("attendanceList", attendanceList);
            request.getRequestDispatcher("viewAttendance.jsp").forward(request, response);

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}