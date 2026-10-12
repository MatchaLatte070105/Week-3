//
//  HomeView.swift
//  Week 3
//
//  Created by MAY 04 on 5/10/26.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel

    @StateObject private var searchViewModel = SearchViewModel()

    @State private var selectedCity = "TP. Hồ Chí Minh"
    @State private var showCart = false
    @State private var selectedCategory: String? = nil

    // Temporary data until MockData.swift is ready
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
        let searchResults = ImageSearchManager.shared.searchProducts(
            keyword: searchViewModel.searchText,
            in: products
        )

        guard let selectedCategory else {
            return searchResults
        }

        return searchResults.filter {
            $0.category == selectedCategory
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    HeaderView {
                        showCart = true
                    }

                    DeliveryBarView(
                        selectedCity: $selectedCity
                    )

                    SearchBarView(
                        viewModel: searchViewModel
                    )

                    // Categories
                    HStack {
                        Text("Danh mục")
                            .font(.title2)
                            .fontWeight(.bold)

                        Spacer()

                        if selectedCategory != nil {
                            Button("Xem tất cả") {
                                selectedCategory = nil
                            }
                            .font(.subheadline)
                        }
                    }

                    CategoryGridView(
                        categories: categories
                    ) { category in
                        selectedCategory = category.name
                    }

                    // Products
                    Text(
                        selectedCategory ?? "Sản phẩm nổi bật"
                    )
                    .font(.title2)
                    .fontWeight(.bold)

                    if filteredProducts.isEmpty {
                        ContentUnavailableView(
                            "Không tìm thấy sản phẩm",
                            systemImage: "magnifyingglass",
                            description: Text(
                                "Thử tìm kiếm sản phẩm khác."
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
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .navigationBarHidden(true)
            .navigationDestination(
                isPresented: $showCart
            ) {
                CartView()
            }
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
    HomeView()
        .environmentObject(CartViewModel())
        .environmentObject(FavoritesViewModel())
}

 
