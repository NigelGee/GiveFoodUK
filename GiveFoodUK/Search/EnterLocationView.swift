//
//  EnterLocationView.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 17/10/2023.
//

import SwiftUI

struct EnterLocationView: View {
    @Environment(DataController.self) private var dataController
    @EnvironmentObject var router: Router

    @AppStorage("postcode") var postcode = ""

    static var tag = "search"

    var body: some View {
        NavigationStack(path: $router.path) {
            VStack{
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
                    TextField("Enter post code or town", text: $postcode)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.characters)
                        .textContentType(.postalCode)
                        .submitLabel(.go)
                        .onSubmit { router.path.append(postcode) }

                    Button {
                        router.path.append(postcode)
                    } label: {
                        Text("Go")
                            .padding(.horizontal)
                    }
                    .buttonStyle(.borderedColor(with: .blue))
                    .disabled(postcode == "")
                }
                .padding()

                Group {
                    Text("**Give Food** is a UK charity that uses data to highlight local and structural food insecurity then provides tools to help alleviate it.")
                        .padding()
                    Text("For more information, please visit")
                    Link("www.givefood.org.uk", destination: URL(string: "https://www.givefood.org.uk")!)
                }
                .font(.callout)

                Spacer()

                Text("**Privacy:** Postcode is used by developer or *Give Food* other then to search nearby foodbanks")
                    .font(.caption)
            }
            .navigationTitle("Search")
            .navigationDestination(for: String.self) { _ in
                SelectFoodbankView()
            }
            .task {
                if postcode != "" {
                    router.path.append(postcode)
                }
            }
        }
    }
}

#Preview {
    EnterLocationView()
        .environment(DataController())
        .environmentObject(Router())
}
