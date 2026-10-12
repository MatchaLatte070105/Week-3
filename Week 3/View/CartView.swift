//
//  CartView.swift
//  Week 3
//
//  Created by MAY 04 on 5/10/26.
//

import SwiftUI

struct CartView: View {

    @EnvironmentObject var cartViewModel: CartViewModel

    var body: some View {
        VStack(spacing: 0) {

            if cartViewModel.items.isEmpty {
                // Empty cart
                Spacer()

                VStack(spacing: 16) {
                    Image(systemName: "cart")
                        .font(.system(size: 70))
                        .foregroundStyle(.teal)

                    Text("Giỏ hàng trống")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Hãy thêm sản phẩm vào giỏ hàng!")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

            } else {
                // Cart items
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(cartViewModel.items) { item in
                            cartItemRow(item)
                        }
                    }
                    .padding()
                }

                // Total and checkout button
                VStack(spacing: 16) {
                    Divider()

                    HStack {
                        Text("Tổng cộng")
                            .font(.headline)

                        Spacer()

                        Text(
                            cartViewModel.totalPrice,
                            format: .currency(code: "VND")
                                .precision(.fractionLength(0))
                        )
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.teal)
                    }

                    NavigationLink {
                        CheckoutView(
                            totalAmount: cartViewModel.totalPrice
                        )
                    } label: {
                        Text("Tiến hành thanh toán")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.teal)
                }
                .padding()
            }
        }
        .navigationTitle("Giỏ hàng")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Cart Item Row

    private func cartItemRow(_ item: CartItem) -> some View {
        HStack(alignment: .top, spacing: 12) {

            Image(item.product.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                .clipped()
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )

            VStack(alignment: .leading, spacing: 8) {

                Text(item.product.name)
                    .font(.headline)

                Text(item.product.formattedPrice)
                    .font(.subheadline)
                    .foregroundStyle(.teal)

                HStack(spacing: 12) {

                    Button {
                        cartViewModel.decreaseQuantity(for: item)
                    } label: {
                        Image(systemName: "minus.circle")
                    }

                    Text("\(item.quantity)")
                        .fontWeight(.semibold)

                    Button {
                        cartViewModel.increaseQuantity(for: item)
                    } label: {
                        Image(systemName: "plus.circle")
                    }

                    Spacer()

                    Button(role: .destructive) {
                        cartViewModel.removeItem(item)
                    } label: {
                        Image(systemName: "trash")
                    }
                }
                .buttonStyle(.borderless)
            }
        }
        .padding()
        .background(
            Color(.secondarySystemBackground),
            in: RoundedRectangle(cornerRadius: 14)
        )
    }
}

#Preview {
    NavigationStack {
        CartView()
    }
    .environmentObject(CartViewModel())
}

 
