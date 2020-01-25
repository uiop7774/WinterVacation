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
/*
var rawTest = [
    ["title": "omae wa", "author": "black", "section": "靠北", "department": "CSIE", "date": "2019/12/4", "content": "幹林涼", "popularity": "500", "like": "1632", "response": "169"],
    ["title": "mou shindeiru", "author": "dick", "section": "美妝", "department": "EE", "date": "2019/12/4", "content": "老雞掰", "popularity": "100", "like": "162", "response": "488"]
]
 */

var testReplies = [ Reply(id: "not_me", department: "GS", like: "30", content: "ironical"),
                    Reply(id: "not_you", department: "CM", like: "1", content: "indubitably"),
                    Reply(id: "not_she", department: "LS", like: "5", content: "faster"),
                    Reply(id: "not_he", department: "GM", like: "60", content: "directly"),
                    Reply(id: "not_us", department: "BA", like: "70", content: "constantly")
                ]

var testArticle = [Article(id: "BlackDick", title: "can't graduate", section: "靠北",
                            department: "CSIE", date: "2020/1/17", content: "以前的我: 期末考讀不完 就不睡拉, 現在的我: 我就爛",
                            popularity: "1000", like: "888", response: "999",
                            replies: testReplies
                            ),
                   Article(id: "BlackPussy", title: "can't graduate again", section: "靠北",
                       department: "CSIE", date: "2020/1/18", content: "以前的我: 期末考讀不完 就不睡拉, 現在的我: 我超他媽爛",
                       popularity: "1450", like: "487", response: "817",
                       replies: testReplies
                       )
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
    
    
    let Url = URL(string: "http://140.115.3.108/api/v1/board")
    
    let objectWillChange = ObservableObjectPublisher()
    var AF_articles = [Article](){
        didSet{
            objectWillChange.send()
            print("in didSet")
        }
    }
    
    /*
     let objectWillChange = PassthroughSubject<ArticleFetcher, Never>()
    @Published var articles = [Article](){
        didSet{
            objectWillChange.send(self)
            print("in didSet")
        }
    }
    */
    
    init() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(testArticle)
            print("success!!")
            
            /*send data*/
            var request = URLRequest(url: Url!)
            request.httpMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            /*send data*/
            
            /*receive data*/
            let (rcv_data, _, error) = URLSession.shared.synchronousDataTask(with: request)
            if let error = error {
                print("Synchronous task ended with error: \(error)")
            }
            else {
                let Data = rcv_data
                print("Data: ", Data ?? "888")
                let decoder = JSONDecoder()
                let articles = try! decoder.decode([Article].self, from: Data!)
                printReplies(Articles: articles)
                AF_articles = articles
            }
        }catch {
            print("not success")
        }
    }
    
    func printReplies(Articles: [Article]) -> Void {
        for article in Articles {
            print("title: ", article.title)
            for reply in article.replies {
                print("id: ", reply.id)
                print("department: ", reply.department)
                print("like: ", reply.like)
                print("content: ", reply.content)
            }
        }
    }
    
    /*
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
        
        let (data, _, error) = URLSession.shared.synchronousDataTask(with: request)
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
        rawTest.append(["title": "nani", "author": "dick", "section": "表特", "department": "MIS", "date": "2019/12/4", "content": "花惹發", "popularity": "10", "like": "50", "response": "63"])
        dump(rawTest)
        let jsonTest = try? JSONSerialization.data(withJSONObject: rawTest, options: .fragmentsAllowed)
        /*get json*/
        
        /*send data*/
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonTest
        
        let (data, _, error) = URLSession.shared.synchronousDataTask(with: request)
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
    */
    
}

/*
func DictToArticle( dictionary : [[String: String]]) -> [Article]{
    print("in DictToArticle")
    var ArticleList = [Article]()
    
    for article in dictionary{
        let temp = Article(
            id: article["id"] ?? "what id??",
            title: article["title"] ?? "what title??",
            section: article["section"] ?? "what title??",
            department: article["department"] ?? "what department??",
            date: article["date"] ?? "what date??",
            content: article["content"] ?? "what content??",
            popularity: article["popularity"] ?? "what popularity??",
            like: article["like"] ?? "what like??",
            response: article["response"] ?? "what response??"
        )
        print("title: ", article["title"] ?? "download not success")
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
        print("section: ", dictionary[index]["section"] ?? "failed")
        print("department: ", dictionary[index]["department"] ?? "failed")
        print("author: ", dictionary[index]["author"] ?? "failed")
        print("date: ", dictionary[index]["date"] ?? "failed")
        print("content: ", dictionary[index]["content"] ?? "failed")
        print("popularity: ", dictionary[index]["popularity"] ?? "failed")
        print("like: ", dictionary[index]["like"] ?? "failed")
        print("response: ", dictionary[index]["response"] ?? "failed")
    }
}
*/
