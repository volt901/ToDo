//
//  Setting.swift
//  ToDo
//
//  Created by Владимир Ширяев on 07.05.2023.
//

import SwiftUI
import RealmSwift

struct Setting: View {
    
    let colors = ["Red", "Blue", "Green"]

    let images = ["circle.fill","pencil.circle", "calendar.circle", "graduationcap.circle"]
        
    @State var showAlert = false
    @Binding var  settingTask : String
    
    @ObservedResults(Task.self) var taskItem
    
    @Environment(\.dismiss) var dismiss

    @Binding var  settingColor : String
    
    @Binding var settingImage : String
    

    
    var body: some View {
        VStack{
            HStack {
                Text("Setting")
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
                Image(systemName:  settingImage)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(settingColor))
                    .padding(.horizontal,8)
                
                TextField("Mission", text: $settingTask)
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
            
            Picker("", selection: $settingColor) {
                ForEach(colors, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .padding(.vertical,10)
            .padding(.horizontal,20)
            
            Picker("", selection: $settingImage) {
                ForEach(images, id: \.self) {
                    Image(systemName: $0)
                        .resizable()
                        .frame(width: 35, height: 35)
                        .frame(width: 30, height: 30)
                        //.foregroundColor(Color(color))
                        .padding(.horizontal,8)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal,20)
            
            Button {
                if settingTask.count == 0 {
                    showAlert.toggle()
                } else {
                    let mission = Task()
                    mission.title = settingTask
                    mission.color = settingColor
                    mission.image = settingImage
                    $taskItem.remove(mission)
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

//struct Setting_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskList()
////        Setting(settingTask: $addTask, settingColor: $selectedColor, settingImage: $selectedImage)
//    }
//}
