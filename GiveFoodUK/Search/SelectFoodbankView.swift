//
//  SelectFoodbankView.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 17/10/2023.
//

import SwiftUI
import TipKit

struct SelectFoodbankView: View {
    @Environment(DataController.self) private var dataController
    @EnvironmentObject var router: Router

    @AppStorage("isList") var isList = true

    @State private var state = LoadState.loading

    let searchType: SearchType
    @Binding var criteria: String

    let changeViewTip = ChangeViewTip()

    var body: some View {
        Group {
            switch state {
            case .loading:
                ProgressView("Loading…")
            case .loadedLocation(let foodbanks):
                LoadedFoodbankView(foodbanks: foodbanks)
            default:
                FailedView(action: fetchFoodbanks)
            }
        }
        .navigationTitle("Nearby \(searchType == .postcode ? "for \(criteria)" : "Your Location")")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .task {
            fetchFoodbanks()
            await ChangeViewTip.changeViewEvent.donate()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    criteria = ""
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
                    Image(systemName: isList ? "map" : "list.bullet")
                }
                .popoverTip(changeViewTip, arrowEdge: .top)
                .accessibilityLabel("Change between Map and List View")
            }
        }
    }

    func fetchFoodbanks() {
        state = .loading

        Task {
            try await Task.sleep(for: .seconds(0.5))

            state = await dataController.loadFoodbanks(searchType, for: criteria)
        }
    }
}

#Preview {
    TabView {
        NavigationStack {
            SelectFoodbankView(searchType: .postcode, criteria: .constant("BA1 1AA"))
                .environment(DataController())
                .environmentObject(Router())
        }
    }
}
