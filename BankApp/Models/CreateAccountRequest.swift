//
//  CreateAccountRequest.swift
//  BankApp
//
//  Created by Anuj Soni on 08/06/22.
//

import Foundation

struct CreateAccountRequest : Codable{
let name:String
let accountType : String
let balance :Double
}
