//
//  ArticleRow.swift
//  RefreshableList_ver2
//
//  Created by James on 2020/1/15.
//  Copyright © 2020 James. All rights reserved.
//

import SwiftUI

struct ArticleRow: View {
    
    var article: Article
    @State private var userTrack = false
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                HStack{
                    Image(systemName: "person.crop.circle")
                    Text(article.section)
                    Text(".")
                    Text(article.department)
                }
                Text(article.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(nil)
                Text(article.content)
                HStack{
                    hotLevel(Popularity: article.popularity)
                    Spacer()
                        .frame(width: 25)
                    Image(systemName: "heart.fill")
                        .foregroundColor(Color.red)
                    Text(article.like)
                    Spacer()
                        .frame(width: 25)
                    Text("回應 \(article.response)" )
                }
            }
            Spacer()
            clickTrack(like: self.userTrack)
                .onTapGesture {
                    self.userTrack.toggle()
                }
            Spacer()
                .frame(width: 10)
        }
    }
}

func hotLevel( Popularity: String) -> some View{
    let popularity = Int(Popularity)
    if popularity! >= 500{
        return AnyView(HStack{
                Image(systemName: "flame")
                    .foregroundColor(Color.orange)
                Image(systemName: "flame")
                    .foregroundColor(Color.orange)
                Image(systemName: "flame")
                    .foregroundColor(Color.orange)
            })
    }else if popularity! >= 100{
        return AnyView(HStack{
            Image(systemName: "flame")
                .foregroundColor(Color.orange)
            Image(systemName: "flame")
                .foregroundColor(Color.orange)
        })
    }else{
        return AnyView(HStack{
            Image(systemName: "flame")
                .foregroundColor(Color.orange)
        })
    }
}

func clickTrack( like: Bool ) -> some View {
    if like {
        return (Image(systemName: "bookmark.fill")
                    .font(.system(size: 30))
                    .foregroundColor(Color(red: 54/255, green: 249/255, blue: 236/255))
                )
    }else {
        return (Image(systemName: "bookmark")
                    .font(.system(size: 30))
                    .foregroundColor(Color.black)
                )
    }
}

/*
struct ArticleRow_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRow()
    }
}
*/
