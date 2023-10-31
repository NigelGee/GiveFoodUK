//
//  FailedView.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 18/10/2023.
//

import SwiftUI

struct FailedView: View {
    var retry: () -> Void
    var location: () -> Void

    init(retry: @escaping () -> Void, action location: @escaping () -> Void) {
        self.retry = retry
        self.location = location
    }

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
            VStack(spacing: 10) {
                Button("Retry", systemImage: "arrow.circlepath", action: retry)
                    .buttonStyle(.borderedColor(with: .red))

                Button("Change Location", systemImage: "location.fill", action: location)
                .buttonStyle(.borderedColor(with: .blue))
            }
        }
        .dynamicTypeSize(...DynamicTypeSize.accessibility3)
    }
}

#Preview {
    FailedView() { } action: { }
}
