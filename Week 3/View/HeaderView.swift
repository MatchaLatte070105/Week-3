//
//  HeaderView.swift
//  Week 3
//
//  Created by MAY 04 on 5/10/26.
//

import SwiftUI

struct HeaderView: View {

    @ObservedObject private var storage = AppStorageManager.shared

    var onCartTap: () -> Void

    var body: some View {
        HStack(spacing: 12) {

            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 40))
                .foregroundStyle(.teal)

            VStack(alignment: .leading, spacing: 4) {
                Text("Cá Cảnh Xinh Xinh")
                    .font(.headline)
                    .fontWeight(.bold)

                Text("Xin chào, \(storage.username)!")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                // Notifications not implemented yet
            } label: {
                Image(systemName: "bell")
                    .font(.title3)
            }

            Button {
                onCartTap()
            } label: {
                Image(systemName: "cart")
                    .font(.title3)
            }
        }
        .foregroundStyle(.primary)
        .padding(.horizontal)
        .padding(.vertical, 12)
    }
}

#Preview {
    HeaderView(onCartTap: {})
}

 
