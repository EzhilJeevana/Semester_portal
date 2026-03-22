package com.edutrack.portal.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.edutrack.portal.db.DBConnection;

@WebServlet("/testdb")
public class TestConnectionServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        Connection con = DBConnection.getConnection();

        if (con != null) {
            out.println("<h2>✅ Database Connected Successfully!</h2>");
        } else {
            out.println("<h2>❌ Database Connection Failed!</h2>");
        }
    }
}