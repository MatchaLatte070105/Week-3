//
//  ProfileView.swift
//  Week 3
//
//  Created by MAY 04 on 5/10/26.
//

import SwiftUI

struct ProfileView: View {

    @StateObject private var viewModel = AuthViewModel()
    @ObservedObject private var storage = AppStorageManager.shared

    @State private var showLogoutAlert = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {

                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 90))
                    .foregroundStyle(.teal)

                Text(storage.username)
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Tài khoản của tôi")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Divider()

                Button {
                    showLogoutAlert = true
                } label: {
                    Label(
                        "Đăng xuất",
                        systemImage: "rectangle.portrait.and.arrow.right"
                    )
                    .font(.headline)
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .background(
                    Color(.secondarySystemBackground),
                    in: RoundedRectangle(cornerRadius: 12)
                )

                Spacer()
            }
            .padding(24)
            .navigationTitle("Tài khoản")
            .alert(
                "Đăng xuất?",
                isPresented: $showLogoutAlert
            ) {
                Button("Hủy", role: .cancel) {}

                Button("Đăng xuất", role: .destructive) {
                    viewModel.logout()
                }
            } message: {
                Text("Bạn có chắc muốn đăng xuất?")
            }
        }
    }
}

#Preview {
    ProfileView()
}

 
