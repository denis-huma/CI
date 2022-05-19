//
//  Protocols.swift
//  MVP
//
//  Created by Denis Yaremenko on 29.06.2020.
//  Copyright © 2020 Denis Yaremenko. All rights reserved.
//

import Foundation

struct Comment: Decodable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}






