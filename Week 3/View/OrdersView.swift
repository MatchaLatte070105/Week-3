//
//  OrdersView.swift
//  Week 3
//
//  Created by MAY 04 on 5/10/26.
//

import SwiftUI

struct OrdersView: View {

    // Existing controller from your teammate
    @ObservedObject private var orderManager = OrderManager.shared

    var body: some View {
        NavigationStack {
            Group {
                if orderManager.orderHistory.isEmpty {

                    // MARK: - Empty Orders
                    ContentUnavailableView(
                        "Chưa có đơn hàng",
                        systemImage: "shippingbox",
                        description: Text(
                            "Các đơn hàng đã đặt sẽ xuất hiện tại đây."
                        )
                    )

                } else {

                    // MARK: - Order List
                    ScrollView {
                        LazyVStack(spacing: 16) {

                            ForEach(
                                Array(orderManager.orderHistory.enumerated()),
                                id: \.offset
                            ) { index, order in

                                orderCard(
                                    order,
                                    orderNumber: orderManager.totalOrdersCount - index
                                )
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Đơn hàng")
        }
    }

    // MARK: - Order Card
    private func orderCard(
        _ items: [CartItem],
        orderNumber: Int
    ) -> some View {

        VStack(alignment: .leading, spacing: 14) {

            HStack {
                Image(systemName: "shippingbox.fill")
                    .foregroundStyle(.teal)

                Text("Đơn hàng #\(orderNumber)")
                    .font(.headline)

                Spacer()
            }

            Divider()

            // Products in the order
            ForEach(items) { item in
                HStack(spacing: 12) {

                    Image(item.product.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 65, height: 65)
                        .clipped()
                        .clipShape(
                            RoundedRectangle(cornerRadius: 8)
                        )

                    VStack(alignment: .leading, spacing: 5) {
                        Text(item.product.name)
                            .font(.subheadline)
                            .fontWeight(.semibold)

                        Text("Số lượng: \(item.quantity)")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        Text(item.formattedSubtotal)
                            .font(.subheadline)
                            .foregroundStyle(.teal)
                    }

                    Spacer()
                }
            }

            Divider()

            // Calculate order total
            let total = items.reduce(0.0) {
                $0 + $1.subtotal
            }

            HStack {
                Text("Tổng thanh toán")
                    .font(.headline)

                Spacer()

                Text(
                    total,
                    format: .currency(code: "VND")
                        .precision(.fractionLength(0))
                )
                .font(.headline)
                .foregroundStyle(.teal)
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
    OrdersView()
}

 
