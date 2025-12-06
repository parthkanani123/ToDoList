//
//  TaskListView.swift
//  ToDoList
//
//  Created by Parth Kanani on 06/12/25.
//

import SwiftUI

struct TaskListView: View {
    
    @Binding var date: Date
    @Binding var items: [Task]
    var currentDateTasks: [Task] = []
    
    init(date: Binding<Date>, items: Binding<[Task]>) {
        self._date = date
        self._items = items
        currentDateTasks = getCurrentTask()
    }
    
    var body: some View {
        Text("Hello, World!")
    }
    
    func getCurrentTask() -> [Task] {
        return items.filter { $0.date.toString(format: "EEEE, dd.MM.yyyy") == date.toString(format: "EEEE, dd.MM.yyyy") }.sorted { !$0.isCompleted && $1.isCompleted }
    }
}

#Preview {
    ContentView()
        .environmentObject(DateManager())
        .environmentObject(TaskListManager())
}
