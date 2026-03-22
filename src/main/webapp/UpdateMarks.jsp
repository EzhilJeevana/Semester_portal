<%@ page import="java.sql.*, com.edutrack.portal.db.DBConnection" %>
<%
String user = (String) session.getAttribute("user");
if(user == null){
    response.sendRedirect("login.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Update Marks</title>
<style>
body{text-align:center;margin-top:50px;font-family:Arial;}
input{padding:5px;margin:2px;}
table{margin:auto;border-collapse:collapse;}
th,td{padding:8px;border:1px solid #000;}
</style>
</head>
<body>
<h2>Update Marks Records</h2>

<%
Connection con = DBConnection.getConnection();
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM marks");
%>

<table>
<tr>
<th>ID</th>
<th>Student ID</th>
<th>Subject</th>
<th>Marks</th>
<th>Action</th>
</tr>

<%
while(rs.next()){
%>
<tr>
<form action="UpdateMarksServlet" method="post">
<td><%=rs.getInt("id")%>
<input type="hidden" name="id" value="<%=rs.getInt("id")%>"></td>
<td><%=rs.getString("student_id")%></td>
<td><%=rs.getString("subject")%></td>
<td>
<input type="number" name="marks" value="<%=rs.getInt("marks")%>" min="0" max="100">
</td>
<td><input type="submit" value="Update"></td>
</form>
</tr>
<%
}
rs.close();
st.close();
con.close();
%>
</table>

<br><a href="admin.jsp">Back to Dashboard</a>
</body>
</html>