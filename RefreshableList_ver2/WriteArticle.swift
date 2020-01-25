//
//  WriteArticle.swift
//  RefreshableList_ver2
//
//  Created by James on 2020/1/14.
//  Copyright © 2020 James. All rights reserved.
//

import SwiftUI

struct WriteArticle: View {
    
    @State private var section = "要po的看板 ↓"
    @State private var showing = false
    @State private var color = Color.black
    @State private var article = ""
    @State private var content = ""
    
    var body: some View {
        VStack{
            HStack{
                Text(section)
                    .foregroundColor(color)
                //Image(systemName: "arrowtriangle.down.fill")
            }
                .frame(width: 350, height: 10)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.green, lineWidth: 3)
                )
                .onTapGesture {
                    print("catched")
                    self.showing.toggle()
                }
                .popover(isPresented: self.$showing, content: {
                    VStack{
                        Button(action:{
                            self.section = "要po的看板 ↓"
                            self.color = Color.black
                            self.showing.toggle()
                        }){
                            Text("請選擇")
                                .font(.system(size: 25))
                        }
                        Divider()
                        Button(action:{
                            print("靠北")
                            self.section = "靠北"
                            self.color = Color.orange
                            self.showing.toggle()
                        }){
                            Text("靠北")
                                .font(.system(size: 25))
                        }
                        Divider()
                        Button(action:{
                            print("問卦")
                            self.section = "問卦"
                            self.color = Color.orange
                            self.showing.toggle()
                        }){
                            Text("問卦")
                                .font(.system(size: 25))
                        }
                        Divider()
                        Button(action:{
                            print("表特")
                            self.section = "表特"
                            self.color = Color.orange
                            self.showing.toggle()
                        }){
                            Text("表特")
                                .font(.system(size: 25))
                        }
                        Divider()
                        Button(action:{
                            print("美妝")
                            self.section = "美妝"
                            self.color = Color.orange
                            self.showing.toggle()
                        }){
                            Text("美妝")
                                .font(.system(size: 25))
                        }
                        Divider()
                    }
                })
            Spacer()
                .frame(height: 25)
            TextField("標題...", text: $article)
                .frame(width: 350, height: 50)
                .font(.system(size: 30))
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.green, lineWidth: 3)
                )
            Spacer()
                .frame(height: 25)
            TextField("內容...", text: $content)
                .frame(width: 350, height: 450)
                .font(.system(size: 23))
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.green, lineWidth: 3)
                )
            Spacer()
                .frame(height: 15)
            Divider()
            HStack{
                Spacer()
                Image(systemName: "camera")
                    .font(.system(size: 30))
                    .foregroundColor(Color.blue)
                Spacer()
                Image(systemName: "square.grid.2x2")
                    .font(.system(size: 30))
                    .foregroundColor(Color.blue)
                Spacer()
            }
            .padding()
        }
    }
}
/*
struct WriteArticle_Previews: PreviewProvider {
    static var previews: some View {
        WriteArticle()
    }
}
*/
