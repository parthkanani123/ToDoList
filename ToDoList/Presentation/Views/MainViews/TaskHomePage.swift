//
//  ContentView.swift
//  ToDoList
//
//  Created by Parth Kanani on 02/12/25.
//

import SwiftUI

struct TaskHomePage: View {
    
    @State private var createNewTask: Bool = false
    
    @ObservedObject var viewModel: TaskHomePageViewModel
    
    var body: some View {
        ZStack {
            VStack {
                DateHeaderView(viewModel: viewModel)
                
                ScrollView(.vertical) {
                    VStack {
                        TaskListView(viewModel: viewModel)
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding()
            .overlay(alignment: .bottomTrailing) {
                Button {
                    createNewTask.toggle()
                } label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundStyle(.white)
                        .padding(26)
                        .background(.black)
                        .clipShape(.circle)
                        .padding(.horizontal)
                }

            }
        }
        .sheet(isPresented: $createNewTask) {
            NewTaskView(saveTask: { task in
                viewModel.updateTaskList(task: task)
            })
                .presentationDetents([.fraction(0.4)])
        }
    }
}

#Preview {
    TaskHomePage(viewModel: TaskHomePageViewModel(
        dateUseCase: DateUseCase(dateRepository: DateRepository(dateProvider: DateDataProvider())),
        taskUseCase: TaskUseCase(taskRepository: TaskRepository(taskProvider: TaskDataProvider()))))
}
