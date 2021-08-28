//
//  Connection.swift
//  RayhJay
//
//  Created by Awad sandal on 21/11/2020.
//

import Foundation
let AppBase="https://appkayan.com"
let AppImageBase="https://appkayan.com/api/"
class Connection:NSData
{
    
     let baseUrl=AppBase+"/api/"
    
    func  getUrl(word:String) -> String{
        var link:String =    ""
        switch word {
        // Auth
        case "register":
            link = baseUrl+"Customer/CreateNew"
            break
        case "login":
            link = baseUrl+"Customer/Login"
            break
        case "verifyUser":
            link = baseUrl+"Customer/Verfiy"
            break
        case "GetRestPassword":
            link = baseUrl+"Customer/GetRestPassword/"
            break
            
        case "RestChangePassword":
            link = baseUrl+"Customer/RestChangePassword"
            break
        case "ChangePassword":
            link = baseUrl+"Customer/ChangePassword"
            break
        case "GetCustomerInfo":
            link = baseUrl+"Customer/GetCustomerInfo/\(VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))"
            break
            
            
// Story
        case "GetMenu":
            link = baseUrl+"Story/GetMenu"
            break
        case "GetClibs":
            link = baseUrl+"Story/GetClibs/"
            break
        case "Rate":
            link = baseUrl+"Story/Rate"
            break
        case "GetCheckCoupon":
            link = baseUrl+"Story/GetCheckCoupon"
            break
            
        case "GetStoryCatogries":
            link = baseUrl+"Story/GetStoryCatogries/\(VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))"
            break
        case "GetStories":
            link = baseUrl+"Story/GetStories/"
            break
        case "GetStoryPages":
            link = baseUrl+"Story/GetStoryPages/"
            break
        case "GetComingSoonStories":
            link = baseUrl+"Story/GetComingSoonStories"
            break
            
        case "AddToFavourite":
            link = baseUrl+"Story/AddToFavourite/"
            break
        case "GetMyFavouriteStory":
            link = baseUrl+"Story/GetMyFavouriteStory/"
            break
        case "RemoveFromFavourite":
            link = baseUrl+"Story/RemoveFromFavourite/"
            break
        case "StorySubscribe":
            link = baseUrl+"Story/StorySubscribe"
            break
        case "StoryGift":
            link = baseUrl+"Story/StoryGift"
            break
        case "GetGiftStory":
            link = baseUrl+"Story/GetGiftStory/\(VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))"
            break
            
            
            
            
            
        default:
            break
        }
        return link
        
    }
}

