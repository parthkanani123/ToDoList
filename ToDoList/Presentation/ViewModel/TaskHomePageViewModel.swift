//
//  TaskHomePageViewModel.swift
//  ToDoList
//
//  Created by Parth Kanani on 06/12/25.
//

import Foundation

struct TaskHomePageConstants {
    
}

enum SliderTimeDirection {
    case future
    case past
    case unknown
}


protocol TaskHomePageViewModelInput {
    func selectTheDay(with date: Date)
    func OnDateScrollTo(to direction: SliderTimeDirection)
    
    func updateTaskList(task: Task)
    func toggleTaskListCompletion(task: Task)
    func deleteTask(task: Task)
}

protocol TaskHomePageViewModelOutput {
    func getSeletedDate() -> Date
    func getCurrentSelectedDateTask() -> [Task]
}

protocol TaskHomePageViewModelProtocol: ObservableObject, TaskHomePageViewModelInput, TaskHomePageViewModelOutput {
    
}

class TaskHomePageViewModel: TaskHomePageViewModelProtocol {
    private let dateUseCase: DateUseCaseProtocol
    private let taskUseCase: TaskUseCaseProtocol
    
    @Published var items: [Task] = []
    @Published var weeks: [WeekModel] = []
    @Published var selectedDate: Date {
        didSet {
            calculatePastAndFutureWeeks(with: selectedDate)
        }
    }
    
    init(dateUseCase: DateUseCaseProtocol, taskUseCase: TaskUseCaseProtocol, with date: Date = Date()) {
        self.dateUseCase = dateUseCase
        self.taskUseCase = taskUseCase
        self.selectedDate = Calendar.current.startOfDay(for: date)
        self.items = taskUseCase.getTaskList()
        calculatePastAndFutureWeeks(with: selectedDate)
    }
    
    private func calculatePastAndFutureWeeks(with date: Date) {
        weeks = dateUseCase.calculatePastAndFutureWeeks(with: date)
    }
}

// MARK: - Input Protocol Implementation
extension TaskHomePageViewModel: TaskHomePageViewModelInput {
    
    func selectTheDay(with date: Date) {
        selectedDate = Calendar.current.startOfDay(for: date)
    }
    
    func OnDateScrollTo(to direction: SliderTimeDirection) {
        switch direction {
        case .future:
            selectedDate = Calendar.current.date(byAdding: .day, value: 7, to: selectedDate)!
        case .past:
            selectedDate = Calendar.current.date(byAdding: .day, value: -7, to: selectedDate)!
        case .unknown:
            selectedDate = selectedDate
        }
        
        calculatePastAndFutureWeeks(with: selectedDate)
    }
    
    func updateTaskList(task: Task) {
        items = taskUseCase.updateTaskList(task: task)
    }
    
    func toggleTaskListCompletion(task: Task) {
        items = taskUseCase.toggleTaskCompletion(task: task)
    }
    
    func deleteTask(task: Task) {
        items = taskUseCase.deleteTask(task: task)
    }
}

// MARK: - Output Protocol Implementation
extension TaskHomePageViewModel: TaskHomePageViewModelOutput {
    func getSeletedDate() -> Date {
        selectedDate
    }
    
    func getCurrentSelectedDateTask() -> [Task] {
        taskUseCase.getcurrentSelectedDateTasks(of: selectedDate)
    }
}
