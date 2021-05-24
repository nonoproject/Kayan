//
//  RestAPI.swift
//  RayhJay
//
//  Created by Awad sandal on 21/11/2020.
//

import Foundation
import Alamofire
import SwiftyJSON

public class RestAPI {
    
    /*
     func getAll()
     use to get all data from server
     with parameters:
     - endurl: where data will be send
     
     + onCompletion: when get is success
     + onError: when get is failure
     */
    
    open func getData(endUrl: String, parameters: Parameters = [:] ,onCompletion: ((Any?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        
        let headers: HTTPHeaders = [
            "auth": "ios",
            "x-api-key": "vkLFNQk9YQ2L54PZjcq898ZEk7yntJev7w6XVmNv",
//            "token": GlobalDataCondition.SysGlobalData.token
            "Content-Type":"application/json; charset=utf-8"
        ]
        
        AF.request(endUrl, method: .get, parameters: parameters, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let result):
                let json = JSON(result)
                onCompletion?(json)
            case .failure(let err):
                print("\(err.localizedDescription)")
                onError?(err)
            }
        }
    }
    
    open func postData(endUrl: String,parameters: Parameters, onCompletion: ((Any?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        let headers:HTTPHeaders = [
            :
        ]
        
        AF.request(endUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default,headers: headers).responseJSON { response in
            switch response.result {
            case .success(let result):
                let json = JSON(result)
                onCompletion?(json)
            case .failure(let err):
                print("\(err.localizedDescription)")
                 print("\(err)")
                onError?(err)
            }
        }
    }
    
    open func poutData(endUrl: String,parameters: Parameters, onCompletion: ((Any?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
               
        let headers :HTTPHeaders = [
                   "PoolId": "us-east-1_ZTuCfYmt2",
                   "x-api-key": "vkLFNQk9YQ2L54PZjcq898ZEk7yntJev7w6XVmNv"
               ]
               
        AF.request(endUrl, method: .put, parameters: parameters, encoding: JSONEncoding.default,headers: headers).responseJSON { response in
                   switch response.result {
                   case .success(let result):
                       let json = JSON(result)
                       onCompletion?(json)
                   case .failure(let err):
                       print("\(err.localizedDescription)")
                        print("\(err)")
                       onError?(err)
                   }
               }
           }
           
    /*
     func uploadFile()
     use to uploade file
     with parameters:
     - endurl: where data will be send
     - fileData: specific data representation of file to be send
     - withName: file name
     - parameters: othr parameters need to send with
     
     + onCompletion: when upload is success
     + onError: when upload is failure
     */
//
//    func uploadFile(endUrl: String, fileData: Data?,withName: String, parameters: [String : Any], onCompletion: ((Any?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
//
//        let headers: HTTPHeaders = [
//            "Content-type": "multipart/form-data"
//        ]
//
//        AF.upload(multipartFormData: { multipartFormData in
//            for (key, value) in parameters {
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//            }
//            if let data = fileData{
//                multipartFormData.append(data, withName: withName,fileName: "image.png", mimeType: "image/png")
//            }
//
//        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: endUrl, method: .post, headers: headers) { (result) in
//            switch result{
//            case .success(let upload, _, _):
//                upload.responseJSON { response in
//                    if let err = response.error{
//                        onError?(err)
//                        return
//                    }
//                    onCompletion?(response.value)
//                }
//            case .failure(let error):
//                print("Error in upload: \(error.localizedDescription)")
//                onError?(error)
//            }
//        }
//    }
//
//    /*
//     func dwonloadImage()
//     use to dwonload images
//     with parameters:
//     - endurl: where data will be send
//
//     + onCompletion: when dwonload is success
//     + onError: when dwonload is failure
//     */
//
//    func dwonloadImage(endUrl: String, onCompletion: ((UIImage?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
//
//        AF.request(endUrl).responseImage { response in
//            switch response.result {
//            case .success:
//                if let image = response.result.value {
//                    onCompletion?(image)
//                }
//            case .failure(let err):
//                print("\(err.localizedDescription)")
//                onError?(err)
//            }
//        }
//    }
//
}
