//
//  Task.swift
//  ToDo
//
//  Created by Владимир Ширяев on 07.05.2023.
//

import SwiftUI
import RealmSwift

struct TaskList: View {
    
    @ObservedResults(Task.self) var taskItem
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(taskItem, id: \.id){ item in

                    TaskView(title: item.title, color: item.color, image: item.image)
                }
                .onDelete(perform: $taskItem.remove)
            }
            .navigationTitle("Task")
          
            
            HStack{
                Spacer()
                NavigationLink {
                    AddTask()
                } label: {
                    HStack{
                        Image(systemName: "plus.circle")
                        Text("ADD TASK")
                    }
                    .padding(10)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                }
            }
        }
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList()
    }
}

struct TaskView: View {
    
    @State var title: String //= "work"
    @State var color: String //= "red"
    @State var image: String //= "book.circle"
    
    var body: some View {
        VStack{
            NavigationLink {
                ListChildren(taskItem: Task())
            } label: {
                HStack{
                    Image(systemName: image)
                        .resizable()
                        .frame(width: 35, height: 35)
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(color))
                        .padding(.horizontal,8)
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
        }
    }
}
