//
//  CheckoutView.swift
//  Week 3
//
//  Created by MAY 04 on 5/10/26.
//


import SwiftUI

struct CheckoutView: View {

    @EnvironmentObject var cartViewModel: CartViewModel
    @Environment(\.dismiss) private var dismiss

    @ObservedObject private var orderManager = OrderManager.shared

    // Passed from CartView
    let totalAmount: Double

    // Existing ShippingAddress model
    @State private var address = ShippingAddress()

    @State private var paymentMethod = "COD"
    @State private var showSuccessAlert = false

    private let paymentMethods = [
        "COD",
        "Chuyển khoản ngân hàng"
    ]

    // Check whether the shipping form is complete
    private var isFormValid: Bool {
        !address.fullName.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty &&
        !address.phoneNumber.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty &&
        !address.streetAddress.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty &&
        !address.ward.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty &&
        !address.district.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty &&
        !address.city.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty
    }

    var body: some View {
        Form {

            // MARK: - Shipping Information
            Section("Thông tin người nhận") {

                TextField(
                    "Họ và tên",
                    text: $address.fullName
                )

                TextField(
                    "Số điện thoại",
                    text: $address.phoneNumber
                )
                .keyboardType(.phonePad)

            }

            // MARK: - Shipping Address
            Section("Địa chỉ giao hàng") {

                TextField(
                    "Tỉnh / Thành phố",
                    text: $address.city
                )

                TextField(
                    "Quận / Huyện",
                    text: $address.district
                )

                TextField(
                    "Phường / Xã",
                    text: $address.ward
                )

                TextField(
                    "Số nhà, tên đường",
                    text: $address.streetAddress
                )

            }

            // MARK: - Payment Method
            Section("Phương thức thanh toán") {

                Picker(
                    "Thanh toán",
                    selection: $paymentMethod
                ) {
                    ForEach(paymentMethods, id: \.self) { method in
                        Text(method)
                    }
                }
            }

            // MARK: - Order Summary
            Section("Thông tin đơn hàng") {

                HStack {
                    Text("Số lượng sản phẩm")
                    Spacer()
                    Text("\(cartViewModel.totalItems)")
                }

                HStack {
                    Text("Tổng thanh toán")
                    Spacer()
                    Text(
                        cartViewModel.totalPrice,
                        format: .currency(code: "VND")
                            .precision(.fractionLength(0))
                    )
                    .fontWeight(.bold)
                    .foregroundStyle(.teal)
                }
            }

            // MARK: - Place Order
            Section {
                Button {
                    placeOrder()
                } label: {
                    Text("Đặt hàng")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .disabled(
                    !isFormValid || cartViewModel.items.isEmpty
                )
            }
        }
        .navigationTitle("Thanh toán")
        .navigationBarTitleDisplayMode(.inline)

        // MARK: - Success Alert
        .alert(
            "Đặt hàng thành công!",
            isPresented: $showSuccessAlert
        ) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Đơn hàng của bạn đã được ghi nhận.")
        }
    }

    // MARK: - Place Order Logic
    private func placeOrder() {

        guard isFormValid,
              !cartViewModel.items.isEmpty else {
            return
        }

        // Save order to existing OrderManager
        orderManager.addNewOrder(
            items: cartViewModel.items
        )

        // Clear cart after successful order
        cartViewModel.clearCart()

        // Show confirmation
        showSuccessAlert = true
    }
}

#Preview {
    NavigationStack {
        CheckoutView(totalAmount: 0)
    }
    .environmentObject(CartViewModel())
}


 
