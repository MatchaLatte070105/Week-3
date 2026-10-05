import Foundation

struct CartItem: Identifiable, Hashable, Codable {
    let id: UUID
    var product: Product
    var quantity: Int
    
    init(id: UUID = UUID(), product: Product, quantity: Int = 1) {
        self.id = id
        self.product = product
        self.quantity = quantity
    }
    
    var subtotal: Double {
        return product.price * Double(quantity)
    }
    
    var formattedSubtotal: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "VND"
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: subtotal)) ?? "\(Int(subtotal))đ"
    }
}
