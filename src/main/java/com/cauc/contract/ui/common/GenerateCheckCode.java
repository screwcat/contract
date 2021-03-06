package com.cauc.contract.ui.common;

/*
 * @(#)GenerateCheckCode.java
 * Description:	Finance
 * Version :	0.0.1
 * Copyright:	Copyright (c) 2012
 * Create by:	fuchaohui  2012-6-27
 */

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 生成验证码
 * 
 * @author zhaochunhui
 * 
 */
public class GenerateCheckCode extends HttpServlet {

	private static final long serialVersionUID = -1017341430367649593L;

	private Font mFont = new Font("Arial", Font.BOLD, 16);

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
	}

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setContentType("image/jpeg");

		int width = 55, height = 20;
		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

		Graphics g = image.getGraphics();
		g.setColor(new Color(35, 121, 170));
		g.fillRect(1, 1, width - 1, height - 1);
		g.setColor(new Color(255, 255, 255));
		g.drawRect(0, 0, width - 1, height - 1);
		g.setFont(mFont);

		String sRand = "";
		for (int i = 0; i < 4; i++) {
			String tmp = getRandomChar();
			sRand += tmp;
			// g.setColor(new
			// Color(20+random.nextInt(110),20+random.nextInt(110),20+random.nextInt(110)));
			g.setColor(new Color(191, 203, 215));
			g.drawString(tmp, 13 * i + 1, 16);
		}

		HttpSession session = request.getSession(true);
		session.setAttribute("verifyCode", sRand);
		g.dispose();
		ImageIO.write(image, "JPEG", response.getOutputStream());
		image.flush();
	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occure
	 */
	public void init() throws ServletException {
		// Put your code here
	}

	private String getRandomChar() {
		Random rd = new Random();
		return String.valueOf(rd.nextInt(10));
	}
}
