//
//  Order.swift
//  KitchenOrders
//
//  Created by Tiago Pereira on 16/03/23.
//

import Foundation

struct Order: Identifiable {
    
    var id: UUID = UUID()
    var items: [MenuItem]
    var clientName: String
    var priority: Priority = .low
    
    var description: String {
        let result = items.reduce("| ") { partialResult, currentItem in
            return partialResult + "\(currentItem.rawValue) | "
        }
        
        return result
    }
    
}
