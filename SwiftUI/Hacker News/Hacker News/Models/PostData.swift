//
//  PostData.swift
//  Hacker News
//
//  Created by Shimaa Badawy on 10/10/20.
//

import Foundation

struct Result: Decodable {
    let hits:[Post]
}

struct Post: Decodable,Identifiable {
    var id:String{
        return objectID
    }
    let title:String
    let points:Int
    let url:String?
    let objectID:String
}
