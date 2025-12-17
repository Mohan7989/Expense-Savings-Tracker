package com.css.Repository;



import org.springframework.data.repository.CrudRepository;

import com.css.Entity.Expenses;
import com.css.Entity.Savings_goal;

public interface IMYSQL_Database_Savings_Goals extends CrudRepository<Savings_goal, Long> {

	
}
