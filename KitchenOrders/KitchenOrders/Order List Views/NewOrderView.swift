//
//  NewOrderView.swift
//  KitchenOrders
//
//  Created by Tiago Pereira on 16/03/23.
//

import SwiftUI

struct SelectableMenuItem {
    var item: MenuItem
    var isSelected: Bool
}

struct NewOrderView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var ordersStore: RestaurantOrdersStore
    
    @State var clientName: String = ""
    @State var availableMenu: [SelectableMenuItem] = []
    @State var priority: Priority = .low
    
    
    var body: some View {
        Form {
            Section {
                TextField("Client Name", text: $clientName)
            } header: {
                Text("What is the name of the client?")
            }
            
            Section {
                ForEach($availableMenu, id: \.item) { menuItem in
                    //Text(menuItem.item.rawValue)
                    Toggle(isOn: menuItem.isSelected) {
                        Text(menuItem.wrappedValue.item.rawValue)
                    }
                }
            } header: {
                Text("Available Menu")
            }
            
            Section {
                Picker(selection: $priority) {
                    ForEach(Priority.allCases, id: \.self) { priority in
                        Text(priority.rawValue)
                    }
                } label: {
                    Text("Choose the order priority")
                }
                .pickerStyle(.segmented)

            } header: {
                Text("Priority")
            }
        }
        .navigationTitle("New Order")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button {
                    self.createNewOrder()
                } label: {
                    Text("Done")
                }

            }
        }
        .task {
            self.prepareMenu()
        }
    }
    
    private func prepareMenu() {
        for item in MenuItem.allCases {
            let menuItem = SelectableMenuItem(item: item, isSelected: false)
            availableMenu.append(menuItem)
        }
    }
    
    private func isNameValid() -> Bool {
        return clientName.isEmpty == false
    }
    
    private func isMenuSelectionValid() -> Bool {
        
        for menuItem in availableMenu {
            if menuItem.isSelected {
                return true
            }
        }
        
        return false
    }
    
    func createNewOrder() {
        
        if isNameValid() && isMenuSelectionValid() {
            var selectedItems: [MenuItem] = []
            
            for selection in availableMenu {
                if selection.isSelected {
                    selectedItems.append(selection.item)
                }
            }
            
            let newOrder = Order(items: selectedItems, clientName: clientName, priority: priority)
            
            ordersStore.add(new: newOrder, with: self.priority)

            dismiss()
        }
        
    }
}

struct NewOrderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NewOrderView()
        }
    }
}
