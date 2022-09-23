//
//  PostData.swift
//  H4x0r News
//
//  Created by Cáren Sousa on 23/09/22.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}
