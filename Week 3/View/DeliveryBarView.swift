//
//  DeliveryBarView.swift
//  Week 3
//
//  Created by MAY 04 on 5/10/26.
//

import SwiftUI

struct DeliveryBarView: View {

    @Binding var selectedCity: String

    private let cities = [
        "TP. Hồ Chí Minh",
        "Hà Nội",
        "Đà Nẵng",
        "Cần Thơ"
    ]

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "mappin.and.ellipse")
                .foregroundStyle(.teal)

            Text("Giao hàng đến:")
                .font(.subheadline)

            Menu {
                ForEach(cities, id: \.self) { city in
                    Button(city) {
                        selectedCity = city
                    }
                }
            } label: {
                HStack(spacing: 4) {
                    Text(selectedCity)
                        .fontWeight(.semibold)

                    Image(systemName: "chevron.down")
                        .font(.caption)
                }
                .foregroundStyle(.teal)
            }

            Spacer()
        }
        .padding()
        .background(
            Color.teal.opacity(0.08),
            in: RoundedRectangle(cornerRadius: 12)
        )
    }
}

#Preview {
    DeliveryBarView(
        selectedCity: .constant("TP. Hồ Chí Minh")
    )
}

 
