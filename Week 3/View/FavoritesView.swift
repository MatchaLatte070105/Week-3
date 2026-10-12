//
//  FavoritesView.swift
//  Week 3
//
//  Created by MAY 04 on 5/10/26.
//

import SwiftUI

struct FavoritesView: View {

    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @EnvironmentObject var cartViewModel: CartViewModel

    // Temporary data until MockData.swift is ready.
    // IMPORTANT: Pass the same products used in HomeView.
    let products: [Product]

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    private var favoriteProducts: [Product] {
        favoritesViewModel.getFavoriteProducts(from: products)
    }

    var body: some View {
        NavigationStack {
            Group {
                if favoriteProducts.isEmpty {
                    ContentUnavailableView(
                        "Chưa có sản phẩm yêu thích",
                        systemImage: "heart",
                        description: Text(
                            "Nhấn vào biểu tượng trái tim để lưu sản phẩm yêu thích."
                        )
                    )
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(favoriteProducts) { product in
                                favoriteCard(product)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Yêu thích")
        }
    }

    // MARK: - Favorite Product Card

    private func favoriteCard(_ product: Product) -> some View {
        VStack(alignment: .leading, spacing: 10) {

            ZStack(alignment: .topTrailing) {
                Image(product.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 130)
                    .frame(maxWidth: .infinity)
                    .clipped()

                Button {
                    favoritesViewModel.toggleFavorite(product)
                } label: {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                        .padding(8)
                        .background(.white, in: Circle())
                }
                .padding(8)
            }

            Text(product.name)
                .font(.headline)
                .lineLimit(1)

            Text(product.description)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(2)

            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .foregroundStyle(.orange)

                Text(
                    product.rating.formatted(
                        .number.precision(.fractionLength(1))
                    )
                )
                .font(.caption)
            }

            Text(product.formattedPrice)
                .font(.headline)
                .foregroundStyle(.teal)

            Button {
                cartViewModel.addToCart(product)
            } label: {
                Label(
                    "Thêm vào giỏ",
                    systemImage: "cart.badge.plus"
                )
                .font(.caption)
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.teal)
        }
        .padding(10)
        .background(
            Color(.secondarySystemBackground),
            in: RoundedRectangle(cornerRadius: 14)
        )
    }
}

#Preview {
    FavoritesView(products: [])
        .environmentObject(FavoritesViewModel())
        .environmentObject(CartViewModel())
}

 
