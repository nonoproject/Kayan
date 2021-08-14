//
//  StroryModal.swift
//  Kayan
//
//  Created by Sandal on 08/10/1442 AH.
//

import Foundation
import SwiftUI
import Foundation
struct StroryModal : Identifiable, Decodable ,Hashable{
    let id: Int
   let name, imageURL: String?
   let subscribePrice: Int?
   let isPaid: Bool?
   let storyCatogryID: Int?
   let storyCatogry: String?
    let isSubscribed: Bool?
    let storyQuestionsList: [storyQuestionsList]?
   let createAt: String?
   let updateAt: String?
   let storyPages: [String]?
    var x:CGFloat=0
    
    let rate: Double?
   enum CodingKeys: String, CodingKey {
       case id, name
    case rate
       case imageURL = "imageUrl"
       case subscribePrice,isSubscribed,storyQuestionsList, isPaid, storyCatogryID, storyCatogry, createAt, updateAt, storyPages
   }
}
struct storyQuestionsList:Hashable,Decodable {
   let questionText: String
   let id: Int
}
