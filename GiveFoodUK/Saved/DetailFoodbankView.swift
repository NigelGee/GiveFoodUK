//
//  DetailFoodbankView.swift
//  ShareAMeal
//
//  Created by Nigel Gee on 22/10/2023.
//

import SwiftUI

struct DetailFoodbankView: View {
    let foodbank: Foodbank

    var body: some View {
        List {
            VStack(alignment: .leading) {
                Text(foodbank.name)
                    .font(.title)
                Text(foodbank.address)
            }

            HStack {
                Text("Charity Number:")
                Spacer()
                if let registrationID = foodbank.charity.registrationID, let registerURL =  foodbank.charity.registerURL {
                    if let url = URL(string: registerURL) {
                        Link(registrationID, destination: url)
                    }
                } else {
                    Text("Unknown")
                        .foregroundStyle(.secondary)
                }
            }
            .accessibilityElement()
            .accessibilityLabel("Charity Number is \(foodbank.charity.registrationID ?? "Unknown")")

            VStack(alignment: .leading) {
                Text("Phone:")
                if let url = URL(string: "tel: \(foodbank.formattedPhone)") {
                    Link(foodbank.phone, destination: url)
                }
            }
            .accessibilityLabel("Phone number is \(foodbank.phone)")

            if let url = URL(string: foodbank.URLS.homepage) {
                VStack(alignment: .leading) {
                    Text("Website:")
                    Link(foodbank.URLS.homepage, destination: url)
                }
                .accessibilityLabel("Website is \(foodbank.URLS.homepage)")
            }


            if let url = URL(string: "mailto:\(foodbank.email)") {
                VStack(alignment: .leading) {
                    Text("Email:")
                    Link(foodbank.email, destination: url)
                }
                .accessibilityLabel("email is \(foodbank.email)")
            }

            Section("\(foodbank.politics.parliamentaryConstituency) Constituency") {
                VStackLayout(alignment: .leading) {

                    LabeledContent(foodbank.politics.mp) {
                        Image(systemName: "rosette")
                            .rotationEffect(.degrees(-25))
                            .foregroundStyle(foodbank.politics.rosetteColor)
                            .font(.title3)
                    }
                    .accessibilityLabel(foodbank.politics.mpParty)

                    LabeledContent("Ward:", value: foodbank.politics.ward)
                    LabeledContent("District:", value: foodbank.politics.district)

                    Link("Write to your MP", destination: URL(string: "https://www.givefood.org.uk/write/")!)
                        .buttonStyle(.borderedColor(with: .indigo))
                        .frame(maxWidth: .infinity, alignment: .center)

                }

            }
        }
    }
}

#Preview {
    DetailFoodbankView(foodbank: .example)
}
