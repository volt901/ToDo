//
//  AddTask.swift
//  ToDo
//
//  Created by Владимир Ширяев on 07.05.2023.
//

import SwiftUI
import RealmSwift

struct AddTask: View {
    
    @State var showAlert = false
    @State var addTask = ""
    
    @ObservedResults(Task.self) var taskItem
    
    @Environment(\.dismiss) var dismiss

    @State private var selectedColor = "Red"
    let colors = ["Red", "Blue", "Green"]
    
    @State private var selectedImage = "circle.fill"
    let images = ["circle.fill","pencil.circle", "calendar.circle", "graduationcap.circle"]
    
    
    var body: some View {
        VStack{
            HStack {
                Text("ADD TASK")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                
                Spacer()
                
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
                Image(systemName:  selectedImage)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(selectedColor))
                    .padding(.horizontal,8)
                
                TextField("Mission", text: $addTask)
                    .frame(height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.4))
                    .cornerRadius(15)
            }
            .padding(.horizontal)
            .background(.white)
            .cornerRadius(10)
            .alert(Text("Error"), isPresented: $showAlert) {
                //
            }
            
            Picker("", selection: $selectedColor) {
                ForEach(colors, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .padding(.vertical,10)
            .padding(.horizontal,20)
            
            Picker("", selection: $selectedImage) {
                ForEach(images, id: \.self) {
                    Image(systemName: $0)
                        .resizable()
                        .frame(width: 35, height: 35)
                        .frame(width: 30, height: 30)
                        .padding(.horizontal,8)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal,20)
            
            Button {
                if addTask.count == 0 {
                    showAlert.toggle()
                    //проверка на повтор 
                } else {
                    let mission = Task()
                    mission.title = addTask
                    mission.color = selectedColor
                    mission.image = selectedImage
                    $taskItem.append(mission)
                    dismiss()
                }
                
            } label: {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(.tint)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .font(.headline)
                    .padding()
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        AddTask()
    }
}

