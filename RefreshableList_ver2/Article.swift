//
//  Article.swift
//  RefreshableList_ver2
//
//  Created by James on 2019/12/17.
//  Copyright © 2019 James. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct Reply: Codable {
    var id: String
    var department: String
    var like: String
    var content: String
}

struct Article: Codable {
    var id: String
    var title: String
    var section: String
    var department: String
    var date: String
    var content: String
    var popularity: String
    var like: String
    var response: String
    var replies: [Reply]
}
