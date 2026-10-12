import SwiftUI



@main

struct Week3App: App {



    @StateObject private var storage = AppStorageManager.shared



    var body: some Scene {

        WindowGroup {

            if storage.isLoggedIn {

                MainTabView()

            } else {

                LoginView()

            }

        }

    }

}