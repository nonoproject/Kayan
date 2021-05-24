//
//  Story_Page_Modal.swift
//  Kayan
//
//  Created by Sandal on 10/10/1442 AH.
//

import Foundation
struct Story_Page_Modal: Decodable ,Hashable {
    let id: Int?
    let name, imageURL, storyText: String?
    let storyVoicePath: String?
    let storyID: Int?
    let story: String?
    let createAt: String?
    let updateAt: String?
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "imageUrl"
        case storyText, storyVoicePath, storyID, story, createAt, updateAt
    }
}
