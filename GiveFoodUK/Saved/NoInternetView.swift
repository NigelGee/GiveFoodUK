//
//  NoInternetView.swift
//  GiveFoodUK
//
//  Created by Nigel Gee on 01/11/2023.
//

import SwiftUI

/// A view to show if a selected food bank does not show.
struct NoInternetView: View {
    let retry: () -> Void

    var body: some View {
        ContentUnavailableView {
            Label("Failed to Load", systemImage: "wifi.exclamationmark")
                .symbolRenderingMode(.hierarchical)
        } description: {
            Text("""
            Opps something went wrong!
            Check your internet connection.
            """)
        } actions: {
            Button("Try Again!", systemImage: "arrow.circlepath", action: retry)
                .buttonStyle(.borderedColor(with: .red))
        }
    }
}

#Preview {
    NoInternetView() { }
}
