package com.mycompany.BankingSystemDB.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import com.mycompany.BankingSystemDB.POJOs.Employee;

public interface EmployeeRepository extends JpaRepository<Employee, Integer> {

}
