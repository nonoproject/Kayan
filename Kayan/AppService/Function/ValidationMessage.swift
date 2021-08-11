//
//  ValidationMessage.swift
//  Kayan
//
//  Created by Sandal on 21/10/1442 AH.
//

import Foundation
class ValidationMessage:NSData{
    func  getMessage(word:String) -> String{
        var link:String =    ""
        switch word {
        // Auth
        case "UserNotActive":
            link = messge_p.ok.rawValue + " هذا المستخدم غير موجود"
            break
        case "RowngCode":
            link = messge_p.ok.rawValue + "كود التفعيل غير صحيح"
            break
        case "Passwordـnotـmatch":
            link = messge_p.ok.rawValue + "كلمة المرور لاتتطابق"
            break
        case "fill_all_filed":
            link = messge_p.ok.rawValue + " إملا جميع الحقول "
            break
        default:
            break
        }
        return link
        
    }
    enum messge_p : String {
        case ok = " عفوا "
    }
}

