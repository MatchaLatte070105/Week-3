
import Foundation
import Combine

class FavoritesViewModel: ObservableObject {

    // Store the IDs of favorite products
    @Published private(set) var favoriteProductIDs: Set<UUID> = []

    // Check whether a product is a favorite
    func isFavorite(_ product: Product) -> Bool {
        favoriteProductIDs.contains(product.id)
    }

    // Add or remove a product from favorites
    func toggleFavorite(_ product: Product) {
        if favoriteProductIDs.contains(product.id) {
            favoriteProductIDs.remove(product.id)
        } else {
            favoriteProductIDs.insert(product.id)
        }
    }

    // Get all favorite products from the product list
    func getFavoriteProducts(from products: [Product]) -> [Product] {
        products.filter { favoriteProductIDs.contains($0.id) }
    }

    // Remove all favorites
    func clearFavorites() {
        favoriteProductIDs.removeAll()
    }
}
