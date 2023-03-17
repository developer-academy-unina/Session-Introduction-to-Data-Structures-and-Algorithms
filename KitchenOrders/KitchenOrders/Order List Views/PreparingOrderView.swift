//
//  PreparingOrderView.swift
//  KitchenOrders
//
//  Created by Tiago Pereira on 16/03/23.
//

import SwiftUI

struct PreparingOrderView: View {
    
    @EnvironmentObject var ordersStore: RestaurantOrdersStore
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                Text("Preparing Order")
                    .font(.title2)
                
                if ordersStore.orderBeingPrepared != nil {
                    OrderRowView(order: ordersStore.orderBeingPrepared!)
                } else {
                    Text("No orders being prepared at the moment.")
                        .font(.caption2)
                        .padding(.top, 8)
                }

            }
            Spacer()
        }
        .padding()
        .background(ordersStore.orderBeingPrepared != nil ? Color.green : Color.yellow)
        .foregroundColor(.white)
        .cornerRadius(10, antialiased: true)
        .padding(8)
        
    }
    
}
struct PreparingOrderView_Previews: PreviewProvider {
    static var previews: some View {
        PreparingOrderView()
    }
}
