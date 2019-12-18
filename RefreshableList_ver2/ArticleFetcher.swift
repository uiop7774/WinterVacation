//
//  ArticleFetcher.swift
//  RefreshableList_ver2
//
//  Created by James on 2019/12/17.
//  Copyright © 2019 James. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

var rawTest = [
    ["title": "omae wa", "author": "black", "date": "2019/12/4", "content": "幹林涼"],
    ["title": "mou shindeiru", "author": "dick", "date": "2019/12/4", "content": "老雞掰"]
]

extension URLSession {
    func synchronousDataTask(with urlrequest: URLRequest) -> (data: Data?, response: URLResponse?, error: Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?

        let semaphore = DispatchSemaphore(value: 0)

        let dataTask = self.dataTask(with: urlrequest) {
            data = $0
            response = $1
            error = $2

            semaphore.signal()
        }
        dataTask.resume()

        _ = semaphore.wait(timeout: .distantFuture)

        return (data, response, error)
    }
}

class ArticleFetcher: ObservableObject{
    
    let objectWillChange = PassthroughSubject<ArticleFetcher, Never>()
    
    @Published var articles = [Article](){
        didSet{
            objectWillChange.send(self)
            print("in didSet")
        }
    }
    
    init(urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        
        /*get json*/
        let jsonTest = try? JSONSerialization.data(withJSONObject: rawTest, options: .fragmentsAllowed)
        /*get json*/
        
        /*send data*/
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonTest
        
        let (data, response, error) = URLSession.shared.synchronousDataTask(with: request)
        if let error = error {
            print("Synchronous task ended with error: \(error)")
        }
        else {
            let Data = data
            do{
                print("Data: ", Data ?? "888")
                let rcv_json = try JSONSerialization.jsonObject(
                    with: Data!,
                    options: .allowFragments
                    )as! [[String: String]]
                //self.article = rcv_json
                print_Response(dictionary: rcv_json)
                self.articles = DictToArticle(dictionary: rcv_json)
            }
            catch{
                print("receive failed")
            }
        }
        
    }
    
    func getData(urlString: String) -> [Article]{
        
        var temp = [Article]()
        
        print("in getData")
        
        guard let url = URL(string: urlString) else { return temp }
        
        /*get json*/
        rawTest.append(["title": "nani", "author": "dick", "date": "2019/12/4", "content": "花惹發"])
        dump(rawTest)
        let jsonTest = try? JSONSerialization.data(withJSONObject: rawTest, options: .fragmentsAllowed)
        /*get json*/
        
        /*send data*/
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonTest
        
        let (data, response, error) = URLSession.shared.synchronousDataTask(with: request)
        if let error = error {
            print("Synchronous task ended with error: \(error)")
        }
        else {
            let Data = data
            do{
                print("Data: ", Data ?? "8888")
                let rcv_json = try JSONSerialization.jsonObject(
                    with: Data!,
                    options: .allowFragments
                    )as! [[String: String]]
                //self.article = rcv_json
                print_Response(dictionary: rcv_json)
                temp = DictToArticle(dictionary: rcv_json)
            }
            catch{
                print("receive failed")
            }
        }
        
        return temp
    }
    
}

func DictToArticle( dictionary : [[String: String]]) -> [Article]{
    print("in DictToArticle")
    var ArticleList = [Article]()
    
    for article in dictionary{
        let temp = Article(
            id: article["id"] ?? "what id??",
            title: article["title"] ?? "what title??",
            date: article["date"] ?? "what date??",
            content: article["content"] ?? "what content??"
        )
        print("title: ", article["title"])
        ArticleList.append(temp)
    }
    return ArticleList
}

func print_Response( dictionary : [[String: String]] ) -> Void {
    let max = dictionary.count - 1
    print("in print_json")
    for index in 0...max{
        print("index: ", index)
        print("title: ", dictionary[index]["title"] ?? "failed")
        print("author: ", dictionary[index]["author"] ?? "failed")
        print("date: ", dictionary[index]["date"] ?? "failed")
        print("content: ", dictionary[index]["content"] ?? "failed")
    }
}
