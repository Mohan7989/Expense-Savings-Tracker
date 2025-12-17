package com.css.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.css.Entity.Expenses;
import com.css.Repository.IMYSQL_Database_Expenses;

@Service
public class ExpensesService implements IExpenses_Service {

    @Autowired
    private IMYSQL_Database_Expenses mysqlExpenses;

    @Override
    public Expenses add_Expense(Expenses expenses) {

        if (expenses.getAmount() <= 0) {
            throw new IllegalArgumentException("Amount must be greater than zero");
        }

        if (expenses.getExpenseDate() == null) {
            expenses.setExpenseDate(LocalDate.now());
        }

        if (expenses.getCreated_at() == null) {
            expenses.setCreated_at(LocalTime.now().toString());
        }

        return mysqlExpenses.save(expenses);
    }

    @Override
    public List<Expenses> get_All_Expenses() {

        List<Expenses> list = new ArrayList<>();
        mysqlExpenses.findAll().forEach(list::add);
        return list;

    }

    @Override
    public List<Expenses> get_Expenses_By_Date(LocalDate expenseDate) {
        return mysqlExpenses.findByExpenseDate(expenseDate);
    }

    @Override
    public Double get_Today_Total_Expense() {

        List<Expenses> list = mysqlExpenses.findByExpenseDate(LocalDate.now());
        double sum = 0.0;

        for (Expenses e : list) {
            sum += e.getAmount();
        }
        return sum;
    }

    @Override
    public Double get_Current_Month_Total_Expense() {

        LocalDate startDate = LocalDate.now().withDayOfMonth(1);
        LocalDate endDate = LocalDate.now()
                .withDayOfMonth(LocalDate.now().lengthOfMonth());

        List<Expenses> list = mysqlExpenses.findByExpenseDateBetween(startDate, endDate);

        double sum = 0.0;
        for (Expenses e : list) {
            sum += e.getAmount();
        }
        return sum;
    }
}
