//
//  EnterLocationView.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 17/10/2023.
//

import CoreLocationUI
import SwiftUI

/// A view that enable user to enter a postcode/town or use current location to search for nearby food banks
struct EnterLocationView: View {
    @Environment(DataController.self) private var dataController
    @EnvironmentObject var router: Router

    @State private var locationManager = LocationManager()

    /// A property that will be used in `URL` to retrieve JSON data
    @State private var criteria = ""

    /// A property that will have the search type choose
    @State private var searchType: SearchType = .currentLocation

    static var tag = "search"

    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView {
                Image(.logoName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .padding()
                    .colorSchemeEffect

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
                    .buttonStyle(.borderedColor(with: criteria.isEmpty ? .titleColor : .blue))
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

                Text("**Privacy:** Postcode or your location is not stored by developer or *Give Food* other then to search nearby food banks. The app only store your preference to Map/List View and the Saved food bank ID.")
                    .font(.caption)
                    .padding()
            }
            .navigationTitle("Search")
            .navigationDestination(for: String.self) { _ in
                SelectFoodbankView(searchType: searchType, criteria: $criteria)
            }
            .scrollBounceBehavior(.basedOnSize)
            .onAppear { criteria = "" }
        }
    }
    
    /// A method that request current location of user and set properties
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
