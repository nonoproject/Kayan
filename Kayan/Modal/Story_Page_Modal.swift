//
//  Story_Page_Modal.swift
//  Kayan
//
//  Created by Sandal on 10/10/1442 AH.
//

import Foundation
import SwiftUI
import Combine
struct Story_Page_Modal: Decodable ,Hashable {
    static func == (lhs: Story_Page_Modal, rhs: Story_Page_Modal) -> Bool {
        return true
    }
    
    let id: Int?
    let name, imageURL, storyText: String?
    let storyVoicePath: String?
    let storyID: Int?
    let story: String?
    let createAt: String?
    let updateAt: String?
    var selected_image: AsyncImage< Image >  {
        return  AsyncImage(
            url: (URL(string:"https://kayanapp.ibtikar-soft.sa\(imageURL ?? "")" )! ),
                            placeholder: { Image("kayan_logo").resizable()},
                            image: { Image(uiImage: $0).resizable()
                            }
        )
    }
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "imageUrl"
        case storyText, storyVoicePath, storyID, story, createAt, updateAt
    }
   
}
