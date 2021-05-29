//
//  StroryModal.swift
//  Kayan
//
//  Created by Sandal on 08/10/1442 AH.
//

import Foundation
import SwiftUI
import Foundation
struct StroryModal :Identifiable, Decodable ,Hashable{
    let id: Int
   let name, imageURL: String?
   let subscribePrice: Int?
   let isPaid: Bool?
   let storyCatogryID: Int?
   let storyCatogry: String?
   let createAt: String?
   let updateAt: String?
   let storyPages: [String]?
    var x:CGFloat=0
   enum CodingKeys: String, CodingKey {
       case id, name
       case imageURL = "imageUrl"
       case subscribePrice, isPaid, storyCatogryID, storyCatogry, createAt, updateAt, storyPages
   }
}
