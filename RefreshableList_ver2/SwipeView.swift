//
//  SwipeView.swift
//  RefreshableList_ver2
//
//  Created by James on 2020/3/15.
//  Copyright © 2020 James. All rights reserved.
//

import SwiftUI

struct SwipeView: View {
    
    @ObservedObject var articleFetcher = ArticleFetcher()
    @State private var isShowing = false
    @State private var offset: CGFloat = 0
    @State private var index = 0
    
    @State private var arrow = Image(systemName: "arrow.down")
    
    
    //var setions = ["看版", "最新", "熱門", "我的追蹤"]
    var smallSetions = ["最新", "熱門", "我的追蹤"]
    var largeSections = ["全部", "我的訂閱", "中央大學", "官方公告", "武漢肺炎", "美妝"]
    
    let spacing: CGFloat = 5
    
    var body: some View{
        GeometryReader { geometry in
            
            VStack {
                Spacer()
                    .frame(height: 10)
                HStack{
                    
                    Button(action:{
                        self.index = 0
                        withAnimation {
                            self.offset = -(geometry.size.width + self.spacing) * CGFloat(self.index)
                        }
                    }){
                        Text("看版")
                            .padding(5)
                            .foregroundColor(self.index == 0 ? .red : .black)
                    }
                    Button(action:{
                        self.index = 1
                        withAnimation {
                            self.offset = -(geometry.size.width + self.spacing) * CGFloat(self.index)
                        }
                    }){
                        Text("最新")
                            .padding(5)
                            .foregroundColor(self.index == 1 ? .red : .black)
                    }
                    Button(action:{
                        self.index = 2
                        withAnimation {
                            self.offset = -(geometry.size.width + self.spacing) * CGFloat(self.index)
                        }
                    }){
                        Text("熱門")
                            .padding(5)
                            .foregroundColor(self.index == 2 ? .red : .black)
                    }
                    Button(action:{
                        self.index = 3
                        withAnimation {
                            self.offset = -(geometry.size.width + self.spacing) * CGFloat(self.index)
                        }
                    }){
                        Text("我的追蹤")
                            .padding(5)
                            .foregroundColor(self.index == 3 ? .red : .black)
                    }
                    
                }
                    .frame(width: 380, height: 50)
                    .font(.title)
                    .lineLimit(nil)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.green, lineWidth: 3)
                    )
                
                
                ScrollView(.horizontal, showsIndicators: true){
                                    
                    HStack(spacing: self.spacing){
                        
                        List(self.largeSections, id: \.self) { section in
                            Text(section)
                                .fontWeight(.bold)
                                .font(.system(size: 30))
                                Spacer()
                                    .frame(height: 60)
                        }
                            .frame(width: geometry.size.width)
                        
                        ForEach(self.smallSetions, id: \.self) { section in
                            List(self.articleFetcher.AF_articles, id: \.title) { article in
                                NavigationLink(destination: ArticleContent(article: article)){
                                    ArticleRow(article: article)
                                }
                            }
                            .frame(width: geometry.size.width)
                            .background(PullToRefresh(action: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.isShowing = false
                                }
                            }, isShowing: self.$isShowing))
                        }
                    }
                }
                .content.offset(x: self.offset)
                .frame(width: geometry.size.width, alignment: .leading)
                .gesture(
                    DragGesture()
                    .onChanged({ value in
                        self.offset = value.translation.width - geometry.size.width * CGFloat(self.index)
                    })
                    .onEnded({ value in
                        if -value.predictedEndTranslation.width > geometry.size.width / 2, self.index < self.smallSetions.count - 1 {
                            self.index += 1
                        }
                        if value.predictedEndTranslation.width > geometry.size.width / 2, self.index > 0 {
                            self.index -= 1
                        }
                        withAnimation {
                            self.offset = -(geometry.size.width + self.spacing) * CGFloat(self.index)
                        }
                    })
                )
                    
            }
            
            
            /*
            return ScrollView(.horizontal, showsIndicators: true){
                                
                HStack(spacing: self.spacing){
                    ForEach(self.setions, id: \.self) { section in
                        
                        VStack {
                            Spacer()
                                .frame(height: 10)
                            Text(section)
                                .frame(width: 380, height: 50)
                                .font(.title)
                                .lineLimit(nil)
                                .padding(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.green, lineWidth: 3)
                                )
                            
                            List(self.articleFetcher.AF_articles, id: \.title) { article in
                                NavigationLink(destination: ArticleContent(article: article)){
                                    ArticleRow(article: article)
                                }
                            }
                            .frame(width: geometry.size.width)
                        }
                        
                        
                        
                            
                        .background(PullToRefresh(action: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                //let article_fetcher = ArticleFetcher.init(urlString: "http://140.115.3.108/api/v1/board")
                                //self.articles = article_fetcher.getData(urlString: "http://140.115.3.108/api/v1/board")
                                self.isShowing = false
                            }
                        }, isShowing: self.$isShowing))
                    }
                }
            }
            .content.offset(x: self.offset)
            .frame(width: geometry.size.width, alignment: .leading)
            .gesture(
                DragGesture()
                .onChanged({ value in
                    self.offset = value.translation.width - geometry.size.width * CGFloat(self.index)
                })
                .onEnded({ value in
                    if -value.predictedEndTranslation.width > geometry.size.width / 2, self.index < self.setions.count - 1 {
                        self.index += 1
                    }
                    if value.predictedEndTranslation.width > geometry.size.width / 2, self.index > 0 {
                        self.index -= 1
                    }
                    withAnimation {
                        self.offset = -(geometry.size.width + self.spacing) * CGFloat(self.index)
                    }
                })
            )
            */
            
        }
    }
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView()
    }
}

