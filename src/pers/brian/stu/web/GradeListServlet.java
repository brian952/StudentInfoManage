package pers.brian.stu.web;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import pers.brian.stu.dao.GradeDao;
import pers.brian.stu.mod.Grade;
import pers.brian.stu.mod.PageBean;
import pers.brian.stu.util.DbUtil;
import pers.brian.stu.util.JsonUtil;
import pers.brian.stu.util.ResponseUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;



public class GradeListServlet extends HttpServlet {
	DbUtil dbUtil = new DbUtil();
	GradeDao gradeDao = new GradeDao();
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,
			IOException {
		this.doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
			IOException {
		String page = request.getParameter("page");
		String rows = request.getParameter("rows");
		String gradeName = request.getParameter("gradeName");

		if(gradeName==null){
			gradeName="";
		}

		Grade grade = new Grade();
		grade.setGradeName(gradeName);

		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Connection con = null;
		try{
			con = dbUtil.getCon();
			JSONObject result = new JSONObject();
			JSONArray jsonArray = JsonUtil.formatRsToJsonArray(gradeDao.gradeList(con, pageBean, grade));

			int total = gradeDao.gradeCount(con, grade);
			result.put("rows", jsonArray);
			result.put("total", total);

			ResponseUtil.write(response, result);
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			try{
				dbUtil.closeCon(con);
			}catch (Exception e){
				e.printStackTrace();
			}
		}
	}
}
