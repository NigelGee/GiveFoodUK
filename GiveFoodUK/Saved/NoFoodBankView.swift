//
//  NoFoodBankView.swift
//  GiveFoodUK
//
//  Created by Nigel Gee on 28/10/2023.
//

import SwiftUI

/// A view to show when no food banks are selected
struct NoFoodBankView: View {
    @AppStorage("selectedView") var selectedView: String?

    var body: some View {
        ContentUnavailableView {
            Label("No Foodbank Saved!", systemImage: "house")
        } description: {
            Text("Search and select a food bank to save details.")
        } actions: {
            Button {
                selectedView = EnterLocationView.tag
            } label: {
                Label("Search", systemImage: "magnifyingglass")
            }
            .buttonStyle(.borderedColor(with: .indigo))
        }
    }
}

#Preview {
    NoFoodBankView()
}
