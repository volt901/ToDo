//
//  ListСhildren.swift
//  ToDo
//
//  Created by Владимир Ширяев on 07.05.2023.
//

import SwiftUI
import RealmSwift

struct ListChildren: View {
    
    @State var showAlert = false
    @State var addTaskChildren = ""
    
    
    @State private var showingSetting = false

    @ObservedRealmObject var taskItem: Task
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            
            HStack {
                Text("ADD TASK")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                
                Spacer()
                
                Button {
                    showingSetting = true
                } label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                
                Button {
                    dismiss()
                } label: {
                    ZStack{
                        Image(systemName: "circle.fill")
                            .resizable()
                            .opacity(0.4)
                            .frame(width: 30, height: 30)
                        
                        Image(systemName: "multiply")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .fontWeight(.bold)
                    }
                }
            }
            .padding()
            
            HStack{
                TextField("Mission", text: $addTaskChildren)
                    .frame(height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.4))
                    .cornerRadius(15)
                    .background(.white)
                    .cornerRadius(10)
                    .alert(Text("Error"), isPresented: $showAlert) {
                        //
                    }
                
                Button {
                    if addTaskChildren.count == 0 {
                        showAlert.toggle()
                        //проверка на повтор
                    } else {
                        let mission = TaskLittel()
                        mission.title = addTaskChildren
                        $taskItem.taskLittel.append(mission)
                    }
                    
                } label: {
                    Text("Save")
                        .frame(width:100)
                        .frame(height: 40)
                        .background(.tint)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .font(.headline)
                }
            }
            .padding(.horizontal,10)
            
            List{
                ForEach(taskItem.taskLittel, id: \.id){ item in
                    Text(item.title)
                }
                .onDelete(perform: $taskItem.taskLittel.remove)
            }
            .sheet(isPresented: $showingSetting) {
                //изм. ранее введеного 
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ListChildren_Previews: PreviewProvider {
    static var previews: some View {
        ListChildren(taskItem: Task())
    }
}
