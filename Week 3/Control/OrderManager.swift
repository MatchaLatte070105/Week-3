import Foundation
import Combine

class OrderManager: ObservableObject {
    static let shared = OrderManager()
    
    // Danh sách lưu trữ tất cả các đơn hàng đã chốt
    @Published var orderHistory: [[CartItem]] = []
    
    private init() {}
    
    // Thêm đơn hàng mới sau khi bấm Đặt hàng thành công
    func addNewOrder(items: [CartItem]) {
        guard !items.isEmpty else { return }
        orderHistory.insert(items, at: 0) // Đưa đơn mới nhất lên đầu
    }
    
    // Lấy tổng số đơn hàng đã đặt
    var totalOrdersCount: Int {
        return orderHistory.count
    }
}
