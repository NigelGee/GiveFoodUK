//
//  SelectFoodbankView.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 17/10/2023.
//

import SwiftUI
import TipKit

struct SelectFoodbankView: View {
    @AppStorage("postcode") var postcode = ""
    @AppStorage("isList") var isList = true

    @Environment(DataController.self) private var dataController
    @EnvironmentObject var router: Router

    @State private var state = LoadState.loading

    let changeViewTip = ChangeViewTip()

    var body: some View {
        Group {
            switch state {
            case .loading:
                ProgressView("Loading…")
            case .failed:

                FailedView(action: fetchFoodbanks)
            case .loaded(let foodbanks):
                TipView(changeViewTip)
                    .tipBackground(.blue.opacity(0.2))
                LoadedFoodbankView(foodbanks: foodbanks)
            }
        }
        .navigationTitle("Nearby for \(postcode)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .task { fetchFoodbanks() }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    dataController.select(nil)
                    postcode = ""
                    router.path.removeLast()
                } label: {
                    Label("Change Location", systemImage: "location")
                }
            }

            ToolbarItem(placement: .topBarLeading) {
                Button {
                    withAnimation {
                        isList.toggle()
                        changeViewTip.invalidate(reason: .actionPerformed)
                    }
                } label: {
                    Label("Change View", systemImage: isList ? "map" : "list.bullet")
                }
                // Not showing pop over tip!
                .popoverTip(changeViewTip, arrowEdge: .top)
            }
        }
        .task {
            await ChangeViewTip.changeViewEvent.donate()
        }
    }

    func fetchFoodbanks() {
        state = .loading

        Task {
            try await Task.sleep(for: .seconds(0.5))

            state = await dataController.loadFoodbanks(near: postcode)
        }
    }
}

#Preview {
    TabView {
        NavigationStack {
            SelectFoodbankView()
                .environment(DataController())
                .environmentObject(Router())
        }
    }
}
