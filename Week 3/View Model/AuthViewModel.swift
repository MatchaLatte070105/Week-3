
import Foundation
import Combine

class AuthViewModel: ObservableObject {

    // Login form data
    @Published var username: String = "week3"
    @Published var password: String = "123"

    // Error handling
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false

    // Existing controller
    private let storage = AppStorageManager.shared

    // Validate login credentials
    func login() {
        if username == "week3" && password == "123" {

            // Save successful login
            storage.saveLoginState(username: username)

            // Clear previous errors
            errorMessage = ""
            showError = false

        } else {
            errorMessage = "Tên đăng nhập hoặc mật khẩu không đúng."
            showError = true
        }
    }

    // Log out
    func logout() {
        storage.clearLoginState()

        // Reset login form
        username = "week3"
        password = "123"

        errorMessage = ""
        showError = false
    }
}
