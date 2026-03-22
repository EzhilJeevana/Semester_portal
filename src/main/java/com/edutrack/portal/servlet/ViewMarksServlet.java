package com.edutrack.portal.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.edutrack.portal.db.DBConnection;

@WebServlet("/viewMarks")
public class ViewMarksServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if(session == null){
            response.sendRedirect("login.jsp");
            return;
        }

        String studentId = (String) session.getAttribute("student_id");
        ArrayList<String[]> marksList = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT student_id, subject, marks FROM marks";
            if(studentId != null) sql += " WHERE student_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            if(studentId != null) ps.setString(1, studentId);

            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                marksList.add(new String[]{
                    rs.getString("student_id"),
                    rs.getString("subject"),
                    rs.getString("marks")
                });
            }

            rs.close();
            ps.close();
            con.close();

            request.setAttribute("marksList", marksList);
            request.getRequestDispatcher("viewMarks.jsp").forward(request,response);

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}