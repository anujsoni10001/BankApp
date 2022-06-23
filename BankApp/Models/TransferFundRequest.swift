//
//  TransferFundRequest.swift
//  BankApp
//
//  Created by Anuj Soni on 17/06/22.
//

import Foundation

struct TransferFundRequest : Codable{
let accountFromId:String
let accountToId:String
let amount:Double
}
