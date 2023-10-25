//
//  FailedView.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 18/10/2023.
//

import SwiftUI

struct FailedView: View {
    @EnvironmentObject var router: Router
    var action: () -> Void

    var body: some View {
        ContentUnavailableView {
            Label("Load failed", systemImage: "exclamationmark.triangle")
                .symbolRenderingMode(.multicolor)
        } description: {
            Text("""
            Check internet connection; please try again.
            Check location details and retry.
            """)
        } actions: {
            VStack(spacing: 0) {
                Button("Retry", systemImage: "arrow.circlepath", action: action)
                    .buttonStyle(.borderedColor(with: .red))

                Button("Location", systemImage: "location") {
                    router.path.removeLast()
                }
                .buttonStyle(.borderedColor(with: .blue))

            }
        }
    }
}

#Preview {
    FailedView() { }
        .environmentObject(Router())
}
