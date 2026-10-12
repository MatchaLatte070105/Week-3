
import Foundation
import Combine
import PhotosUI
import UIKit

class SearchViewModel: ObservableObject {

    // Text entered in the search bar
    @Published var searchText: String = ""

    // Search results
    @Published private(set) var searchResults: [Product] = []

    // Selected image from photo library
    @Published var selectedImage: UIImage?

    // Display the photo picker
    @Published var showImagePicker: Bool = false

    // Existing controller
    private let imageSearchManager = ImageSearchManager.shared

    // Search products by text
    func searchProducts(in products: [Product]) {
        searchResults = imageSearchManager.searchProducts(
            keyword: searchText,
            in: products
        )
    }

    // Reset search
    func clearSearch(in products: [Product]) {
        searchText = ""
        selectedImage = nil
        searchResults = products
    }

    // Open the photo picker
    func openImagePicker() {
        showImagePicker = true
    }

    // Store a selected image
    func setSelectedImage(_ image: UIImage) {
        selectedImage = image
    }
}
