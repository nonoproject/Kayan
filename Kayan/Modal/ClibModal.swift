//
//  ClibModal.swift
//  Kayan
//
//  Created by Sandal on 14/10/1442 AH.
//

import SwiftUI

struct ClibModal: Decodable ,Hashable {
    let id: Int
    let name:String?
        let imageURL, storyText: String?
       let clipPath: String?
       let storyID: Int?
       let story: String?
       let createAt: String?
       let updateAt: String?

       enum CodingKeys: String, CodingKey {
           case id, name
           case imageURL = "imageUrl"
           case storyText, clipPath, storyID, story, createAt, updateAt
       }
   }
