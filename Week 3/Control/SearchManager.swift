import Foundation
import Combine

class ImageSearchManager: ObservableObject {
    static let shared = ImageSearchManager()
    
    private init() {}
    
    // Tìm kiếm cá/cây/bể cảnh theo tên, mô tả hoặc danh mục
    func searchProducts(keyword: String, in products: [Product]) -> [Product] {
        let trimmedKeyword = keyword.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedKeyword.isEmpty else {
            return products
        }
        
        return products.filter { product in
            product.name.localizedCaseInsensitiveContains(trimmedKeyword) ||
            product.description.localizedCaseInsensitiveContains(trimmedKeyword) ||
            product.category.localizedCaseInsensitiveContains(trimmedKeyword)
        }
    }
}
