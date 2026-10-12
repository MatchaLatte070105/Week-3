//
//  CategoryGridView.swift
//  Week 3
//
//  Created by MAY 04 on 5/10/26.
//

import SwiftUI

struct CategoryGridView: View {

    let categories: [Category]
    var onSelect: (Category) -> Void

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 8),
        count: 5
    )

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {

            ForEach(categories) { category in
                Button {
                    onSelect(category)
                } label: {
                    VStack(spacing: 8) {

                        Image(systemName: category.iconName)
                            .font(.title2)
                            .foregroundStyle(.teal)
                            .frame(width: 52, height: 52)
                            .background(
                                Color.teal.opacity(0.1),
                                in: RoundedRectangle(cornerRadius: 14)
                            )

                        Text(category.name)
                            .font(.system(size: 10))
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .frame(height: 28)
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    CategoryGridView(
        categories: [
            Category(name: "Cá cảnh", iconName: "fish.fill"),
            Category(name: "Bể cá", iconName: "water.waves"),
            Category(name: "Cây thủy sinh", iconName: "leaf.fill")
        ],
        onSelect: { _ in }
    )
    .padding()
}

 
