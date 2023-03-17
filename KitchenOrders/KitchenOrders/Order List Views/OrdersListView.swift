//
//  OrdersListView.swift
//  KitchenOrders
//
//  Created by Tiago Pereira on 16/03/23.
//

import SwiftUI

struct OrdersListView: View {
    
    @StateObject var ordersStore: RestaurantOrdersStore = RestaurantOrdersStore.shared
    
    @State var isPresentingNewOrder: Bool = false
    
    var body: some View {
        
        VStack {
            
            PreparingOrderView()
                .environmentObject(ordersStore)
            
            if ordersStore.orders.isEmpty {
                VStack {
                    Spacer()
                    Text("No orders to be prepared at the moment")
                        .foregroundColor(.secondary)
                    Spacer()
                }
                
            }
            
            ScrollView {
                ForEach(ordersStore.orders) { order in
                    OrderRowView(order: order)
                        .background(Color(uiColor: UIColor.systemGray6))
                        .cornerRadius(10, antialiased: true)
                        .padding(8)
                }
            }
            
            Button(action: {
                self.prepareNextOrder()
            }, label: {
                HStack {
                    Spacer()
                    Text("Prepare Next Order")
                    Spacer()
                }
                .padding()
                
            })
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(10, antialiased: true)
            .padding()
        }
        .navigationTitle("Kitchen Orders")
        .toolbar {
            ToolbarItem {
                Button {
                    self.isPresentingNewOrder.toggle()
                } label: {
                    Text("New Order")
                }

            }
        }
        .sheet(isPresented: $isPresentingNewOrder) {
            NavigationStack {
                NewOrderView()
            }
            .environmentObject(ordersStore)
        }
        
    }
    
    private func prepareNextOrder() {
        do {
            let _ = try ordersStore.prepareNextOrder()
        } catch {
            print("Error: \(error.localizedDescription)")
        }

    }
    
}


struct OrdersListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OrdersListView()
        }
    }
}
