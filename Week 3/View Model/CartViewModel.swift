
import Foundation
import Combine

class CartViewModel: ObservableObject {

    @Published var items: [CartItem] = []

    // Total number of products in the cart
    var totalItems: Int {
        items.reduce(0) { $0 + $1.quantity }
    }

    // Total price of all products
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.subtotal }
    }

    // Add a product to the cart
    func addToCart(_ product: Product) {
        if let index = items.firstIndex(where: {
            $0.product.id == product.id
        }) {
            items[index].quantity += 1
        } else {
            items.append(
                CartItem(product: product, quantity: 1)
            )
        }
    }

    // Increase quantity
    func increaseQuantity(for item: CartItem) {
        guard let index = items.firstIndex(where: {
            $0.id == item.id
        }) else { return }

        items[index].quantity += 1
    }

    // Decrease quantity
    func decreaseQuantity(for item: CartItem) {
        guard let index = items.firstIndex(where: {
            $0.id == item.id
        }) else { return }

        if items[index].quantity > 1 {
            items[index].quantity -= 1
        } else {
            removeItem(item)
        }
    }

    // Remove an item from the cart
    func removeItem(_ item: CartItem) {
        items.removeAll { $0.id == item.id }
    }

    // Clear cart after successful checkout
    func clearCart() {
        items.removeAll()
    }
}
