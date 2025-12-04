package com.club.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.club.dao.ClubDAO;
import com.club.dto.ClubDTO;

/**
 * 동아리 목록 화면을 처리하는 서블릿
 * - GET 요청 시 동아리 전체 목록을 DB에서 조회
 * - clubs.jsp로 데이터를 전달하여 카드 UI로 출력하게 함
 */
@WebServlet("/clubs")   // 주소: /clubs 로 접근 가능
public class ClubsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * GET 요청 처리
	 * 동아리 리스트를 DB에서 가져와 JSP에 전달하는 핵심 부분임
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// 1. DAO 생성
		ClubDAO dao = new ClubDAO();
		
		// 2. 전체 동아리 목록 가져오기
		List<ClubDTO> clubs = dao.findAll();
		
		// 3. JSP에서 사용할 수 있도록 request에 담기
		request.setAttribute("clubs", clubs);
		
		// 4. clubs.jsp로 페이지 이동 (forward)
		request.getRequestDispatcher("/clubs.jsp").forward(request, response);
	}

	/**
	 * POST 요청이 들어오면 GET 처리로 넘김
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
