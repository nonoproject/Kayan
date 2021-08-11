//
//  VarUserDefault.swift
//  RayhJay
//
//  Created by Awad sandal on 21/11/2020.
//

import Foundation

class VarUserDefault{
   
    var isLogin: String = "isLogin"
    
    var fullName: String = "fullName"
    var mobileNo: String = "mobileNo"
    var userId: String = "userId"
    var userVarifyId: String = "userVarifyId"
    var spekerSound: String = "spekerSound"

    var isFirestTime: String = "isFirestTime"
    func getGlobal(key:String) -> String{
        let preferences = UserDefaults.standard
        if preferences.object(forKey: key) != nil{
            return   preferences.object(forKey: key) as! String
        }
        
        return ""
    }
    func getGlobalInt(key:String) -> Int{
        let preferences = UserDefaults.standard
        if preferences.object(forKey: key) != nil{
            return   preferences.object(forKey: key) as! Int
        }
        return 0
    }
    func setGlobal(Key:String,Val:Any) -> Bool{
        let preferences = UserDefaults.standard
        preferences.set(Val, forKey: Key)
        
        //  Save to disk
      return  preferences.synchronize()
        
       
    }
    func getGlobalBool(key:String) -> Bool{
        let preferences = UserDefaults.standard
        if preferences.object(forKey: key) != nil{
            return   preferences.object(forKey: key) as! Bool
        }
        return false
    }
    class var SysGlobalData: VarUserDefault {
        struct Static {
            static let instance = VarUserDefault()
        }
        return Static.instance
    }
}
