//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Parth Kanani on 02/12/25.
//

import SwiftUI

@main
struct ToDoListApp: App {
    
    @StateObject var dateManager: DateManager = DateManager()
    @StateObject var taskListManager: TaskListManager = TaskListManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dateManager)
                .environmentObject(taskListManager)
        }
    }
}
