//
//  DateRepository.swift
//  ToDoList
//
//  Created by Parth Kanani on 06/12/25.
//

import Foundation

protocol DateRepositoryProtocol {
    func calculatePastAndFutureWeeks(with date: Date) -> [WeekModel]
}

class DateRepository {
    private let dateProvider: DateDataProviderProtocol
    
    init(dateProvider: DateDataProviderProtocol) {
        self.dateProvider = dateProvider
    }
}

extension DateRepository: DateRepositoryProtocol {
    
    func calculatePastAndFutureWeeks(with date : Date) -> [WeekModel] {
        return dateProvider.calculatePastAndFutureWeeks(with: date)
    }
}
