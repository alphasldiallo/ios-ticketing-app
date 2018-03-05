//
//  Ticket.swift
//  alps-ios-TicketingApp
//
//  Created by Maciej Burda on 07/12/2017.
//  Copyright © 2017 WhenWens. All rights reserved.
//

import Foundation

struct Ticket {
    let name: String?
    let price: Int?
    var sellerEmail: String?
    
    var subscriptionId: String?
    
    var properties: [String: Any] {
        return [
            "name": name ?? "",
            "price": price ?? "",
            "sellerEmail": sellerEmail ?? ""
        ]
    }
    
    var selector: String {
        var selector = ""
        if let name = name, name != "" {
            selector += "name = '\(name)'"
        }
        if let price = price, price != 0 {
            if selector != "" {
                selector += " and "
            }
            selector += "price <= \(price)"
        }
        return selector
    }
}
