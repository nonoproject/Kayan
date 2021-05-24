//
//  Connection.swift
//  RayhJay
//
//  Created by Awad sandal on 21/11/2020.
//

import Foundation
let AppBase="https://kayanapp.ibtikar-soft.sa"
let AppImageBase="https://kayanapp.ibtikar-soft.sa/api/"
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
// Story
        case "GetMenu":
            link = baseUrl+"Story/GetMenu"
            break
        case "GetStoryCatogries":
            link = baseUrl+"Story/GetStoryCatogries"
            break
        case "GetStories":
            link = baseUrl+"Story/GetStories/"
            break
            
            
        case "GetStoryPages":
            link = baseUrl+"Story/GetStoryPages/"
            break
            
        //        https://kayanapp.ibtikar-soft.sa/api/Story/GetStories/2
            
//        case "UpdateProfile":
//            link = baseUrl+"Customers/UpdateProfile"
//            break
//
//        case "UpdatePasswoed":
//            link = baseUrl+"Customers/UpdatePasswoed"
//            break
//            case "reSendVerification":
//                link = baseUrl+"Customers/reSendVerification"
//                break
//                // profile
//
//        case "GetCustomerInfo":
//            link = baseUrl+"Customers/GetCustomerInfo"
//            break
//
//                case "PackageSubscribtion":
//                    link = baseUrl+"Customers/PackageSubscribtion"
//                    break
//                case "getUserData":
//                    link = baseUrl+"Customers/"
//                    break
        //
        case "Story":
            link = baseUrl+"Story/GetMenu"
            break
          
//        case "getShops":
//                link = baseUrl+"shops/GetShopBySection/"
//                break
//        case "GetShopItems":
//            link = baseUrl+"shops/GetShopItems/"
//            break
//        case "NewOrder":
//            link = baseUrl+"orders/NewOrder"
//            break
//        
//            
//        case "ConfirmOrder":
//            link = baseUrl+"orders/ConfirmOrder/"
//            break
//        case "UpdateOrderPayment":
//            link = baseUrl+"orders/UpdateOrderPayment"
//            break
//        case "GetLiveLocation":
//            link = baseUrl+"Delegate/GetLiveLocation/\(VarUserDefault.SysGlobalData.getGlobal(key: VarUserDefault.SysGlobalData.OrderId))"
//            break
//            
//        case "GetOffers":
//            link = baseUrl+"shops/GetOffers"
//            break
//        case "GetAds":
//            link = baseUrl+"shops/GetAds/"
//            break
//            
//        case "GetPackages":
//            link = baseUrl+"Customers/GetPackages"
//            break
//            
//        case "GetRating":
//            link = baseUrl+"Customers/GetRating/\(VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))"
//            break
//        case "GetFeedback":
//            link = baseUrl+"Customers/GetFeedback/\(VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))"
//            break
//            
//        case "GetNewOrder":
//            link = baseUrl+"orders/GetNewOrder/"
//            break
//        case "GetOrderHistory":
//            link = baseUrl+"orders/GetOrderHistory/"
//            break
//        case "GetDelegateNearToShop":
//            link = baseUrl+"orders/GetDelegateNearToShop/\(VarUserDefault.SysGlobalData.getGlobal(key: VarUserDefault.SysGlobalData.OrderId))"
//            break
//        case "AddDelegateToOrder":
//            link = baseUrl+"orders/AddDelegateToOrder/\(VarUserDefault.SysGlobalData.getGlobal(key: VarUserDefault.SysGlobalData.OrderId))/\(delegats.first!.delegateID)"
//            break
//        case "GetOrderDetials":
//            link = baseUrl+"orders/GetOrderDetials/\(VarUserDefault.SysGlobalData.getGlobal(key: VarUserDefault.SysGlobalData.OrderId))"
//            break
//        case "ChangeOrderStatus":
//            link = baseUrl+"orders/ChangeOrderStatus/\(VarUserDefault.SysGlobalData.getGlobal(key: VarUserDefault.SysGlobalData.OrderId))"
//            break
//        case "Getchat":
//            link = baseUrl+"Chat/Getchat/\(VarUserDefault.SysGlobalData.getGlobal(key: VarUserDefault.SysGlobalData.OrderId))"
////            link = baseUrl+"Chat/Getchat/5"
        case "SendMessage":
//            link = baseUrl+"Chat/Getchat/\(VarUserDefault.SysGlobalData.getGlobal(key: VarUserDefault.SysGlobalData.OrderId))"
            link = baseUrl+"Chat/SendMessage"
            
            
            break
            
        default:
            break
        }
        return link
        
    }
}

