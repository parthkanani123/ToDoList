//
//  DateHeaderView.swift
//  ToDoList
//
//  Created by Parth Kanani on 02/12/25.
//

import SwiftUI

struct DateHeaderView: View {
    
    @EnvironmentObject var dateManager: DateManager
    
    var body: some View {
        ZStack {
            VStack {
                nameHeaderTextView()
            }
        }
    }
    
    @ViewBuilder
    private func nameHeaderTextView() -> some View {
        HStack {
            
            VStack(alignment: .listRowSeparatorLeading, spacing: 0) {
                Text("Hi, Javid")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .padding(4)
                
                Text(dateManager.selectedDate == Calendar.current.startOfDay(for: Date()) ? "What's up for today?" : "Planning for future?")
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundStyle(.black)
                    .padding(4)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(dateManager.selectedDate.monthToString())
                    .font(.system(size: 10))
                    .fontWeight(.heavy)
                    .foregroundStyle(.black)
                
                Button {
                    withAnimation(.linear(duration: 0.1)) {
                        dateManager.selectToday()
                    }
                } label: {
                    Text("Today")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(4)
                        .background(.black)
                        .cornerRadius(4)
                }
            }
        }
    }
}

#Preview {
    DateHeaderView()
        .environmentObject(DateManager())
}
