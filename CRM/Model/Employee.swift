//
//  Employee.swift
//  CRM
//
//  Created by Ilia Loviagin on 9/13/25.
//

import Foundation

struct Employee: Identifiable, Codable, Equatable {
    
    var id: UUID = UUID()
    var name: String = ""
    var jobTitle: String = ""
    var niNumber: String? = nil
    var taxCode: String? = nil
    var salary: Double? = nil
    var employeeNumber: String? = nil
    var dateOfBirth: Date? = nil
    var gender: String? = nil
    var address: String? = nil
    var email: String? = nil
    var phone: String? = nil
    var employmentStartDate: Date? = nil
    var niCategory: String? = nil
    var payFrequency: String? = nil // weekly, monthly
    var hoursPerWeek: Double? = nil
    var basicRatePerHour: Double? = nil
    var isDirector: Bool = false
    var directorshipStartDate: Date? = nil
    var nicsCalculationMethod: String? = nil
    var pensionScheme: String? = nil
    var leaveAllowanceDays: Int? = nil
    var paymentMethod: String? = nil
    var bankAccount: String? = nil
    var bankSortCode: String? = nil
    
    init(id: UUID = UUID(), name: String, jobTitle: String, niNumber: String? = nil, taxCode: String? = nil, salary: Double? = nil, employeeNumber: String? = nil, dateOfBirth: Date? = nil, gender: String? = nil, address: String? = nil, email: String? = nil, phone: String? = nil, employmentStartDate: Date? = nil, niCategory: String? = nil, payFrequency: String? = nil, hoursPerWeek: Double? = nil, basicRatePerHour: Double? = nil, isDirector: Bool, directorshipStartDate: Date? = nil, nicsCalculationMethod: String? = nil, pensionScheme: String? = nil, leaveAllowanceDays: Int? = nil, paymentMethod: String? = nil, bankAccount: String? = nil, bankSortCode: String? = nil) {
        self.id = id
        self.name = name
        self.jobTitle = jobTitle
        self.niNumber = niNumber
        self.taxCode = taxCode
        self.salary = salary
        self.employeeNumber = employeeNumber
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.address = address
        self.email = email
        self.phone = phone
        self.employmentStartDate = employmentStartDate
        self.niCategory = niCategory
        self.payFrequency = payFrequency
        self.hoursPerWeek = hoursPerWeek
        self.basicRatePerHour = basicRatePerHour
        self.isDirector = isDirector
        self.directorshipStartDate = directorshipStartDate
        self.nicsCalculationMethod = nicsCalculationMethod
        self.pensionScheme = pensionScheme
        self.leaveAllowanceDays = leaveAllowanceDays
        self.paymentMethod = paymentMethod
        self.bankAccount = bankAccount
        self.bankSortCode = bankSortCode
    }
    
    init() {  }
}
