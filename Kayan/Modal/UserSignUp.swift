//
//  UserSignUp.swift
//  Kayan
//
//  Created by mohammed aburukbah on 17/09/1442 AH.
//

import SwiftUI
import Foundation

struct Section:Identifiable, Decodable {
    let id: Int
       let name, phoneNo, password: String
       let ganderID: Int
       let gander: String?
       let verfiyCode: String
       let isVerfiy, isActive: Bool
       let createAt, updateAt: String
}
