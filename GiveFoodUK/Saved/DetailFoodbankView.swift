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
            
            VStack(alignment: .leading) {
                Text("Phone:")
                if let url = URL(string: "tel: \(foodbank.formattedPhone)") {
                    Link(foodbank.phone, destination: url)
                }
            }

            if let url = URL(string: "mailto:\(foodbank.email)") {
                VStack(alignment: .leading) {
                    Text("Email:")
                    Link(foodbank.email, destination: url)
                }
            }

            Section("\(foodbank.politics.parliamentaryConstituency) Constituency") {
                VStackLayout(alignment: .leading) {

                    LabeledContent(foodbank.politics.mp) {
                        Image(systemName: "rosette")
                            .rotationEffect(.degrees(-25))
                            .foregroundStyle(foodbank.politics.rosetteColor)
                            .font(.title3)
                    }
                    LabeledContent("Ward:", value: foodbank.politics.ward)
                    LabeledContent("District:", value: foodbank.politics.district)
                }

            }
        }
    }
}

#Preview {
    DetailFoodbankView(foodbank: .example)
}
