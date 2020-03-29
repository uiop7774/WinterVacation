//
//  PersonalSpaceView.swift
//  RefreshableList_ver2
//
//  Created by James on 2020/3/28.
//  Copyright © 2020 James. All rights reserved.
//

import SwiftUI

struct PersonalSpaceView: View {
    
    @State private var ModalIsShowed:Bool = false
    @State private var draggedOffset = CGSize.zero
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack{
                
                VStack{
                    Image(systemName: "dollarsign.circle.fill")
                        .font(.system(size:200))
                        .frame(width: 350, height: 200)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.green, lineWidth: 3)
                        )
                    Image(systemName: "person.circle.fill")
                        //.foregroundColor(Color.white)
                        .font(.system(size:150))
                        .frame(width: 160, height: 160)
                        .background(Color.white)
                        .cornerRadius(75)
                        .overlay(
                            Circle()
                                .stroke(Color.green, lineWidth: 3)
                        )
                    Spacer()
                }
                
                VStack{
                    Spacer()
                        .frame(height: 600)
                    Button(action: {
                        print("???")
                        self.ModalIsShowed.toggle()
                    }) {
                        Image(systemName: "chevron.up")
                        .font(.system(size:50))
                        .frame(width: 77, height: 70)
                        .imageScale(.small)
                        .foregroundColor(Color.green)
                        .background(Color.white)
                        .cornerRadius(38.5)
                        .padding()
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 10,
                                x: 3,
                                y: 3)
                    }.sheet(isPresented: self.$ModalIsShowed){
                        ModalView()
                    }
                }
                
            }
            .frame(width: geometry.size.width)
            .background(Color(#colorLiteral(red: 0.9123613238, green: 0.7806475759, blue: 0.4903261065, alpha: 1)))
            .gesture(
                DragGesture()
                    .onChanged{ value in
                        self.draggedOffset = value.translation
                    }
                    .onEnded { value in
                        if self.draggedOffset.height < -200 {
                            self.ModalIsShowed.toggle()
                        }
                    }
            )
            
        }
    }
}

struct Info : Identifiable {
    var id = UUID()
    var about: String
    var person: String
}

struct ModalView: View{
    
    //var About = ["名字", "系所", "性別", "感情狀態", "興趣"]
    //var PersonalInfo = ["關你屁４", "資工３Ｂ", "要交往嗎", "嗚嗚嗚", "你好我今年７０歲"]
    var Infos:[Info] = [Info(about: "名字", person: "關你屁４"),
                         Info(about: "系所", person: "資工３Ｂ"),
                         Info(about: "性別", person: "要交往嗎"),
                         Info(about: "感情狀態", person: "嗚嗚嗚"),
                         Info(about: "興趣", person: "CNMD")
                        ]
    
    var body: some View{
        List(self.Infos) { info in
            VStack(alignment: .leading) {
                Text(info.about)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                Spacer()
                    .frame(height: 10)
                Text(info.person)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
            }
        }
    }
}

struct PersonalSpaceView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalSpaceView()
    }
}
