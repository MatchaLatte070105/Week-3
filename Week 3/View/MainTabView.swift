//
//  MainTabView.swift
//  Week 3
//
//  Created by MAY 04 on 5/10/26.
//

import SwiftUI

struct MainTabView: View {

    @StateObject private var cartViewModel = CartViewModel()
    @StateObject private var favoritesViewModel = FavoritesViewModel()

    var body: some View {
        TabView {

            HomeView()
                .tabItem {
                    Label("Trang chủ", systemImage: "house.fill")
                }

            CategoryView()
                .tabItem {
                    Label("Danh mục", systemImage: "square.grid.2x2")
                }

            FavoritesView()
                .tabItem {
                    Label("Yêu thích", systemImage: "heart.fill")
                }

            OrdersView()
                .tabItem {
                    Label("Đơn hàng", systemImage: "shippingbox")
                }

            ProfileView()
                .tabItem {
                    Label("Tài khoản", systemImage: "person.fill")
                }
        }
        .tint(.teal)
        .environmentObject(cartViewModel)
        .environmentObject(favoritesViewModel)
    }
}

#Preview {
    MainTabView()
}


 
