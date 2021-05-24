//
//  MenueModal.swift
//  Kayan
//
//  Created by Sandal on 27/09/1442 AH.
//

import Foundation
struct MenueModal:Identifiable, Decodable {
let id: Int
   let name, imageURL: String
   let typeID: Int
   let createAt: String

   enum CodingKeys: String, CodingKey {
       case id, name
       case imageURL = "imageUrl"
       case typeID, createAt
   }
}
