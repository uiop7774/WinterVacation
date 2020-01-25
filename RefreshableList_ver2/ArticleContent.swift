//
//  ArticleRow.swift
//  RefreshableList_ver2
//
//  Created by James on 2019/12/17.
//  Copyright © 2019 James. All rights reserved.
//

import SwiftUI

struct ArticleReply: View {
    var reply: Reply
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.crop.circle")
                Text(reply.id)
                Text(".")
                Text(reply.department)
                Spacer()
                Image(systemName: "heart.fill")
                    .foregroundColor(Color.red)
                Text(reply.like)
                Spacer()
                    .frame(width: 10)
            }
            Text(reply.content)
                .font(.system(size: 25))
                .fontWeight(.medium)
            Divider()
        }
    }
}

struct ArticleContent: View {
    
    var article: Article
    @State private var reply = ""
    @State private var like = false
    
    var body: some View {
        
        ZStack{
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 10)
                    HStack {
                        Image(systemName: "person.crop.circle")
                        Text(article.department)
                        Text(".")
                        Text(article.section)
                        Spacer()
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(Color.green)
                            .onTapGesture {
                                print("need share")
                            }
                        Spacer()
                            .frame(width: 20)
                        Image(systemName: "hand.raised.fill")
                            .foregroundColor(Color.red)
                            .onTapGesture {
                                print("need report")
                            }
                        Spacer()
                            .frame(width: 10)
                    }
                    Divider()
                    Spacer()
                        .frame(height: 10)
                    HStack {
                        Text(article.title)
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .lineLimit(nil)
                        Spacer()
                    }
                    Divider()
                    VStack {
                        Text(article.content)
                            .font(.system(size: 30))
                            .fontWeight(.medium)
                        Spacer()
                    }
                        .frame(height: 300)
                    /*
                    HStack(alignment: .top) {
                        Text(article.content)
                            .font(.system(size: 30))
                            .fontWeight(.medium)
                            .frame(height: 300)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    */
                    Divider()
                    ForEach(article.replies, id: \.id) { reply in
                        ArticleReply(reply: reply)
                    }
                }
                Spacer()
                    .frame(height: 85)
            }
            VStack {
                Spacer()
                HStack {
                    TextField("想說的話...", text: $reply)
                        .frame(width: 250, height: 50)
                        .font(.system(size: 23))
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.green, lineWidth: 3)
                        )
                    Spacer()
                        .frame(width: 40)
                    clickLike(like: self.like)
                        .onTapGesture {
                            self.like.toggle()
                        }
                }
                    .background(Color.white)
            }
        }
        /*
        ZStack{
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 10)
                HStack {
                    Image(systemName: "person.crop.circle")
                    Text(article.department)
                    Text(".")
                    Text(article.section)
                    Spacer()
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(Color.green)
                        .onTapGesture {
                            print("need share")
                        }
                    Spacer()
                        .frame(width: 20)
                    Image(systemName: "hand.raised.fill")
                        .foregroundColor(Color.red)
                        .onTapGesture {
                            print("need report")
                        }
                    Spacer()
                        .frame(width: 10)
                }
                Divider()
                Spacer()
                    .frame(height: 10)
                HStack {
                    Text(article.title)
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .lineLimit(nil)
                    Spacer()
                }
                Divider()
                HStack {
                    Text(article.content)
                        .font(.system(size: 30))
                        .fontWeight(.medium)
                    Spacer()
                }
                Spacer()
            }
            VStack {
                Spacer()
                HStack {
                    TextField("想說的話...", text: $reply)
                        .frame(width: 250, height: 50)
                        .font(.system(size: 23))
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.green, lineWidth: 3)
                        )
                    Spacer()
                        .frame(width: 40)
                    clickLike(like: self.like)
                        .onTapGesture {
                            self.like.toggle()
                        }
                }
            }
        }
        */
        
        
        
    }
}

func clickLike( like: Bool ) -> some View {
    if like {
        return (Image(systemName: "heart.fill")
                    .font(.system(size: 50))
                    .foregroundColor(Color.red)
                )
    }else {
        return (Image(systemName: "heart")
                    .font(.system(size: 50))
                    .foregroundColor(Color.red)
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
