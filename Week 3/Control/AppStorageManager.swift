import Foundation
import Combine

class AppStorageManager: ObservableObject {
    static let shared = AppStorageManager()
    
    // Lưu trạng thái đã đăng nhập hay chưa
    @Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        }
    }
    
    // Lưu username (Mặc định: week3)
    @Published var username: String {
        didSet {
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
    
    private init() {
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        self.username = UserDefaults.standard.string(forKey: "username") ?? "week3"
    }
    
    func saveLoginState(username: String) {
        self.username = username
        self.isLoggedIn = true
    }
    
    func clearLoginState() {
        self.isLoggedIn = false
        self.username = "week3"
    }
}
