//
//  OrdersStore.swift
//  KitchenOrders
//
//  Created by Tiago Pereira on 16/03/23.
//

import Foundation
import Collections

enum Priority: String, CaseIterable {
    case low = "Low"
    case high = "High"
}

enum MenuItem: String, CaseIterable {
    case hamburger = "Hamburger"
    case frenchFries = "French Fries"
    case soda = "Soda"
    case iceCream = "Ice Cream"
    case water = "Water"
    case chickenBurger = "Chicken Burger"
    case coffee = "Coffee"
}

enum OrderError: Error {
    case noOrders
}

extension OrderError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noOrders:
            return "No orders available"
        }
    }
}

class RestaurantOrdersStore: ObservableObject {
    
    static let shared: RestaurantOrdersStore = RestaurantOrdersStore()
    
    @Published var orders: Deque<Order>
    @Published var orderBeingPrepared: Order?
    
    private init() {
        self.orders = []
        
        self.loadOrders()
    }
    
    private func loadOrders() {
        let order1 = Order(items: [.hamburger, .soda, .frenchFries], clientName: "Julio")
        let order2 = Order(items: [.chickenBurger, .water], clientName: "Fernando")
        let order3 = Order(items: [.coffee], clientName: "Giselle")
        let order4 = Order(items: [.hamburger, .soda], clientName: "Karina")
        
        self.add(new: order1, with: .low)
        self.add(new: order2, with: .low)
        self.add(new: order3, with: .low)
        self.add(new: order4, with: .low)
    }
    
    func add(new order: Order, with priority: Priority) {
        switch priority {
        case .low:
            orders.append(order)
        case .high:
            orders.prepend(order)
        }
    }
    
    func prepareNextOrder() throws -> Order {
        guard let orderInPreparation = orders.popFirst() else {
            throw OrderError.noOrders
        }
        
        print("🥘 Preparing order \(orderInPreparation.id)")
        
        self.orderBeingPrepared = orderInPreparation
        
        return orderInPreparation
    }
    
}
