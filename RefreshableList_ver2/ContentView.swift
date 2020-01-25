//
//  ContentView.swift
//  RefreshableList_ver2
//
//  Created by James on 2019/12/17.
//  Copyright © 2019 James. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //@State var articles = ArticleFetcher(urlString: "http://140.115.3.108/api/v1/board").articles
    @ObservedObject var articleFetcher = ArticleFetcher()
    @State private var isShowing = false
    @State private var tag:Int? = nil
    
    var body: some View {
        NavigationView{
            ZStack{
                List(articleFetcher.AF_articles, id: \.title) { article in
                    NavigationLink(destination: ArticleContent(article: article)){
                        ArticleRow(article: article)
                    }
                }
                    .navigationBarTitle(Text("討論版"), displayMode: .inline)
                    
                    .background(PullToRefresh(action: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            //let article_fetcher = ArticleFetcher.init(urlString: "http://140.115.3.108/api/v1/board")
                            //self.articles = article_fetcher.getData(urlString: "http://140.115.3.108/api/v1/board")
                            self.isShowing = false
                        }
                    }, isShowing: $isShowing))
                    
                
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
    
 
        /*
        NavigationView{
            ZStack{
                List(articles, id: \.title){article in
                    NavigationLink(destination: ArticleContent(article: article)){
                        ArticleRow(article: article)
                    }
                }
                    .navigationBarTitle(Text("討論版"), displayMode: .inline)
                    .background(PullToRefresh(action: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            let article_fetcher = ArticleFetcher.init(urlString: "http://140.115.3.108/api/v1/board")
                            self.articles = article_fetcher.getData(urlString: "http://140.115.3.108/api/v1/board")
                            self.isShowing = false
                        }
                    }, isShowing: $isShowing))
                
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
        */
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
