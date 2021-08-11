//
//  TextBindingManager.swift
//  Kayan
//
//  Created by mohammed aburukbah on 16/09/1442 AH.
//

import Foundation

class TextBindingManager: ObservableObject {
    
    
   @Published var text = "0571816557" {
       didSet {
           if text.count > characterLimit && oldValue.count <= characterLimit {
               text = oldValue
            
           }
       }
   }
   let characterLimit: Int

   init(limit: Int = 10){
       characterLimit = limit
   }
}
