//
//  PostModel.swift
//  AFNetworkingCRUD
//
//  Created by MD Tanvir Alam on 21/12/20.
//

import Foundation

struct PostModel:Codable{
    let posts:[Post]
}
struct Post:Codable {
    let userId:Int
    let id:Int
    let title: String
    let body:String
}


