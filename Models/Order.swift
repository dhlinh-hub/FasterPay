//
//  Order.swift
//  SampleApp
//
//  Created by Ishipo on 09/06/2021.
//
import Foundation
import SwiftyJSON


struct Order: Codable {
    let amount: Int?
    let title: String?
    let message: String?
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case title = "title"
        case message = "message"
        case image = "image"
    }
    
  
}
