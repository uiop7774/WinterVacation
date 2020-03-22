//
//  ContentView.swift
//  RefreshableList_ver2
//
//  Created by James on 2019/12/17.
//  Copyright © 2019 James. All rights reserved.
//

import SwiftUI
struct traffic: View{
    
    var body: some View {
         Text("交通板施工中")
    }
   
}
//這是設定頁面拉
struct setting: View{
    @State private var username = ""
    var body: some View {
        VStack{
            Text("設定的地方喔")
            
            List {
                HStack {
                    Text("Username").bold()
                    Divider()
                    TextField("Username", text: $username)
                }
                VStack {
                    HStack{
                        Text("生日").bold()
                        Spacer()
                    }
                    
                    Divider()
                    TextField("自己輸入拉", text: $username)
                }
                HStack {
                    Text("感情").bold()
                    Divider()
                    TextField("輸入狀況喔", text: $username)
                }
               HStack {
                   Text("後面再補拉啦啦啦").bold()
                   Divider()
                   TextField("Username", text: $username)
               }
            }
        }
        
    }
   
}
//這是起始頁面的拉
struct View1: View {
    @Binding var push: Int
    //@State private var val = false
    var body: some View {
        Button(action: {
            withAnimation(.easeOut(duration: 0.3)) {
                self.push = 1
            }
        }) {
            VStack{
                Text("Personal Page")
                Text("PUSH oooo")
                Text("起始頁面")
            }
           
        }
        
    }
}
//個人空間的拉
struct View2: View {
    @Binding var push: Int
    @State private var article = ""
    var body: some View{
        VStack {
            //to origin page
            Button(action: {
                withAnimation(.easeOut(duration: 0.3)) {
                    self.push = 0
                }
            }) {
                VStack{
                    Text("Personal Page")
                    Text("PUSH")
                }
               
            }
            //to login page
            Button(action: {
                withAnimation(.easeOut(duration: 0.3)) {
                    self.push = 3
                }
            }) {
                VStack{
                    Text("Login Page")
                    Text("PUSH   a")
                }
               
            }
            VStack{
                TextField("標題...", text: $article)
                .frame(width: 350, height: 50)
                .font(.system(size: 30))
                .padding()
                .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.green, lineWidth: 3)
                )
            }
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}
//登入頁面的拉
struct View3: View {
    @Binding var push: Int
    @State private var article = ""
    @State private var PAS = ""
    var body: some View{
        VStack {
            //to origin page
            Text("登入or註冊" )
            Button(action: {
                withAnimation(.easeOut(duration: 0.3)) {
                    self.push = 0
                }
            }) {
                VStack{
                    Text("Personal Page")
                    Text("PUSH")
                }
               
            }
            VStack{
                 TextField("帳號", text: $article)
                    .font(.system(size: 20))
                    .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.green, lineWidth: 3)
                    )
                 TextField("密碼", text: $PAS)
                    .font(.system(size: 20))
                .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.green, lineWidth: 3)
                )
            }
            HStack{
                //登入
                Button(action: {
                    withAnimation(.easeOut(duration: 0.3)) {
                        self.push = 0
                    }
                }) {
                    VStack{
                        Text("登入")
                        
                    }
                   
                }
                //註冊
                Button(action: {
                    withAnimation(.easeOut(duration: 0.3)) {
                        self.push = 0
                    }
                }) {
                    VStack{
                        Text("註冊")
                       
                    }
                   
                }
            }
           /*
            VStack{
                TextField("標題...", text: $article)
                .frame(width: 350, height: 50)
                .font(.system(size: 30))
                .padding()
                .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.green, lineWidth: 3)
                )
            }*/
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}
//討論版的拉
struct ContentViewA: View {
    @Binding var push: Int
    //@State var articles = ArticleFetcher(urlString: "http://140.115.3.108/api/v1/board").articles
    @ObservedObject var articleFetcher = ArticleFetcher()
    @State private var isShowing = false
    @State private var tag:Int? = nil
    
    var body: some View {
        NavigationView{
            ZStack{
                
                SwipeView()
                    .padding(.bottom)
                
                /*
                List(articleFetcher.AF_articles, id: \.title) { article in
                    NavigationLink(destination: ArticleContent(article: article)){
                        ArticleRow(article: article)
                    }
                }
                 */
                    
                    .navigationBarItems(leading:
                        HStack{
                            Button(action: {
                                withAnimation(.easeOut(duration: 0.3)) {
                                    self.push = 0
                                    print("click art")
                                }
                            }){
                                Image(systemName: "house")
                                    .font(.system(size:25))

                                    .imageScale(.small)
                            }
                           
                        }
                        ,trailing:
                        Button(action: {
                           print("edit button tpped")
                            self.push = 2
                          // self.tag = 1
                       }){
                           Image(systemName: "gear")
                               .font(.system(size:25))

                               .imageScale(.small)
                       }
                        
                    )
                
                
                    .navigationBarTitle(Text("討論版"), displayMode: .inline)
                    
                    /*
                    .background(PullToRefresh(action: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            //let article_fetcher = ArticleFetcher.init(urlString: "http://140.115.3.108/api/v1/board")
                            //self.articles = article_fetcher.getData(urlString: "http://140.115.3.108/api/v1/board")
                            self.isShowing = false
                        }
                    }, isShowing: $isShowing))
                    */
                    
                    
                NavigationLink(destination: WriteArticle(), tag: 1, selection: $tag){
                    EmptyView()
                }
                
                VStack{
                   
                        
                    
                    Spacer()
                    HStack{
                        Spacer()
                        
                        Button(action: {
                            print("edit button tpped")
                            self.tag = 1
                        }){
                            Image(systemName: "pencil")
                                .font(.system(size:50))
                                .frame(width: 77, height: 70)
                                .imageScale(.small)
                        }
                        .background(Color.white)
                        .cornerRadius(38.5)
                        .padding()
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 10,
                                x: 3,
                                y: 3)
                        
                    }
                }
            }
        }
    

    }
    
}
struct ManagerView: View {
    @State private var push = 0
    var body: some View {
    
    
    switch push {
                   //起始頁面
               case 0:
                   return AnyView(View1(push: $push))
                  
                   .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
                   //討論版
               case 1:
                  return AnyView(ContentViewA(push: $push))
                      .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
                   
                   //個人空間
               case 2:
               return AnyView(View2(push: $push))
                   .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
               case 3:
               return AnyView(View3(push: $push))
                   .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
               default:
                   return AnyView(View1(push: $push))
                      .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
               }
    }
}
struct ContentView: View {
    @State private var push = 0

    var body: some View {
        TabView{
            ManagerView().tabItem {
                Image(systemName: "list.dash")
                Text("討論")
            }
            .tag(0)
            traffic().tabItem{
                Image(systemName: "square.and.pencil")
                Text("交通")
            }
            .tag(1)
            setting().tabItem{
                Image(systemName: "square.and.pencil")
                Text("個人")
            }
            .tag(1)
        }
        /*
            switch push {
                //起始頁面
            case 0:
                return AnyView(View1(push: $push))
               
                .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
                //討論版
            case 1:
               return AnyView(ContentViewA(push: $push))
                   .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
                
                //個人空間
            case 2:
            return AnyView(View2(push: $push))
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
            case 3:
            return AnyView(View3(push: $push))
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
            default:
                return AnyView(View1(push: $push))
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
            }
           */
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
/*
           if !push {
               View1(push: $push)
                   .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
           }

           if push {
               ContentViewA(push: $push)
                   .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
           }
      */
