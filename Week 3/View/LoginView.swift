//
//  LoginView.swift
//  Week 3
//
//  Created by MAY 04 on 5/10/26.
//

import SwiftUI

struct LoginView: View {

    @StateObject private var viewModel = AuthViewModel()

    var body: some View {
        VStack(spacing: 24) {

            Spacer()

            // MARK: - Logo
            Image(systemName: "fish.fill")
                .font(.system(size: 80))
                .foregroundStyle(.teal)
                .padding(25)
                .background(
                    Circle()
                        .fill(Color.teal.opacity(0.1))
                )

            // MARK: - App Title
            VStack(spacing: 8) {
                Text("Cá Cảnh Xinh Xinh")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.teal)

                Text("Thế giới cá cảnh trong tay bạn")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            // MARK: - Login Form
            VStack(spacing: 16) {

                TextField(
                    "Tên đăng nhập",
                    text: $viewModel.username
                )
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding()
                .background(
                    Color(.secondarySystemBackground),
                    in: RoundedRectangle(cornerRadius: 12)
                )

                SecureField(
                    "Mật khẩu",
                    text: $viewModel.password
                )
                .padding()
                .background(
                    Color(.secondarySystemBackground),
                    in: RoundedRectangle(cornerRadius: 12)
                )

                // MARK: - Login Button
                Button {
                    viewModel.login()
                } label: {
                    Text("Đăng nhập")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(.borderedProminent)
                .tint(.teal)
            }
            .padding(.top, 20)

            Spacer()

            Text("Tài khoản mặc định: week3 / 123")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(24)

        // MARK: - Error Alert
        .alert(
            "Đăng nhập thất bại",
            isPresented: $viewModel.showError
        ) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}

#Preview {
    LoginView()
}

 
