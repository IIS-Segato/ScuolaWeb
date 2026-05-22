package dao;

import java.util.List;

public interface DAO<T> {

	List<T> getAll() throws Exception;

	T getByID(int id) throws Exception;

	boolean insert(T obj) throws Exception;

	boolean update(T obj) throws Exception;

	boolean delete(int id) throws Exception;
}
