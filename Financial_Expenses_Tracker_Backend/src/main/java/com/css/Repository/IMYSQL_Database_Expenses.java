package com.css.Repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.css.Entity.Expenses;

public interface IMYSQL_Database_Expenses extends CrudRepository<Expenses, Long> {
	
	public List<Expenses> findByExpenseDateBetween(LocalDate startDate, LocalDate endDate);
	
	public List<Expenses> findByExpenseDate(LocalDate expenseDate );
	

}
