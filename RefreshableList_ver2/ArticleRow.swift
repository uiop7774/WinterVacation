//
//  ArticleRow.swift
//  RefreshableList_ver2
//
//  Created by James on 2019/12/17.
//  Copyright © 2019 James. All rights reserved.
//

import SwiftUI

struct ArticleRow: View {
    var article: Article
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(article.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .lineLimit(nil)
                    Divider()
                    Spacer()
                        .frame(height: 30)
                    Text(article.date)
                        .fontWeight(.thin)
                    Divider()
                    Spacer()
                        .frame(height: 30)
                    Text(article.content)
                }
                Spacer()
            }
            Spacer()
        }
        /*
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(nil)
                Text(article.date)
                    .fontWeight(.thin)
                Text(article.content)
            }
            Spacer()
        }
        */
    }
}
/*
struct ArticleRow_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRow()
    }
}
 */
