//
//  LoadedFoodbankView.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 19/10/2023.
//

import MapKit
import SwiftUI
import TipKit

struct LoadedFoodbankView: View {
    @AppStorage("selectedView") var selectedView: String?
    @AppStorage("isList") var isList = true
    @Environment(DataController.self) private var dataController
    let foodbanks: [FoodbankLocation]

    let selectFoodbankTip = SelectFoodbankTip()

    var body: some View {
        Group {
            if isList {
                TipView(selectFoodbankTip, arrowEdge: .bottom)
                    .tipBackground(.blue.opacity(0.2))
                    .padding()
                List {
                    ForEach(foodbanks) { foodbank in
                        Section {
                            Button {
//                                selected(foodbank)
                                selectFoodbankTip.invalidate(reason: .actionPerformed)
                            } label: {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(foodbank.name)
                                            .font(.title)
                                        Spacer()

                                        Text(foodbank.distanceFormatted)
                                            .font(.caption.bold())
                                    }

                                    Text(foodbank.address)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            } else {
                Map {
                    ForEach(foodbanks) { foodbank in
                        if let coordinate = foodbank.coordinate {
                            Annotation(foodbank.name, coordinate: coordinate) {
                                Button {
//                                    selected(foodbank)
                                } label: {
                                    Image(systemName: "house")
                                }
                                .buttonStyle(.plain)
                                .padding(7)
                                .background(.red)
                                .clipShape(Circle())
                                .foregroundStyle(.white)
                            }
                        }
                    }
                }
            }
        }
    }

    func selected(_ foodbank: Foodbank) {
        if dataController.selectedFoodbank != nil {
            dataController.select(nil)
            Task {
                try await Task.sleep(for: .seconds(0.01))
                dataController.select(foodbank)
            }
        } else {
            dataController.select(foodbank)
        }

        selectedView = SavedFoodbankView.tag
    }
}

#Preview {
    NavigationStack {
        LoadedFoodbankView(foodbanks: [.example])
    }
    .environment(DataController())
}
