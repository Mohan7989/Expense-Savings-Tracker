package com.css.Service;

import java.time.LocalDate;
import java.util.List;

import com.css.Entity.Expenses;

public interface IExpenses_Service {
	
	public Expenses add_Expense(Expenses expenses);
	
	public List<Expenses> get_All_Expenses();
	
	public List<Expenses> get_Expenses_By_Date(LocalDate expenseDate);
	
	public Double get_Today_Total_Expense();
	
	public Double get_Current_Month_Total_Expense();

}
