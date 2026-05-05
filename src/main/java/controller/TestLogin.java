package controller;

import dao.UserDao;

public class TestLogin {

	public static void main(String[] args) {
		UserDao userDao = new UserDao();
		
		
		System.out.println(userDao.autentica("2","anna_2005","docente"));

	}

}
