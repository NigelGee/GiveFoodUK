//
//  EnterLocationView.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 17/10/2023.
//

import CoreLocationUI
import SwiftUI

struct EnterLocationView: View {
    @Environment(DataController.self) private var dataController
    @EnvironmentObject var router: Router

    @State private var locationManager = LocationManager()
    @State private var criteria = ""
    @State private var searchType: SearchType = .currentLocation

    static var tag = "search"

    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView {
                ZStack {
                    Color.white.opacity(0.7)
                        .frame(width: 350, height: 100)
                        .cornerRadius(10)

                    Image(.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                }
                .padding()

                Text("Welcome")
                    .font(.largeTitle)

                Text("To get started, please tell us your postcode.")
                    .padding([.horizontal, .bottom])

                HStack {
                    TextField("Enter post code or town", text: $criteria)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.characters)
                        .textContentType(.postalCode)
                        .submitLabel(.go)
                        .onSubmit { router.path.append(criteria) }

                    Button {
                        searchType = .postcode
                        router.path.append(criteria)
                    } label: {
                        Text("Go")
                            .padding(.horizontal)
                    }
                    .buttonStyle(.borderedColor(with: criteria.isEmpty ? .secondary : .blue))
                    .disabled(criteria.isEmpty)
                }
                .padding()

                LocationButton {
                    getLocation()
                }
                .frame(minHeight: 44)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 10))

                Group {
                    Text("**Give Food** is a UK charity that uses data to highlight local and structural food insecurity then provides tools to help alleviate it.")
                        .padding()
                    Text("For more information, please visit")
                    Link("www.givefood.org.uk", destination: URL(string: "https://www.givefood.org.uk")!)
                }
                .font(.callout)

                Text("**Privacy:** Postcode or your location is not used by developer or *Give Food* other then to search nearby food banks")
                    .font(.caption)
                    .padding()
            }
            .navigationTitle("Search")
            .navigationDestination(for: String.self) { _ in
                SelectFoodbankView(searchType: searchType, criteria: $criteria)
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }

    func getLocation() {
        locationManager.requestLocation()
        if let location = locationManager.location {
            searchType = .currentLocation
            criteria = "\(location.latitude),\(location.longitude)"
            router.path.append(criteria)
        }
    }
}

#Preview {
    EnterLocationView()
        .environment(DataController())
        .environmentObject(Router())
}
