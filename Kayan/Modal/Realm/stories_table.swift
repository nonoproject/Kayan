//
//  stories_table.swift
//  Kayan
//
//  Created by Sandal on 11/10/1442 AH.
//

import SwiftUI
import RealmSwift
class stories_table: Object{
    
    
    @objc dynamic var story_page_id:String?
    @objc dynamic var story_page_isPuse:Bool=false
    @objc dynamic var story_page_status:String?
    @objc dynamic var strory_page_records:String?
    override static func primaryKey() -> String? {
                 return "story_page_id"
    }
//    public func saveComicBook(_ comic: stories_table)
//    {
//        try! realm.write {
//            realm.add(comic)
//        }
//    }
}
