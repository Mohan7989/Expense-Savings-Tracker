package com.css.Repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.css.Entity.SavingsTransaction;

public interface SavingsTransactionRepository
        extends CrudRepository<SavingsTransaction, Long> {

    List<SavingsTransaction> findBySavingsGoalId(Long savingsGoalId);
}
