//
//  TaskListView.swift
//  ToDoList
//
//  Created by Parth Kanani on 06/12/25.
//

import SwiftUI

struct TaskListView: View {
    
    @ObservedObject var viewModel: TaskHomePageViewModel
    var currentDateTasks: [Task] = []
    
    init(viewModel: TaskHomePageViewModel) {
        self.viewModel = viewModel
        currentDateTasks = viewModel.getCurrentSelectedDateTask()
    }
    
    var body: some View {
        VStack {
            ForEach(currentDateTasks) { task in
                TaskListItem(task: task, onPress: { task in
                    toggleTaskCompletion(for: task)
                }, onLongPress: { task in
                    deleteTask(task: task)
                })
                    .background(alignment: .leading) {
                        if currentDateTasks.last?.id != task.id {
                            Rectangle()
                                .frame(width: 1)
                                .offset(x: 12, y: 20)
                        }
                    }
            }
        }
        .padding(.top, 15)
    }
    
    func toggleTaskCompletion(for task: Task) {
        viewModel.toggleTaskListCompletion(task: task)
    }
    
    func deleteTask(task: Task) {
        viewModel.deleteTask(task: task)
    }
}

#Preview {
    TaskHomePage(viewModel: TaskHomePageViewModel(
        dateUseCase: DateUseCase(dateRepository: DateRepository(dateProvider: DateDataProvider())),
        taskUseCase: TaskUseCase(taskRepository: TaskRepository(taskProvider: TaskDataProvider()))))
}
