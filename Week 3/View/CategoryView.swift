//
//  CategoryView.swift
//  Week 3
//
//  Created by MAY 04 on 5/10/26.
//

import SwiftUI

struct CategoryView: View {

    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel

    @State private var selectedCategory: String? = nil

    // Temporary categories until MockData.swift is ready
    private let categories: [Category] = [
        Category(name: "Cá cảnh", iconName: "fish.fill"),
        Category(name: "Bể cá", iconName: "water.waves"),
        Category(name: "Cây thủy sinh", iconName: "leaf.fill"),
        Category(name: "Thức ăn", iconName: "fork.knife"),
        Category(name: "Máy lọc", iconName: "drop.fill"),
        Category(name: "Đèn", iconName: "lightbulb.fill"),
        Category(name: "Trang trí", iconName: "sparkles"),
        Category(name: "Máy sủi", iconName: "wind"),
        Category(name: "Thuốc", iconName: "cross.vial"),
        Category(name: "Phụ kiện", iconName: "shippingbox.fill")
    ]

    // Temporary products
    private let products: [Product] = [
        Product(
            name: "Cá Betta",
            description: "Cá cảnh nhiều màu sắc",
            price: 50000,
            imageName: "betta",
            category: "Cá cảnh",
            rating: 4.8
        ),
        Product(
            name: "Cá Guppy",
            description: "Cá bảy màu dễ nuôi",
            price: 30000,
            imageName: "guppy",
            category: "Cá cảnh",
            rating: 4.7
        ),
        Product(
            name: "Bể cá mini",
            description: "Bể kính nhỏ gọn",
            price: 150000,
            imageName: "aquarium",
            category: "Bể cá",
            rating: 4.9
        ),
        Product(
            name: "Rong đuôi chó",
            description: "Cây thủy sinh dễ chăm sóc",
            price: 20000,
            imageName: "plant",
            category: "Cây thủy sinh",
            rating: 4.6
        )
    ]

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    private var filteredProducts: [Product] {
        guard let selectedCategory else {
            return products
        }

        return products.filter {
            $0.category == selectedCategory
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    Text("Khám phá danh mục")
                        .font(.title2)
                        .fontWeight(.bold)

                    CategoryGridView(
                        categories: categories
                    ) { category in
                        selectedCategory = category.name
                    }

                    HStack {
                        Text(selectedCategory ?? "Tất cả sản phẩm")
                            .font(.title2)
                            .fontWeight(.bold)

                        Spacer()

                        if selectedCategory != nil {
                            Button("Xem tất cả") {
                                selectedCategory = nil
                            }
                        }
                    }

                    if filteredProducts.isEmpty {
                        ContentUnavailableView(
                            "Chưa có sản phẩm",
                            systemImage: "shippingbox",
                            description: Text(
                                "Danh mục này hiện chưa có sản phẩm."
                            )
                        )
                    } else {
                        LazyVGrid(
                            columns: columns,
                            spacing: 16
                        ) {
                            ForEach(filteredProducts) { product in
                                productCard(product)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Danh mục")
        }
    }

    // MARK: - Product Card

    private func productCard(_ product: Product) -> some View {
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
                    Image(
                        systemName: favoritesViewModel.isFavorite(product)
                            ? "heart.fill"
                            : "heart"
                    )
                    .foregroundStyle(.red)
                    .padding(8)
                    .background(.white, in: Circle())
                }
                .padding(8)
            }

            Text(product.name)
                .font(.headline)
                .lineLimit(1)

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
    CategoryView()
        .environmentObject(CartViewModel())
        .environmentObject(FavoritesViewModel())
}

 
