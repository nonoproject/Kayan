//
//  StoriesModal.swift
//  Kayan
//
//  Created by Sandal on 27/09/1442 AH.
//

import SwiftUI
import Foundation
struct StoriesModal :Decodable ,Hashable{
//        var ids = UUID().uuidString
        let id: Int
       let name, imageURL: String
       let ageFrom, ageTo: Int
       let createAt: String
       let updateAt: String?

       enum CodingKeys: String, CodingKey {
           case id, name
           case imageURL = "imageUrl"
           case ageFrom, ageTo, createAt, updateAt
       }
   }
