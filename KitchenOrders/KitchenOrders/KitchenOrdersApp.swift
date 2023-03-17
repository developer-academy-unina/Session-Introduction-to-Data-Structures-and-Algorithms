//
//  KitchenOrdersApp.swift
//  KitchenOrders
//
//  Created by Tiago Pereira on 16/03/23.
//

import SwiftUI

@main
struct KitchenOrdersApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                OrdersListView()
            }
        }
    }
}
