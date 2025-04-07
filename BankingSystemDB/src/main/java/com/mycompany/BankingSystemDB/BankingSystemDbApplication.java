package com.mycompany.BankingSystemDB;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;

@SpringBootApplication
public class BankingSystemDbApplication {

	public static void main(String[] args) {
		SpringApplication.run(BankingSystemDbApplication.class, args);
	}
	
//	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
//        return application.sources(BankingSystemDbApplication.class);
//    }

}
