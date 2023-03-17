//
//  OrderRowView.swift
//  KitchenOrders
//
//  Created by Tiago Pereira on 16/03/23.
//

import SwiftUI

struct OrderRowView: View {
    
    var order: Order
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("\(order.clientName)")

                    Spacer()
                    
                    if order.priority == .high {
                        Image(systemName: "exclamationmark.triangle.fill")
                    }
                }.font(.headline)
                
                
                ForEach(order.items, id: \.self) { item in
                    Text("• \(item.rawValue)")
                }
                
                Text("Order n: \(order.id.hashValue)")
                    .font(.caption)
            }
            
            Spacer()
        }
        .padding()
    }
    
}

struct OrderRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OrderRowView(order: Order(items: [.hamburger], clientName: "John"))
            
            OrderRowView(order: Order(items: [.hamburger], clientName: "John", priority: .high))
        }
    }
}
