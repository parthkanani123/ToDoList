//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Parth Kanani on 02/12/25.
//

import SwiftUI

@main
struct ToDoListApp: App {
    
    @StateObject var taskHomePageViewModel: TaskHomePageViewModel = TaskHomePageViewModel(dateUseCase: DateUseCase(dateRepository: DateRepository(dateProvider: DateDataProvider())), taskUseCase: TaskUseCase(taskRepository: TaskRepository(taskProvider: TaskDataProvider())))
    
    var body: some Scene {
        WindowGroup {
            TaskHomePage(viewModel: taskHomePageViewModel)
        }
    }
}
