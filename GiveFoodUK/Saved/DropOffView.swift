//
//  DropOffView.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 17/10/2023.
//

import MapKit
import SwiftUI

struct DropOffView: View {
    @AppStorage("isList") var isList = true
    var foodbank: Foodbank?

    let changeViewTip = ChangeViewTip()

    var body: some View {
        if let foodbank {
            Group {
                if isList {
                    List {
                        Section {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(foodbank.name)
                                        .font(.title)
                                    Spacer()
                                    Image(systemName: "house")
                                        .font(.title3)
                                }

                                Text(foodbank.address)
                            }
                        }

                        if let locations = foodbank.locations {
                            ForEach(locations) { location in
                                Section {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(location.name)
                                                .font(.title)
                                            Spacer()
                                            Image(systemName: "basket")
                                                .font(.title3)
                                        }

                                        Text(location.address)
                                    }
                                }
                            }
                        }
                    }
                } else {
                    Map {
                        if let coordinate = foodbank.coordinate {
                            Marker("\(foodbank.name) Foodbank", systemImage: "house", coordinate: coordinate)
                        }

                        if let locations = foodbank.locations {
                            ForEach(locations) { location in
                                if let coordinate = location.coordinate {
                                    Marker(location.name, systemImage: "basket", coordinate: coordinate)
                                        .tint(.blue)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Drop-Off Points")
            .toolbar {
                Button {
                    withAnimation {
                        isList.toggle()
                    }
                } label: {
                    Label("Change View", systemImage: isList ? "map" : "list.bullet")
                }
                .popoverTip(changeViewTip, arrowEdge: .top)
            }
        } else {
            ContentUnavailableView {
                Label("Load failed", systemImage: "exclamationmark.triangle")
                    .symbolRenderingMode(.multicolor)
            } description: {
                Text("Check your internet connections!")
            }

        }
    }
}

#Preview {
    NavigationStack {
        DropOffView(foodbank: .example)
    }
}
