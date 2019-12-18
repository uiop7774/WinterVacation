//
//  ContentView.swift
//  RefreshableList_ver2
//
//  Created by James on 2019/12/17.
//  Copyright © 2019 James. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var articles = ArticleFetcher(urlString: "http://140.115.3.108/api/v1/board").articles
    @State private var isShowing = false
    
    var body: some View {
        NavigationView{
            List(articles, id: \.title){article in
                ArticleRow(article: article)
            }
            .navigationBarTitle(Text("討論版"))
            .background(PullToRefresh(action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let article_fetcher = ArticleFetcher.init(urlString: "http://140.115.3.108/api/v1/board")
                    self.articles = article_fetcher.getData(urlString: "http://140.115.3.108/api/v1/board")
                    self.isShowing = false
                }
            }, isShowing: $isShowing))
        }
    }
    /*
    @State var articleManager = ArticleFetcher(urlString: "http://140.115.3.108/api/v1/board")
    @State private var isShowing = false
    
    var body: some View {
        NavigationView{
            List(articleManager.articles, id: \.title){article in
                ArticleRow(article: article)
            }
            .navigationBarTitle(Text("討論版"))
            .background(PullToRefresh(action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.articleManager.getData(urlString: "http://140.115.3.108/api/v1/board")
                    self.isShowing = false
                }
            }, isShowing: $isShowing))
        }
    }
     */
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
