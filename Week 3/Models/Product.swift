import Foundation

struct Product: Identifiable, Hashable, Codable {
    let id: UUID
    var name: String
    var description: String
    var price: Double
    var imageName: String
    var category: String
    var rating: Double
    var isFavorite: Bool
    
    init(id: UUID = UUID(), name: String, description: String, price: Double, imageName: String, category: String, rating: Double = 5.0, isFavorite: Bool = false) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.imageName = imageName
        self.category = category
        self.rating = rating
        self.isFavorite = isFavorite
    }
    
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "VND"
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: price)) ?? "\(Int(price))đ"
    }
}
